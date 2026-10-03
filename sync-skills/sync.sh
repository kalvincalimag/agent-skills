#!/usr/bin/env bash
# Syncs the installed skills directory with a Git skills pack, three ways.
#
# Usage:
#   bash sync.sh [--install DIR] [--clone DIR] [--remote URL] status
#   bash sync.sh [...] apply [--take-local NAME]... [--take-remote NAME]... [--allow-delete]
#   bash sync.sh [...] record
#
# status  Fetches the pack and prints one line per item: in-sync, push, pull,
#         conflict, local-deleted, or remote-deleted. Changes nothing except
#         fast-forwarding the clone.
# apply   Copies pushes into the clone and pulls into the install. Leaves the
#         clone uncommitted for review. Refuses conflicts and deletions unless told.
# record  After the clone is committed and pushed, marks this state as the base
#         for the next three-way comparison.
#
# An item is a top-level directory with a SKILL.md, or NOTICE.md. The install's
# synced/ directory, dot entries, and names listed in .sync-ignore are skipped.
set -euo pipefail

install="${SKILLS_INSTALL:-$HOME/.claude/skills}"
clone="${SKILLS_CLONE:-$HOME/Desktop/Master/Code/Personal/claude-skills}"
remote_url="${SKILLS_REMOTE:-https://github.com/kalvincalimag/claude-skills.git}"
branch=main

die() { printf 'sync-skills: %s\n' "$1" >&2; exit 1; }

command="" allow_delete=0
take_local=() take_remote=()
while (($#)); do
  case "$1" in
    --install) install="$2"; shift 2 ;;
    --clone) clone="$2"; shift 2 ;;
    --remote) remote_url="$2"; shift 2 ;;
    --take-local) take_local+=("$2"); shift 2 ;;
    --take-remote) take_remote+=("$2"); shift 2 ;;
    --allow-delete) allow_delete=1; shift ;;
    status|apply|record) command="$1"; shift ;;
    -h|--help) sed -n '2,18p' "${BASH_SOURCE[0]}"; exit 0 ;;
    *) die "unknown argument: $1" ;;
  esac
done
[[ -n "$command" ]] || die "give a command: status, apply, or record"
mkdir -p "$install"

# Git for Windows cannot "git -C" into a path with an apostrophe, so run git from inside the clone.
g() { (cd "$clone" && git "$@"); }

if [[ ! -d "$clone/.git" ]]; then
  git clone -q "$remote_url" "$clone" || die "could not clone $remote_url"
fi
[[ -z "$(g status --porcelain)" ]] || die "the clone has uncommitted changes: $clone. Commit or discard them first."
g fetch -q origin "$branch"
g merge -q --ff-only "origin/$branch" 2>/dev/null || die "the clone has diverged from origin/$branch: $clone"
[[ "$(g rev-parse HEAD)" == "$(g rev-parse "origin/$branch")" ]] || die "the clone has commits not pushed to origin/$branch. Push them first: $clone"

base_file="$install/.sync-base"
base=""
[[ -f "$base_file" ]] && base="$(tr -d '\r\n' < "$base_file")"
remote_head="$(g rev-parse HEAD)"

