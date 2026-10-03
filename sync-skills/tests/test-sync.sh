#!/usr/bin/env bash
# Tests sync.sh against a throwaway remote, clone, and install directory.
# Run: bash tests/test-sync.sh
set -uo pipefail

sync="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/sync.sh"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

passes=0
failures=0
pass() { passes=$((passes + 1)); }
fail() { failures=$((failures + 1)); printf 'FAIL: %s\n' "$1" >&2; }
expect_line() { # label, output, exact line
  if grep -qxF -- "$3" <<<"$2"; then pass; else fail "$1: expected line '$3' in:"$'\n'"$2"; fi
}
expect_no_match() { # label, output, pattern. Empty output fails: status always lists something.
  if [[ -z "$2" ]]; then fail "$1: no output"; return; fi
  if grep -qE -- "$3" <<<"$2"; then fail "$1: unexpected match '$3' in:"$'\n'"$2"; else pass; fi
}
expect_file() { # label, file, exact content
  local actual
  actual="$(tr -d '\r' < "$2" 2>/dev/null)"
  if [[ "$actual" == "$3" ]]; then pass; else fail "$1: $2 has '$actual', expected '$3'"; fi
}
expect_refusal() { # label, pattern, command...
  local output
  if output="$("${@:3}" 2>&1)"; then fail "$1 (exited 0)"; return; fi
  if grep -qiE -- "$2" <<<"$output"; then pass; else fail "$1 (no message matching '$2'): $output"; fi
}

export GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.com
export GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.com

remote="$work/remote.git"
seed="$work/seed"       # stands in for edits made on GitHub or another machine
clone="$work/clone"
install="$work/install"

git init -q --bare -b main "$remote"
git clone -q "$remote" "$seed" 2>/dev/null
mkdir -p "$seed/alpha" "$seed/beta"
printf 'alpha v1\n' > "$seed/alpha/SKILL.md"
printf 'beta v1\n' > "$seed/beta/SKILL.md"
printf 'notice v1\n' > "$seed/NOTICE.md"
printf 'readme\n' > "$seed/README.md"
git -C "$seed" add -A && git -C "$seed" commit -qm seed && git -C "$seed" push -q origin main
git clone -q "$remote" "$clone"

mkdir -p "$install/synced/app-managed" "$install/.trash/old"
cp -R "$seed/alpha" "$seed/beta" "$seed/NOTICE.md" "$install/"
printf 'managed\n' > "$install/synced/app-managed/SKILL.md"
printf 'trashed\n' > "$install/.trash/old/SKILL.md"

run() { bash "$sync" --install "$install" --clone "$clone" "$@"; }
remote_edit() { # path, content
  git -C "$seed" pull -q --ff-only
  mkdir -p "$seed/$(dirname "$1")"
  printf '%s\n' "$2" > "$seed/$1"
  git -C "$seed" add -A && git -C "$seed" commit -qm "edit $1" && git -C "$seed" push -q origin main
}
commit_and_push_clone() {
  git -C "$clone" add -A && git -C "$clone" commit -qm sync && git -C "$clone" push -q origin main
}

# First run, before any base exists: identical items are in sync.
out="$(run status)"
expect_line "first run alpha" "$out" "in-sync alpha"
expect_line "first run NOTICE.md" "$out" "in-sync NOTICE.md"
expect_no_match "app-managed and trash folders are skipped" "$out" "synced|trash|app-managed"
expect_no_match "README.md is repo-only" "$out" "README"

# Line-ending differences alone are not changes.
printf 'beta v1\r\n' > "$install/beta/SKILL.md"
expect_line "CRLF-only change is in sync" "$(run status)" "in-sync beta"

# Record sets the base to the clone's commit.
run record >/dev/null
if [[ "$(cat "$install/.sync-base" 2>/dev/null)" == "$(git -C "$clone" rev-parse HEAD)" ]]; then pass; else fail "record did not write the clone commit to .sync-base"; fi

# A local edit is pushed. A remote edit is pulled.
printf 'alpha v2\n' > "$install/alpha/SKILL.md"
remote_edit beta/SKILL.md 'beta v2'
out="$(run status)"
expect_line "local edit" "$out" "push alpha"
expect_line "remote edit" "$out" "pull beta"
run apply >/dev/null
expect_file "apply copied local edit into clone" "$clone/alpha/SKILL.md" "alpha v2"
expect_file "apply copied remote edit into install" "$install/beta/SKILL.md" "beta v2"
expect_refusal "record before commit" "uncommitted" run record
commit_and_push_clone
run record >/dev/null
out="$(run status)"
expect_line "after record alpha" "$out" "in-sync alpha"
expect_line "after record beta" "$out" "in-sync beta"

# Both sides changed the same skill: a conflict that apply refuses until told which side wins.
printf 'alpha local v3\n' > "$install/alpha/SKILL.md"
remote_edit alpha/SKILL.md 'alpha remote v3'
expect_line "conflict" "$(run status)" "conflict alpha"
expect_refusal "apply with a conflict" "conflict.*alpha" run apply
expect_file "refused apply copied nothing into clone" "$clone/alpha/SKILL.md" "alpha remote v3"
expect_file "refused apply kept the local edit" "$install/alpha/SKILL.md" "alpha local v3"
run apply --take-local alpha >/dev/null
expect_file "take-local wins" "$clone/alpha/SKILL.md" "alpha local v3"
commit_and_push_clone
run record >/dev/null

# New skills on either side.
mkdir -p "$install/delta" && printf 'delta\n' > "$install/delta/SKILL.md"
remote_edit epsilon/SKILL.md 'epsilon'
out="$(run status)"
expect_line "new local skill" "$out" "push delta"
expect_line "new remote skill" "$out" "pull epsilon"
run apply >/dev/null
expect_file "new local skill copied" "$clone/delta/SKILL.md" "delta"
expect_file "new remote skill copied" "$install/epsilon/SKILL.md" "epsilon"
commit_and_push_clone
run record >/dev/null

# A local deletion needs --allow-delete.
rm -rf "$install/beta"
expect_line "local deletion" "$(run status)" "local-deleted beta"
expect_refusal "delete without flag" "allow-delete" run apply
if [[ -f "$clone/beta/SKILL.md" ]]; then pass; else fail "refused delete still removed beta"; fi
run apply --allow-delete >/dev/null
if [[ ! -e "$clone/beta" ]]; then pass; else fail "--allow-delete did not remove beta from clone"; fi
commit_and_push_clone
run record >/dev/null

# Ignored skills are left out.
printf 'delta\n' > "$install/.sync-ignore"
printf 'delta changed\n' > "$install/delta/SKILL.md"
expect_no_match "ignored skill" "$(run status)" "delta"
rm "$install/.sync-ignore"
printf 'delta\n' > "$install/delta/SKILL.md"

# Machine paths in a skill about to be pushed are flagged.
printf 'Open C:\\%s\\someone\\notes.md first.\n' Users > "$install/alpha/SKILL.md"
expect_line "absolute path warning" "$(run status)" "warning alpha/SKILL.md: machine-specific path"

# A dirty clone stops everything.
printf 'stray\n' > "$clone/stray.txt"
expect_refusal "dirty clone" "uncommitted" run status

printf '%s checks passed, %s failed\n' "$passes" "$failures"
((failures == 0))
