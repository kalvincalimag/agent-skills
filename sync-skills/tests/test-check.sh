#!/usr/bin/env bash
# Tests check.sh against throwaway skills folders.
# Run: bash tests/test-check.sh
set -uo pipefail

check="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/check.sh"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

passes=0
failures=0
pass() { passes=$((passes + 1)); }
fail() { failures=$((failures + 1)); printf 'FAIL: %s\n' "$1" >&2; }
expect_ok() { # label, dir, optional pattern the output must contain
  local output
  if output="$(bash "$check" "$2" 2>&1)"; then
    if [[ -z "${3:-}" ]] || grep -qiE -- "$3" <<<"$output"; then pass; else fail "$1: output lacks '$3': $output"; fi
  else fail "$1: check failed: $output"; fi
}
expect_refusal() { # label, dir, pattern
  local output
  if output="$(bash "$check" "$2" 2>&1)"; then fail "$1 (exited 0)"; return; fi
  if grep -qiE -- "$3" <<<"$output"; then pass; else fail "$1 (no message matching '$3'): $output"; fi
}
skill() { # dir, folder, file content
  mkdir -p "$1/$2"
  printf '%s\n' "$3" > "$1/$2/SKILL.md"
}
good='---
name: alpha
description: Use when testing. Does a thing.
---

# Alpha'

d="$work/good"; skill "$d" alpha "$good"
mkdir -p "$d/synced/app/inner" "$d/.trash/old"
printf -- '---\nname: Wrong Name\n---\n' > "$d/synced/app/inner/SKILL.md"
printf -- '---\nname: Wrong\n---\n' > "$d/.trash/old/SKILL.md"
expect_ok "valid skill, app folders skipped" "$d" "1 skill"

d="$work/multiline"; skill "$d" alpha '---
name: "alpha"
description: >
  Use when testing.
  Folded across lines.
---'
expect_ok "quoted name and folded description" "$d"

d="$work/mismatch"; skill "$d" beta "$good"
expect_refusal "name differs from folder" "$d" "beta.*name 'alpha' does not match the folder"

d="$work/badname"; skill "$d" Bad--Name "${good/alpha/Bad--Name}"
expect_refusal "invalid name" "$d" "invalid name"

d="$work/nodesc"; skill "$d" alpha '---
name: alpha
---'
expect_refusal "missing description" "$d" "missing description"

long="$(printf 'x%.0s' $(seq 1 1100))"
d="$work/longdesc"; skill "$d" alpha "---
name: alpha
description: $long
---"
expect_refusal "description too long" "$d" "longer than 1024"

d="$work/nofront"; skill "$d" alpha '# Alpha without frontmatter'
expect_refusal "no frontmatter" "$d" "no frontmatter"

d="$work/path"; skill "$d" alpha "$good
Open C:\\$(printf '%s' Users)\\someone\\notes.md first."
expect_refusal "machine-specific path" "$d" "alpha/SKILL.md.*machine-specific path"

d="$work/placeholder"; skill "$d" alpha "$good
Request: \$ARGUMENTS"
expect_refusal "agent-specific placeholder" "$d" "ARGUMENTS"

d="$work/claudeonly"; skill "$d" alpha '---
name: alpha
description: Use when testing.
argument-hint: "[thing]"
---'
expect_ok "agent-specific field is a warning only" "$d" "warning.*argument-hint"

printf '%s checks passed, %s failed\n' "$passes" "$failures"
((failures == 0))