ignored=()
if [[ -f "$install/.sync-ignore" ]]; then
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%$'\r'}"
    [[ -n "$line" && "$line" != \#* ]] && ignored+=("$line")
  done < "$install/.sync-ignore"
fi
is_ignored() { local n; for n in ${ignored[@]+"${ignored[@]}"}; do [[ "$n" == "$1" ]] && return 0; done; return 1; }

install_items() {
  local d
  for d in "$install"/*/; do
    d="$(basename "$d")"
    [[ "$d" == synced ]] && continue
    [[ -f "$install/$d/SKILL.md" ]] && printf '%s\n' "$d"
  done
  [[ -f "$install/NOTICE.md" ]] && printf 'NOTICE.md\n'
  return 0
}
commit_items() { # commit
  g ls-tree -r --name-only "$1" | awk -F/ '$2 == "SKILL.md" && NF == 2 { print $1 } $0 == "NOTICE.md" { print }'
}

# Hash of an item's files with line endings normalized; "-" when absent.
install_hash() {
  local path="$install/$1" f
  [[ -e "$path" ]] || { printf -- '-'; return; }
  while IFS= read -r f; do
    printf '%s %s\n' "${f#"$install/"}" "$(tr -d '\r' < "$f" | git hash-object --stdin)"
  done < <(find "$path" -type f | LC_ALL=C sort) | git hash-object --stdin
}
commit_hash() { # commit, item
  local files f
  files="$(g ls-tree -r --name-only "$1" -- "$2" | LC_ALL=C sort)"
  [[ -n "$files" ]] || { printf -- '-'; return; }
  while IFS= read -r f; do
    printf '%s %s\n' "$f" "$(g show "$1:$f" | tr -d '\r' | git hash-object --stdin)"
  done <<<"$files" | git hash-object --stdin
}

state_of() { # item -> state
  local l r b
  l="$(install_hash "$1")"
  r="$(commit_hash "$remote_head" "$1")"
  [[ "$l" == "$r" ]] && { echo in-sync; return; }
  if [[ -z "$base" ]]; then
    if [[ "$r" == - ]]; then echo push
    elif [[ "$l" == - ]]; then echo pull
    else echo conflict; fi
    return
  fi
  b="$(commit_hash "$base" "$1")"
  if [[ "$l" == "$b" ]]; then
    [[ "$r" == - ]] && echo remote-deleted || echo pull
  elif [[ "$r" == "$b" ]]; then
    [[ "$l" == - ]] && echo local-deleted || echo push
  else
    echo conflict
  fi
}

items=()
while IFS= read -r item; do
  is_ignored "$item" || items+=("$item")
done < <({ install_items; commit_items "$remote_head"; [[ -n "$base" ]] && commit_items "$base"; } | LC_ALL=C sort -u)

# Parallel arrays, not an associative array, so this runs on bash 3.2 (the macOS default).
states=()
for item in ${items[@]+"${items[@]}"}; do states+=("$(state_of "$item")"); done
state_at() { printf "%s" "${states[$1]}"; }

contains() { local n="$1"; shift; local x; for x in "$@"; do [[ "$x" == "$n" ]] && return 0; done; return 1; }

case "$command" in
  status)
    for ((i = 0; i < ${#items[@]}; i++)); do
      printf '%s %s\n' "$(state_at $i)" "${items[$i]}"
    done
    for ((i = 0; i < ${#items[@]}; i++)); do
      item="${items[$i]}"
      [[ "$(state_at $i)" == push || "$(state_at $i)" == conflict ]] || continue
      while IFS= read -r f; do
        printf 'warning %s: machine-specific path\n' "${f#"$install/"}"
      done < <(grep -rlE '[A-Za-z]:\\\\?U[s]ers|/c/U[s]ers/|/U[s]ers/[A-Za-z]|/h[o]me/[a-z]' "$install/$item" 2>/dev/null || true)
    done
    ;;

  apply)
    blocked=()
    for ((i = 0; i < ${#items[@]}; i++)); do
      item="${items[$i]}" s="$(state_at $i)"
      if [[ "$s" == conflict ]] && ! contains "$item" ${take_local[@]+"${take_local[@]}"} ${take_remote[@]+"${take_remote[@]}"}; then
        blocked+=("conflict: $item changed on both sides. Pass --take-local $item or --take-remote $item.")
      fi
      if [[ "$s" == *-deleted && $allow_delete -eq 0 ]]; then
        blocked+=("$s: $item. Pass --allow-delete to apply the deletion.")
      fi
    done
    if ((${#blocked[@]})); then printf '%s\n' "${blocked[@]}" >&2; die "nothing changed"; fi

    for ((i = 0; i < ${#items[@]}; i++)); do
      item="${items[$i]}" s="$(state_at $i)"
      contains "$item" ${take_local[@]+"${take_local[@]}"} && s=push
      contains "$item" ${take_remote[@]+"${take_remote[@]}"} && s=pull
      case "$s" in
        # A side that no longer has the item wins as a deletion.
        push) if [[ -e "$install/$item" ]]; then rm -rf "${clone:?}/$item"; cp -R "$install/$item" "$clone/$item"; echo "copied to clone: $item"
              else g rm -rq -- "$item"; echo "deleted from clone: $item"; fi ;;
        pull) rm -rf "${install:?}/$item"
              if [[ -e "$clone/$item" ]]; then cp -R "$clone/$item" "$install/$item"; echo "copied to install: $item"
              else echo "deleted from install: $item"; fi ;;
        local-deleted) g rm -rq -- "$item"; echo "deleted from clone: $item" ;;
        remote-deleted) rm -rf "${install:?}/$item"; echo "deleted from install: $item" ;;
      esac
    done
    echo "Review the clone with git diff, then commit, push, and run record."
    ;;

  record)
    differing=()
    for item in ${items[@]+"${items[@]}"}; do
      [[ "$(install_hash "$item")" == "$(commit_hash "$remote_head" "$item")" ]] || differing+=("$item")
    done
    ((${#differing[@]} == 0)) || die "install and origin/$branch still differ: ${differing[*]}"
    printf '%s\n' "$remote_head" > "$base_file"
    echo "recorded base $remote_head"
    ;;
esac
