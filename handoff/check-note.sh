#!/usr/bin/env bash
# Checks a handoff pickup note for references a fresh session would trip on.
#
# Usage: bash check-note.sh [--remote] NOTE [ROOT ...]
#
# Each ROOT is a folder that repository-relative paths in the note resolve
# against, such as the brain and each code repository. With no ROOT, the Git
# top level of the note's folder is used, or the note's folder itself.
#
# Fails on a path or link that does not exist, a commit hash that no ROOT
# repository has, an "As of" row whose commit or working tree no longer matches
# the repository at its location, a template comment or placeholder left in, and
# a core section that is missing or empty. Fenced code blocks are skipped,
# because they hold commands. The "As of" comparison leaves out the note itself,
# because saving the note changes the repository that holds it. A row whose
# commit or working tree is "-" is not compared on that column.
#
# With --remote, for a handoff to another machine, it also fails on what the
# next machine cannot get: a path or link missing from its repository's upstream
# branch, a commit on no remote branch, an "As of" repository with no upstream,
# unpushed commits, or uncommitted changes, and a note that differs from its
# pushed copy. Paths under "As of" and "What does not travel" are exempt,
# because they name local things on purpose.
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

usage() { printf 'usage: bash check-note.sh [--remote] NOTE [ROOT ...]\n' >&2; exit 2; }
remote=0
if [[ "${1:-}" == --remote ]]; then
  remote=1
  shift
