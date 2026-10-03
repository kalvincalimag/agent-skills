#!/usr/bin/env bash
# Checks every skill in a skills folder against the Agent Skills format
# (agentskills.io) and this pack's rules: agent-neutral, no machine paths.
#
# Usage: bash sync-skills/check.sh [SKILLS_DIR]
# SKILLS_DIR defaults to the folder that contains sync-skills/.
#
# A skill is a top-level folder with a SKILL.md. Dot folders and synced/,
# which a desktop app may manage, are skipped. Fields outside the spec are
# reported as warnings, because some agents use them and others ignore them.
set -uo pipefail

dir="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
failures=0
count=0
report() { printf '%s\n' "$1" >&2; failures=$((failures + 1)); }

# Prints the frontmatter of a file, or nothing when it has none.
frontmatter() {
  awk 'NR == 1 { if ($0 !~ /^---[[:space:]]*$/) exit; next }
       /^---[[:space:]]*$/ { exit }
       { print }' "$1" | tr -d '\r'
}
# Prints a top-level field's value, joining folded or literal blocks.
field() { # frontmatter text, key
  awk -v key="$2" '
    found && /^[[:space:]]/ { sub(/^[[:space:]]+/, ""); value = value (value == "" ? "" : " ") $0; next }
    found { exit }
    index($0, key ":") == 1 {
      value = substr($0, length(key) + 2); sub(/^[[:space:]]+/, "", value)
      if (value ~ /^[>|][-+]?$/) value = ""
      found = 1
    }
    END { print value }' <<<"$1" | sed -E 's/^"(.*)"$/\1/; s/^'"'"'(.*)'"'"'$/\1/'
}

spec_fields=' name description license compatibility metadata allowed-tools '

for skill_md in "$dir"/*/SKILL.md; do
  [[ -f "$skill_md" ]] || continue
  folder="$(basename "$(dirname "$skill_md")")"
  [[ "$folder" == synced ]] && continue
  count=$((count + 1))

  fm="$(frontmatter "$skill_md")"
  if [[ -z "$fm" ]]; then report "$folder: no frontmatter; SKILL.md must start with a --- block"; continue; fi

  name="$(field "$fm" name)"
  if [[ -z "$name" ]]; then
    report "$folder: missing name"
  else
    [[ "$name" == "$folder" ]] || report "$folder: name '$name' does not match the folder"
    if ((${#name} > 64)) || ! grep -qE '^[a-z0-9]+(-[a-z0-9]+)*$' <<<"$name"; then
      report "$folder: invalid name '$name'; use 1-64 lowercase letters, digits, and single hyphens"
    fi
  fi

  description="$(field "$fm" description)"
  if [[ -z "$description" ]]; then
    report "$folder: missing description"
  elif ((${#description} > 1024)); then
    report "$folder: description longer than 1024 characters (${#description})"
  fi

  while IFS= read -r key; do
    [[ "$spec_fields" == *" $key "* ]] || printf 'warning %s: field %s is not in the Agent Skills spec; some agents ignore it\n' "$folder" "$key"
  done < <(grep -oE '^[A-Za-z_-]+:' <<<"$fm" | tr -d ':')

  while IFS= read -r f; do
    report "${f#"$dir/"}: machine-specific path; use a path under ~ or describe the location instead"
  done < <(grep -rlE '[A-Za-z]:\\\\?U[s]ers|/c/U[s]ers/|/U[s]ers/[A-Za-z]|/h[o]me/[a-z]' "$dir/$folder" 2>/dev/null)

  if grep -q '\$ARGUMENTS' "$skill_md"; then
    report "$folder: \$ARGUMENTS is a Claude Code placeholder; other agents show it literally"
  fi
done

if ((failures > 0)); then
  printf 'skills check failed with %s issue(s) in %s skill(s)\n' "$failures" "$count" >&2
  exit 1
fi
printf 'skills check passed: %s skill(s)\n' "$count"
