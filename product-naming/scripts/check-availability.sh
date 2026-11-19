#!/usr/bin/env bash
# Checks whether a candidate name is free on domains, package registries,
# GitHub, the App Store, and Telegram. It only sends GET requests and
# registers nothing.
#
# Usage: bash check-availability.sh <name> [platform...]
#   Platforms: domains github npm pypi crates rubygems wp appstore telegram
#   With no platform, it checks domains, github, and npm.
#   domains checks .com .dev .app .io .co .sh. Set TLDS to change the list,
#   for example TLDS="com ai" bash check-availability.sh getacme domains
#
# Each line starts with AVAILABLE, TAKEN, or UNCLEAR. UNCLEAR means the check
# could not decide, so confirm that platform by hand. Results are a snapshot
# of the date printed in the header.
#
# Needs bash and curl. Domains use RDAP through rdap.org, then DNS over HTTPS
# for domains whose registry has no RDAP service, such as .io, .co, and .sh.
set -uo pipefail

ua="product-naming-skill (availability check)"
known="domains github npm pypi crates rubygems wp appstore telegram"

name="$(printf '%s' "${1:-}" | tr '[:upper:]' '[:lower:]')"
if [[ ! "$name" =~ ^[a-z0-9]([a-z0-9-]*[a-z0-9])?$ ]]; then
  echo "usage: check-availability.sh <name> [platform...]" >&2
  echo "The name must be letters, digits, and inner hyphens. Platforms: $known" >&2
  exit 2
fi
shift
platforms=("$@")
((${#platforms[@]})) || platforms=(domains github npm)
read -r -a tlds <<<"${TLDS:-com dev app io co sh}"

line() { printf '%-9s  %s\n' "$1" "$2"; }

# Prints the HTTP status of a GET request, or 000 when it fails.
status() {
  local code
  code="$(curl -s -A "$ua" -o /dev/null -w '%{http_code}' --max-time 20 "$1" 2>/dev/null)"
  printf '%s' "${code:-000}"
}

# Reports a URL where 404 means the name is free and 200 means it is taken.
by_status() { # label, url
  local code
  code="$(status "$2")"
  case "$code" in
    404) line AVAILABLE "$1" ;;
    200) line TAKEN "$1" ;;
    *) line UNCLEAR "$1 (HTTP $code)" ;;
  esac
}

domain() { # fully qualified domain
  local out code redirects dns
  # rdap.org redirects to the registry's RDAP server. Without a redirect, the
  # registry has no RDAP service and the 404 comes from rdap.org itself.
  out="$(curl -sL -A "$ua" -o /dev/null -w '%{http_code} %{num_redirects}' --max-time 20 \
    "https://rdap.org/domain/$1" 2>/dev/null)"
  read -r code redirects <<<"${out:-000 0}"
  [[ "$redirects" =~ ^[0-9]+$ ]] || redirects=0
  if ((redirects > 0)); then
    case "$code" in
      404) line AVAILABLE "$1"; return ;;
      200) line TAKEN "$1"; return ;;
    esac
  fi
  # A registered domain almost always has name servers.
  dns="$(curl -s -A "$ua" --max-time 20 "https://dns.google/resolve?name=$1&type=NS" 2>/dev/null |
    grep -oE '"Status": ?[0-9]+' | grep -oE '[0-9]+$')"
  case "$dns" in
    0) line TAKEN "$1 (has name servers)" ;;
    3) line UNCLEAR "$1 (no registry answer and no name servers, so probably free; confirm at a registrar)" ;;
    *) line UNCLEAR "$1 (no registry or DNS answer)" ;;
  esac
}

wordpress() {
  local body
  body="$(curl -s -A "$ua" --max-time 20 \
    "https://api.wordpress.org/plugins/info/1.2/?action=plugin_information&slug=$name" 2>/dev/null)"
  if grep -q '"slug"' <<<"$body"; then
    line TAKEN "WordPress plugin: $name"
  elif grep -qi 'not found' <<<"$body"; then
    line AVAILABLE "WordPress plugin: $name"
  else
    line UNCLEAR "WordPress plugin: $name"
  fi
}

# The App Store search is fuzzy, so only app names that start with the
# candidate count. A hyphen in the candidate matches a space, a hyphen, or nothing.
appstore() {
  local body pattern matches
  body="$(curl -s -A "$ua" --max-time 20 \
    "https://itunes.apple.com/search?term=$name&entity=software&limit=200" 2>/dev/null)"
  if ! grep -q '"resultCount"' <<<"$body"; then
    line UNCLEAR "App Store (US): $name"
    return
  fi
  pattern="^${name//-/[ -]?}([^[:alnum:]]|$)"
  matches="$(grep -oE '"trackName":"[^"]*"' <<<"$body" | cut -d'"' -f4 |
    grep -iE "$pattern" | sort -u | head -5 | paste -sd ';' -)"
  if [[ -n "$matches" ]]; then
    line TAKEN "App Store (US): ${matches//;/; }"
  else
    line AVAILABLE "App Store (US): no app name starts with $name"
  fi
}

telegram() {
  local body
  body="$(curl -sL -A "$ua" --max-time 20 "https://t.me/$name" 2>/dev/null)"
  if grep -q 'tgme_page_title' <<<"$body"; then
    line TAKEN "Telegram: @$name"
  else
    line UNCLEAR "Telegram: @$name (no public page; check in the app)"
  fi
}

printf 'Availability of "%s" on %s (UTC)\n' "$name" "$(date -u +%Y-%m-%d)"
for platform in "${platforms[@]}"; do
  case "$platform" in
    domains)
      for tld in "${tlds[@]}"; do
        if [[ "$tld" =~ ^[a-z0-9-]+$ ]]; then domain "$name.$tld"; else echo "skipped invalid TLD: $tld" >&2; fi
      done
      ;;
    github) by_status "GitHub user or org: $name" "https://github.com/$name" ;;
    npm) by_status "npm: $name" "https://registry.npmjs.org/$name" ;;
    pypi) by_status "PyPI: $name" "https://pypi.org/pypi/$name/json" ;;
    crates) by_status "crates.io: $name" "https://crates.io/api/v1/crates/$name" ;;
    rubygems) by_status "RubyGems: $name" "https://rubygems.org/api/v1/gems/$name.json" ;;
    wp) wordpress ;;
    appstore) appstore ;;
    telegram) telegram ;;
    *) echo "unknown platform: $platform (known: $known)" >&2 ;;
  esac
done