fi
[[ $# -ge 1 && -f "$1" ]] || usage

note="$1"
shift
note_dir="$(cd "$(dirname "$note")" && pwd)"
note_name="$(basename "$note")"
if [[ $# -eq 0 ]]; then
  set -- "$(git -C "$note_dir" rev-parse --show-toplevel 2>/dev/null || printf '%s' "$note_dir")"
fi
roots=("$@")

required_sections=("How to pick this up" "End goal" "As of" "State" "Next steps" "Fixed decisions" "Fences")
local_sections=$'\nAs of\nWhat does not travel\n'

failures=0
paths=0
links=0
commits=0
commits_skipped=0
rows=0
headings=$'\n'
filled=$'\n'

fail() { printf '%s:%s: %s\n' "$note" "$1" "$2" >&2; failures=$((failures + 1)); }

# Prints one record per finding: line number, kind, section, value, separated
# by tabs. Kinds: heading, content (the first line of content under a heading),
# code (an inline code span), link (a markdown link target), comment (an HTML
# comment), placeholder (an <angle-bracket> slot in prose), asof (an "As of"
# row as location, commit, and working tree, separated by \037). The working
# tree is "clean", "dirty", or "-".
read -r -d '' parse <<'AWK'
function emit(kind, value) { print NR "\t" kind "\t" (cur == "" ? "-" : cur) "\t" value }
function mark() {
  if (cur != "" && !(cur in seen)) { seen[cur] = 1; emit("content", cur) }
}
# The first row of the table is its header and says which column is which.
function as_of_row(line,    n, i, cell, tree) {
  n = split(line, cells, "|")
  for (i = 1; i <= n; i++) {
    cell = cells[i]
    gsub(/`/, "", cell)
    gsub(/^[ \t]+|[ \t]+$/, "", cell)
    cells[i] = cell
  }
  if (!table) {
    table = 1
    col_location = col_commit = col_tree = 0
    for (i = 1; i <= n; i++) {
      if (cells[i] == "Location") col_location = i
      else if (cells[i] == "Commit") col_commit = i
      else if (cells[i] == "Working tree") col_tree = i
    }
    return
  }
  if (line ~ /^[ \t|:-]+$/ || !col_location || !col_commit || !col_tree) return
  tree = tolower(cells[col_tree])
  if (tree == "") tree = "-"
  else if (tree != "clean" && tree != "-") tree = "dirty"
  emit("asof", cells[col_location] "\037" cells[col_commit] "\037" tree)
}
BEGIN { fence = 0; incomment = 0; table = 0; cur = "" }
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
    emit("heading", h)
  }
  if (line !~ /^[ \t]*\|/) table = 0
  else if (cur == "As of") as_of_row(line)
  body = line
  if (index(body, "<!--")) body = substr(body, 1, index(body, "<!--") - 1)
  if (body ~ /[^ \t]/ && body !~ /^[ \t]*#/) mark()
  n = split(line, parts, "`")
  prose = ""
  for (i = 1; i <= n; i++) {
    if (i % 2 == 0 && i < n) emit("code", parts[i])
    else prose = prose " " parts[i]
  }
  c = index(prose, "<!--")
  if (c) {
    emit("comment", "-")
    if (!index(substr(prose, c), "-->")) incomment = 1
    prose = substr(prose, 1, c - 1)
  }
  rest = prose
  while (match(rest, /][(][^)]+[)]/)) {
    emit("link", substr(rest, RSTART + 2, RLENGTH - 3))
    rest = substr(rest, RSTART + RLENGTH)
  }
  rest = prose
  while (match(rest, /<[A-Za-z][^<>]*>/)) {
    tok = substr(rest, RSTART, RLENGTH)
    if (tok !~ /^<(https?:|mailto:)/ && tok !~ /^<(br|details|summary|sub|sup|kbd|img|a|p|div|span|b|i|em|strong|code|pre|table|thead|tbody|tr|td|th|ul|ol|li)([ \t][^>]*)?\/?>$/)
      emit("placeholder", tok)
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

# Prints where a path exists: as written when absolute, otherwise under the
# note's folder or the first ROOT that has it. Prints nothing when none has it.
find_path() {
  local p="$1" r
  case "$p" in
    "~/"*) p="$HOME/${p#\~/}" ;;
  esac
  case "$p" in
    /*)
      [[ -e "$p" ]] && printf '%s' "$p"
      return 0
      ;;
  esac
  for r in "$note_dir" "${roots[@]}"; do
    if [[ -e "$r/$p" ]]; then
      printf '%s' "$r/$p"
      return 0
    fi
  done
}

# Prints why another machine cannot get the file or folder at an existing path,
# or nothing when the upstream branch of its repository has it.
unpushed_reason() {
  local path="$1" dir top upstream rel
  if [[ -d "$path" ]]; then dir="$path"; else dir="$(dirname "$path")"; fi
  if ! top="$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null)"; then
    printf 'is in no repository'
    return 0
  fi
  if ! upstream="$(git -C "$top" rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)"; then
    printf 'is in %s, whose branch has no upstream' "$top"
    return 0
  fi
  rel="$(git -C "$dir" rev-parse --show-prefix)"
  [[ -d "$path" ]] || rel="$rel$(basename "$path")"
  rel="${rel%/}"
  [[ -z "$rel" ]] && return 0
  git -C "$top" cat-file -e "$upstream:$rel" 2>/dev/null || printf 'is not in %s' "$upstream"
}

# With --remote, fails when another machine cannot get a path the note names.
check_pushed() {
  local lineno="$1" section="$2" shown="$3" path="$4" reason
  [[ $remote -eq 1 && "$local_sections" != *$'\n'"$section"$'\n'* ]] || return 0
  reason="$(unpushed_reason "$path")"
  [[ -z "$reason" ]] || fail "$lineno" "not pushed: $shown $reason"
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

# True when a remote-tracking branch of some root contains the commit.
commit_pushed() {
  local r
  for r in "${roots[@]}"; do
    [[ -n "$(git -C "$r" branch -r --contains "$1" 2>/dev/null)" ]] && return 0
  done
  return 1
}

# Compares one "As of" row with the repository at its location. A location that
# is not a local repository is skipped. The path check reports a missing one.
check_as_of() {
  local lineno="$1" location="$2" commit="$3" tree="$4" top recorded dirty ahead
  # The second pathspec leaves out the note when this repository holds it, and
  # repeats "." when it does not.
  local others="."
  case "$location" in
    "~/"*) location="$HOME/${location#\~/}" ;;
  esac
  [[ -d "$location" ]] || return 0
  top="$(git -C "$location" rev-parse --show-toplevel 2>/dev/null)" || return 0
  rows=$((rows + 1))
  if [[ "$(git -C "$note_dir" rev-parse --show-toplevel 2>/dev/null)" == "$top" ]]; then
    others=":(exclude)$(git -C "$note_dir" rev-parse --show-prefix)$note_name"
  fi
  if [[ "$commit" =~ $hash_re ]]; then
    if ! recorded="$(git -C "$top" rev-parse -q --verify "$commit^{commit}")"; then
      fail "$lineno" "As of: $commit is not a commit in $location"
    elif [[ -n "$(git -C "$top" diff --name-only "$recorded" HEAD -- . "$others")" ]]; then
      fail "$lineno" "As of: $location is at $(git -C "$top" rev-parse --short HEAD), not $commit"
    fi
  fi
  dirty="$(git -C "$top" status --porcelain -uall -- . "$others")"
  if [[ -n "$dirty" ]]; then
    if [[ "$tree" == clean ]]; then
      fail "$lineno" "As of: $location has uncommitted changes, but the note says clean"
    elif [[ $remote -eq 1 ]]; then
      fail "$lineno" "As of: $location has uncommitted changes, which stay on this machine"
    fi
  elif [[ "$tree" == dirty ]]; then
    fail "$lineno" "As of: $location is clean, but the note lists changes"
  fi
  [[ $remote -eq 1 ]] || return 0
  if ! git -C "$top" rev-parse -q --verify '@{upstream}' >/dev/null; then
    fail "$lineno" "As of: $location has no upstream branch, so it cannot reach another machine"
    return 0
  fi
  ahead="$(git -C "$top" rev-list --count '@{upstream}..HEAD')"
  [[ "$ahead" -eq 0 ]] || fail "$lineno" "As of: $location has $ahead commit(s) that are not pushed"
}

hash_re='^[0-9a-f]{7,40}$'
while IFS=$'\t' read -r lineno kind section value; do
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
    asof)
      IFS=$'\037' read -r location commit tree <<<"$value"
      check_as_of "$lineno" "$location" "$commit" "$tree"
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
          0)
            commits=$((commits + 1))
            if [[ $remote -eq 1 ]] && ! commit_pushed "$value"; then
              fail "$lineno" "commit not on any remote branch: $value"
            fi
            ;;
          1) fail "$lineno" "commit not found in any root repository: $value" ;;
          2) commits_skipped=$((commits_skipped + 1)) ;;
        esac
        continue
      fi
      value="$(printf '%s' "$value" | sed -E 's/#.*$//; s/:[0-9]+(-[0-9]+)?$//')"
      if is_path "$value"; then
        paths=$((paths + 1))
        found="$(find_path "$value")"
        if [[ -n "$found" ]]; then
          check_pushed "$lineno" "$section" "$value" "$found"
        else
          fail "$lineno" "path not found: $value"
        fi
      fi
      ;;
    link)
      target="$(printf '%s' "$value" | sed -E 's/^<//; s/>$//; s/[[:space:]]+".*"$//; s/#.*$//; s/%20/ /g')"
      case "$target" in
        "" | http:* | https:* | mailto:* | tel:*) continue ;;
      esac
      links=$((links + 1))
      case "$target" in
        /*) found="$target" ;;
        *) found="$note_dir/$target" ;;
      esac
      if [[ -e "$found" ]]; then
        check_pushed "$lineno" "$section" "$target" "$found"
      else
        fail "$lineno" "link target not found: $value"
      fi
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

if [[ $remote -eq 1 ]]; then
  reason="$(unpushed_reason "$note_dir/$note_name")"
  if [[ -n "$reason" ]]; then
    fail 0 "the note $reason"
  elif ! git -C "$note_dir" diff --quiet '@{upstream}' -- "$note_name" 2>/dev/null; then
    fail 0 "the note has changes that are not pushed"
  fi
fi

if [[ $commits_skipped -gt 0 ]]; then
  printf 'note: %s commit hash(es) not checked, because no root is a Git repository\n' "$commits_skipped"
fi
if [[ $failures -gt 0 ]]; then
  printf 'note check failed with %s issue(s)\n' "$failures" >&2
  exit 1
fi
printf 'note check passed: %s path(s), %s link(s), %s commit(s), %s row(s) under "As of"\n' "$paths" "$links" "$commits" "$rows"
