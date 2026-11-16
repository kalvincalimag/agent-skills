#!/usr/bin/env bash
# Checks a handoff pickup note for references a fresh session would trip on.
#
# Usage: bash check-note.sh NOTE [ROOT ...]
#
# Each ROOT is a folder that repository-relative paths in the note resolve
# against, such as the brain and each code repository. With no ROOT, the Git
# top level of the note's folder is used, or the note's folder itself.
#
# Fails on a path or link that does not exist, a commit hash that no ROOT
# repository has, a template comment or placeholder left in, and a core section
# that is missing or empty. Fenced code blocks are skipped, because they hold
# commands.
#
# A path is an inline code span with a slash in it that names a file with an
# extension (`src/app.ts`), ends in a slash (`docs/`), or starts with `./`,
# `../`, `/`, or `~/`. A trailing `:12` or `#anchor` is ignored. Spans with
# spaces are commands and are not checked, and so are branch names such as
# `origin/main`. A commit is an inline code span of 7 to 40 hex characters with
# at least one letter and one digit. Markdown links resolve against the note's
# folder.
# Needs bash 3.2 or later and POSIX awk.
set -uo pipefail

usage() { printf 'usage: bash check-note.sh NOTE [ROOT ...]\n' >&2; exit 2; }
[[ $# -ge 1 && -f "$1" ]] || usage

note="$1"
shift
note_dir="$(cd "$(dirname "$note")" && pwd)"
if [[ $# -eq 0 ]]; then
  set -- "$(git -C "$note_dir" rev-parse --show-toplevel 2>/dev/null || printf '%s' "$note_dir")"
fi
roots=("$@")

required_sections=("How to pick this up" "End goal" "As of" "State" "Next steps" "Fixed decisions" "Fences")

failures=0
paths=0
links=0
commits=0
commits_skipped=0
headings=$'\n'
filled=$'\n'

fail() { printf '%s:%s: %s\n' "$note" "$1" "$2" >&2; failures=$((failures + 1)); }

# Prints one record per finding: line number, kind, value, separated by tabs.
# Kinds: heading, content (the first line of content under a heading), code
# (an inline code span), link (a markdown link target), comment (an HTML
# comment), placeholder (an <angle-bracket> slot in prose).
read -r -d '' parse <<'AWK'
function mark() {
  if (cur != "" && !(cur in seen)) { seen[cur] = 1; print NR "\tcontent\t" cur }
}
BEGIN { fence = 0; incomment = 0; cur = "" }
{
  sub(/\r$/, "")
  line = $0
  if (line ~ /^[ \t]*(```|~~~)/) { fence = !fence; mark(); next }
  if (fence) { mark(); next }
  if (incomment) {
    if (index(line, "-->")) incomment = 0
    next
  }
  if (line ~ /^## /) {
    h = substr(line, 4)
    sub(/[ \t]+$/, "", h)
    cur = h
    print NR "\theading\t" h
  }
  body = line
  if (index(body, "<!--")) body = substr(body, 1, index(body, "<!--") - 1)
  if (body ~ /[^ \t]/ && body !~ /^[ \t]*#/) mark()
  n = split(line, parts, "`")
  prose = ""
  for (i = 1; i <= n; i++) {
    if (i % 2 == 0 && i < n) print NR "\tcode\t" parts[i]
    else prose = prose " " parts[i]
  }
  c = index(prose, "<!--")
  if (c) {
    print NR "\tcomment\t-"
    if (!index(substr(prose, c), "-->")) incomment = 1
    prose = substr(prose, 1, c - 1)
  }
  rest = prose
  while (match(rest, /][(][^)]+[)]/)) {
    print NR "\tlink\t" substr(rest, RSTART + 2, RLENGTH - 3)
    rest = substr(rest, RSTART + RLENGTH)
  }
  rest = prose
  while (match(rest, /<[A-Za-z][^<>]*>/)) {
    tok = substr(rest, RSTART, RLENGTH)
    if (tok !~ /^<(https?:|mailto:)/ && tok !~ /^<(br|details|summary|sub|sup|kbd|img|a|p|div|span|b|i|em|strong|code|pre|table|thead|tbody|tr|td|th|ul|ol|li)([ \t][^>]*)?\/?>$/)
      print NR "\tplaceholder\t" tok
    rest = substr(rest, RSTART + RLENGTH)
  }
}
AWK

# True when the token is a path to check rather than a branch, a package, a
# host name, or a command.
is_path() {
  local t="$1" first last
  local domain_re='^[A-Za-z0-9-]+\.[A-Za-z]{2,}$' ext_re='\.[A-Za-z][A-Za-z0-9]{0,7}$'
  case "$t" in
    *://* | @* | -* | *[\<\>\*\?\{\}\$\|\;\,\=\"\']* | *:*) return 1 ;;
    */*) ;;
    *) return 1 ;;
  esac
  case "$t" in
    ./* | ../* | /* | "~/"* | */) return 0 ;;
  esac
  first="${t%%/*}"
  [[ "$first" =~ $domain_re ]] && return 1
  last="${t##*/}"
  [[ "$last" =~ $ext_re ]]
}

exists_anywhere() {
  local p="$1" r
  case "$p" in
    "~/"*) p="$HOME/${p#\~/}" ;;
  esac
  case "$p" in
    /*) [[ -e "$p" ]]; return ;;
  esac
  [[ -e "$note_dir/$p" ]] && return 0
  for r in "${roots[@]}"; do
    [[ -e "$r/$p" ]] && return 0
  done
  return 1
}

# Returns 0 when a root repository has the commit, 1 when none has it, and 2
# when no root is a Git repository.
commit_known() {
  local r searched=0
  for r in "${roots[@]}"; do
    git -C "$r" rev-parse --git-dir >/dev/null 2>&1 || continue
    searched=1
    git -C "$r" cat-file -e "$1^{commit}" 2>/dev/null && return 0
  done
  [[ $searched -eq 1 ]] && return 1
  return 2
}

hash_re='^[0-9a-f]{7,40}$'
while IFS=$'\t' read -r lineno kind value; do
  case "$kind" in
    heading)
      headings="$headings$value"$'\n'
      ;;
    content)
      filled="$filled$value"$'\n'
      ;;
    comment)
      fail "$lineno" "template comment left in"
      ;;
    placeholder)
      fail "$lineno" "placeholder left in: $value"
      ;;
    code)
      value="$(printf '%s' "$value" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
      [[ -z "$value" ]] && continue
      case "$value" in
        "<"*">") fail "$lineno" "placeholder left in: \`$value\`"; continue ;;
        *[[:space:]]*) continue ;;
      esac
      if [[ "$value" =~ $hash_re && "$value" == *[a-f]* && "$value" == *[0-9]* ]]; then
        commit_known "$value"
        case $? in
          0) commits=$((commits + 1)) ;;
          1) fail "$lineno" "commit not found in any root repository: $value" ;;
          2) commits_skipped=$((commits_skipped + 1)) ;;
        esac
        continue
      fi
      value="$(printf '%s' "$value" | sed -E 's/#.*$//; s/:[0-9]+(-[0-9]+)?$//')"
      if is_path "$value"; then
        paths=$((paths + 1))
        exists_anywhere "$value" || fail "$lineno" "path not found: $value"
      fi
      ;;
    link)
      target="$(printf '%s' "$value" | sed -E 's/^<//; s/>$//; s/[[:space:]]+".*"$//; s/#.*$//; s/%20/ /g')"
      case "$target" in
        "" | http:* | https:* | mailto:* | tel:*) continue ;;
      esac
      links=$((links + 1))
      case "$target" in
        /*) [[ -e "$target" ]] || fail "$lineno" "link target not found: $value" ;;
        *) [[ -e "$note_dir/$target" ]] || fail "$lineno" "link target not found: $value" ;;
      esac
      ;;
  esac
done < <(awk "$parse" "$note")

for section in "${required_sections[@]}"; do
  if [[ "$headings" != *$'\n'"$section"$'\n'* ]]; then
    fail 0 "missing section: ## $section"
  elif [[ "$filled" != *$'\n'"$section"$'\n'* ]]; then
    fail 0 "empty section: ## $section"
  fi
done

if [[ $commits_skipped -gt 0 ]]; then
  printf 'note: %s commit hash(es) not checked, because no root is a Git repository\n' "$commits_skipped"
fi
if [[ $failures -gt 0 ]]; then
  printf 'note check failed with %s issue(s)\n' "$failures" >&2
  exit 1
fi
printf 'note check passed: %s path(s), %s link(s), %s commit(s)\n' "$paths" "$links" "$commits"
