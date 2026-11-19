#!/usr/bin/env bash
# Tests check-availability.sh offline, against a fake curl that serves canned
# answers. Run: bash tests/test-check-availability.sh
set -uo pipefail

script="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/check-availability.sh"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# The fake curl answers by URL. "taken" is registered everywhere and "free"
# nowhere. Domains under .io have no RDAP service, as in reality, so they fall
# back to DNS. crates.io refuses requests without a user agent, as in reality.
cat > "$work/curl" <<'FAKE'
#!/usr/bin/env bash
url="${@: -1}" fmt="" agent="" prev=""
for arg in "$@"; do
  [[ "$prev" == -w ]] && fmt="$arg"
  [[ "$prev" == -A ]] && agent="$arg"
  prev="$arg"
done
code=503 redirects=0 body=""
case "$url" in
  *rdap.org/domain/taken.com) code=200 redirects=1 ;;
  *rdap.org/domain/free.com) code=404 redirects=1 ;;
  *rdap.org/domain/*.io) code=404 redirects=0 ;;
  *dns.google*name=taken.io*) body='{"Status": 0}' ;;
  *dns.google*name=free.io*) body='{"Status": 3}' ;;
  *registry.npmjs.org/taken) code=200 ;;
  *registry.npmjs.org/free) code=404 ;;
  *crates.io/*) if [[ -n "$agent" ]]; then code=404; else code=403; fi ;;
  *itunes.apple.com*) body='{"resultCount":3,"results":[{"trackName":"Taken: Notes"},{"trackName":"Mistaken Identity"},{"trackName":"Freedom Writer"}]}' ;;
esac
if [[ "$fmt" == *num_redirects* ]]; then printf '%s %s' "$code" "$redirects"
elif [[ -n "$fmt" ]]; then printf '%s' "$code"
else printf '%s' "$body"; fi
FAKE
chmod +x "$work/curl"
export PATH="$work:$PATH"

passes=0
failures=0
expect() { # label, pattern, command...
  local label="$1" pattern="$2" output
  shift 2
  output="$("$@" 2>&1)"
  if grep -qE -- "$pattern" <<<"$output"; then
    passes=$((passes + 1))
  else
    failures=$((failures + 1))
    printf 'FAIL: %s\n  wanted: %s\n  got:\n%s\n' "$label" "$pattern" "$output" >&2
  fi
}
run() { TLDS="${TLDS:-com io}" bash "$script" "$@"; }

expect "registered .com is taken" '^TAKEN +taken\.com$' run taken domains
expect "unregistered .com is free" '^AVAILABLE +free\.com$' run free domains
expect ".io without RDAP but with name servers is taken" '^TAKEN +taken\.io \(has name servers\)' run taken domains
expect ".io without RDAP or name servers stays unclear" '^UNCLEAR +free\.io .*probably free' run free domains
expect "npm 200 is taken" '^TAKEN +npm: taken$' run taken npm
expect "npm 404 is free" '^AVAILABLE +npm: free$' run free npm
expect "unexpected status is unclear, never free" '^UNCLEAR +PyPI: free \(HTTP 503\)' run free pypi
expect "crates.io gets a user agent" '^AVAILABLE +crates\.io: free$' run free crates
expect "App Store matches names that start with the candidate" '^TAKEN +App Store \(US\): Taken: Notes$' run taken appstore
expect "App Store ignores the candidate inside other words" '^AVAILABLE +App Store \(US\): no app name starts with free$' run free appstore
expect "names are lowercased" '^AVAILABLE +npm: free$' run FREE npm
expect "shell characters in a name are refused" 'must be letters' run 'free;id' npm
expect "a leading hyphen is refused" 'must be letters' run '-free' npm
expect "unknown platforms are reported" 'unknown platform: myspace' run free myspace
expect "the header carries the check date" '^Availability of "free" on [0-9]{4}-[0-9]{2}-[0-9]{2}' run free npm

if ((failures > 0)); then
  printf '%s passed, %s failed\n' "$passes" "$failures" >&2
  exit 1
fi
printf 'all %s tests passed\n' "$passes"
