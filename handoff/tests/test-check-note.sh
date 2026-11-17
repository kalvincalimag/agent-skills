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
commit_all() {
  git -C "$1" -c core.autocrlf=false add -A
  git -C "$1" -c user.name=test -c user.email=test@example.com commit -qm "$2"
}

# A code repository with one commit, and a brain beside it.
repo="$tmp/repo"
brain="$tmp/brain"
mkdir -p "$repo/src/[id]" "$brain/planning/active" "$brain/memory" "$brain/sessions/2026/01"
printf 'x\n' >"$repo/src/app.ts"
printf 'x\n' >"$repo/src/[id]/page.tsx"
git -C "$repo" init -q
commit_all "$repo" init
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

# A repository with two commits. The note lives inside it, as it does when
# there is no brain.
live="$tmp/live"
mkdir -p "$live"
printf 'one\n' >"$live/a.txt"
git -C "$live" init -q
git -C "$live" config core.autocrlf false
commit_all "$live" one
old="$(git -C "$live" rev-parse --short HEAD)"
printf 'two\n' >>"$live/a.txt"
commit_all "$live" two
new="$(git -C "$live" rev-parse --short HEAD)"
mkdir -p "$live/plans"
live_note="$live/plans/handoff.md"

# Writes the live note. Arguments: the "As of" commit and working tree cells,
# then extra text for "State" and for "What does not travel".
write_live_note() {
  cat >"$live_note" <<EOF
# Pickup: live

## How to pick this up

1. Read this note.

## End goal

Ship it.

## As of

| Repository | Location | Remote | Branch | Commit | Working tree |
| --- | --- | --- | --- | --- | --- |
| live | \`$live\` | none | \`main\` | \`$1\` | $2 |

## State

Edit \`./a.txt\`. ${3:-}

## Next steps

1. Run it.

## Fixed decisions

- None.

## Fences

- None.

## What does not travel

- ${4:-None.}
EOF
}

write_live_note "$new" clean
run "$live_note" "$live"
expect_status 0 "a matching As of row passes, apart from the uncommitted note"
expect_out '1 row(s) under "As of"' "the As of row is counted"

write_live_note "$old" clean
run "$live_note" "$live"
expect_status 1 "an older As of commit fails"
expect_out "As of: $live is at $new, not $old" "the stale commit is reported"

write_live_note "$new" '`a.txt`'
run "$live_note" "$live"
expect_status 1 "listed changes in a clean tree fail"
expect_out "As of: $live is clean, but the note lists changes" "the clean tree is reported"

printf 'three\n' >>"$live/a.txt"
write_live_note "$new" clean
run "$live_note" "$live"
expect_status 1 "a dirty tree marked clean fails"
expect_out "As of: $live has uncommitted changes, but the note says clean" "the dirty tree is reported"
write_live_note - -
run "$live_note" "$live"
expect_status 0 "a row marked - is not compared"
git -C "$live" checkout -q -- a.txt

write_live_note "$new" clean
commit_all "$live" "save the note"
run "$live_note" "$live"
expect_status 0 "a later commit that changes only the note still matches"

# --remote: the next machine must be able to get everything the note names.
git init -q --bare "$tmp/live.git"
git -C "$live" remote add origin "$tmp/live.git"
git -C "$live" push -q -u origin HEAD 2>/dev/null
upstream="origin/$(git -C "$live" branch --show-current)"

run --remote "$live_note" "$live"
expect_status 0 "a pushed note passes --remote"

printf 'local.txt\nsecret.txt\n' >>"$live/.git/info/exclude"
printf 'x\n' >"$live/local.txt"
printf 'x\n' >"$live/secret.txt"
orphan="$(git -C "$live" -c user.name=test -c user.email=test@example.com commit-tree "HEAD^{tree}" -m orphan)"
write_live_note "$new" clean "Also \`./local.txt\`, \`$plain/plain.md\`, and \`$orphan\`." "\`./secret.txt\` stays here."
run --remote "$live_note" "$live"
expect_status 1 "unpushed references fail --remote"
expect_out "not pushed: ./local.txt is not in $upstream" "an ignored file is reported"
expect_out "not pushed: $plain/plain.md is in no repository" "a file outside every repository is reported"
expect_out "commit not on any remote branch: $orphan" "an unpushed commit is reported"
expect_out "the note has changes that are not pushed" "an unpushed note is reported"
expect_no_out "secret.txt" "What does not travel is exempt"
expect_out "failed with 4 issue(s)" "each unpushed reference is reported once"

commit_all "$live" "keep the note local"
run --remote "$live_note" "$live"
expect_out "As of: $live has 1 commit(s) that are not pushed" "an unpushed commit in an As of repository is reported"

if [[ $failures -gt 0 ]]; then
  printf '%s test(s) failed\n' "$failures" >&2
  exit 1
fi
printf 'all check-note tests passed\n'
