#!/usr/bin/env bash
# Tests for handoff/check-note.sh. Run: bash handoff/tests/test-check-note.sh
set -uo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
check="$here/../check-note.sh"
template="$here/../pickup-note.md"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
# Keep Git from finding a repository above the test folder, such as a
# versioned home folder.
export GIT_CEILING_DIRECTORIES="$tmp"
failures=0

ok() { printf 'ok   %s\n' "$1"; }
bad() { printf 'FAIL %s\n' "$1" >&2; failures=$((failures + 1)); }

# Runs the checker and keeps its exit status and combined output.
run() { out="$(bash "$check" "$@" 2>&1)"; status=$?; }
expect_status() { [[ $status -eq $1 ]] && ok "$2" || bad "$2: exit $status, want $1. Output: $out"; }
expect_out() { [[ "$out" == *"$1"* ]] && ok "$2" || bad "$2: output lacks '$1'. Output: $out"; }
expect_no_out() { [[ "$out" != *"$1"* ]] && ok "$2" || bad "$2: output has '$1'. Output: $out"; }

# A code repository with one commit, and a brain beside it.
repo="$tmp/repo"
brain="$tmp/brain"
mkdir -p "$repo/src/[id]" "$brain/planning/active" "$brain/memory" "$brain/sessions/2026/01"
printf 'x\n' >"$repo/src/app.ts"
printf 'x\n' >"$repo/src/[id]/page.tsx"
git -C "$repo" init -q
git -C "$repo" -c core.autocrlf=false add -A
git -C "$repo" -c user.name=test -c user.email=test@example.com commit -qm init
hash="$(git -C "$repo" rev-parse HEAD)"
printf '# Memory\n' >"$brain/memory/MEMORY.md"
printf '# Session\n' >"$brain/sessions/2026/01/2026-01-01-a.md"

good="$brain/planning/active/good.md"
cat >"$good" <<EOF
# Pickup: test

## How to pick this up

1. Read [the index](../../memory/MEMORY.md) and [a session](../../sessions/2026/01/2026-01-01-a.md#context).

## End goal

Ship \`src/app.ts\`, line \`src/app.ts:3\`, and \`src/[id]/page.tsx\`, and see <https://example.com> and <br> here. The word \`defaced\` is not a commit.

## As of

| repo | \`src/\` | \`origin/main\` | \`$hash\` | clean |

## State

Run \`npm test -- src/missing.ts\` and read \`memory/MEMORY.md\`. Not paths: \`github.com/owner/repo.git\`, \`@scope/pkg\`, \`feature/login\`.

## Next steps

1. See [the site](https://example.com/x.md).

## Fixed decisions

- None.

## Fences

\`\`\`bash
cat src/not-there.ts <placeholder-inside-a-fence>
\`\`\`
EOF

run "$good" "$brain" "$repo"
expect_status 0 "a complete note passes"
expect_out "5 path(s), 2 link(s), 1 commit(s)" "paths, links, and commits are counted"

bad_note="$brain/planning/active/bad.md"
cat >"$bad_note" <<'EOF'
# Pickup: test

<!-- guidance on one line -->

## How to pick this up

Read [missing](../nope.md).

<!-- guidance over
two lines with `src/also-missing.ts`
-->

## End goal

> <the user's words>

## As of

| x | `src/missing.ts` | `deadbeef1234` | `<short hash>` |

## State

## Next steps

## Fixed decisions
EOF

run "$bad_note" "$brain" "$repo"
expect_status 1 "a note with defects fails"
expect_out "bad.md:3: template comment left in" "a one-line comment is reported"
expect_out "bad.md:9: template comment left in" "a multi-line comment is reported"
expect_no_out "also-missing" "text inside a comment is not checked"
expect_out "link target not found: ../nope.md" "a broken link is reported"
expect_out "placeholder left in: <the user's words>" "a prose placeholder is reported"
expect_out "placeholder left in: \`<short hash>\`" "a code placeholder is reported"
expect_out "path not found: src/missing.ts" "a missing path is reported"
expect_out "commit not found in any root repository: deadbeef1234" "an unknown commit is reported"
expect_out "missing section: ## Fences" "a missing section is reported"
expect_out "empty section: ## State" "an empty section is reported"
expect_out "empty section: ## Fixed decisions" "an empty last section is reported"
expect_no_out "empty section: ## As of" "a section with only a table is not empty"
expect_out "failed with 11 issue(s)" "every defect is counted once"

# With no root given, the note's own repository is the root.
mkdir -p "$repo/plans"
note_in_repo="$repo/plans/handoff-test.md"
sed -e 's#\.\./\.\./memory/MEMORY\.md#../src/app.ts#' \
  -e 's#\.\./\.\./sessions/2026/01/2026-01-01-a\.md#../src/app.ts#' \
  -e 's#`memory/MEMORY\.md`#`src/app.ts`#' "$good" >"$note_in_repo"
run "$note_in_repo"
expect_status 0 "the note's repository is the default root"

# A hash cannot be checked when no root is a Git repository.
plain="$tmp/plain"
mkdir -p "$plain"
sed -e 's#\.\./\.\./memory/MEMORY\.md#plain.md#' \
  -e 's#\.\./\.\./sessions/2026/01/2026-01-01-a\.md#plain.md#' \
  -e 's#`src/app\.ts`#`./plain.md`#' -e 's#`src/app\.ts:3`#`./plain.md:3`#' \
  -e 's#`src/\[id\]/page\.tsx`#`./plain.md`#' \
  -e 's#`src/`#`./`#' -e 's#`memory/MEMORY\.md`#`./plain.md`#' "$good" >"$plain/plain.md"
run "$plain/plain.md" "$plain"
expect_status 0 "a note outside any repository passes"
expect_out "1 commit hash(es) not checked" "an unchecked hash is reported"

# The template must carry every section the checker requires.
run "$template" "$tmp"
expect_status 1 "the unfilled template fails"
expect_out "template comment left in" "the template's guidance is reported"
expect_no_out "missing section" "the template has every required section"
expect_no_out "empty section" "every required section of the template has content"

run
expect_status 2 "no arguments is a usage error"
run "$tmp/no-such-note.md"
expect_status 2 "a missing note is a usage error"

if [[ $failures -gt 0 ]]; then
  printf '%s test(s) failed\n' "$failures" >&2
  exit 1
fi
printf 'all check-note tests passed\n'
