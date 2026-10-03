---
name: sync-skills
description: "Use when the user wants their installed Claude skills and their skills pack on GitHub brought in line, after editing, adding, or deleting a skill locally, or to check whether the installed skills are current. Pushes local edits, pulls remote edits, stops on conflicts, and checks that every pushed skill stays general across projects."
argument-hint: "[status]"
---

# Sync skills

Request: $ARGUMENTS

## Purpose

Skills are edited in the install directory. The skills pack on GitHub is the source of truth that every machine draws from. Skills are the user's own tools. They are not part of any project or brain. This skill keeps the two the same without losing an edit from either side, and it keeps project-specific content out of the pack.

## Locations

- Install, where edits happen: `~/.claude/skills`.
- Pack remote: `https://github.com/kalvincalimag/claude-skills`, a private repository on the personal account.
- Pack clone: `~/Desktop/Master/Code/Personal/claude-skills`. Set `SKILLS_CLONE` to use another path. `sync.sh` clones it there if it is missing.

Edit skills in the install, never in the clone. `sync.sh` refuses to run while the clone has uncommitted or unpushed changes.

On a new machine, run `bash sync-skills/sync.sh apply` from a fresh clone of the pack. With no install yet, every skill shows as `pull`, so `apply` installs them all. Then run `record`.

Never synced: the install's `synced/` folder, which the Claude app manages; dot entries such as `.trash/`; and any skill named in `~/.claude/skills/.sync-ignore`, one name per line.

## Boundaries

- Commit and push only with the user's authorization in this session. Ask once, after the review.
- Push straight to `main` of the pack. Pull requests are `ship`'s job, not this one.
- Use plain `git`. If `gh` is needed, first confirm `gh auth status` shows the personal account, not a work account.
- Delete a skill on either side only after the user confirms that deletion.

## How it decides

`sync.sh` compares three versions of each skill: the install, the pack on GitHub, and the base, which is the pack commit at the last successful sync. Line endings are ignored.

| Status | Meaning | What `apply` does |
| --- | --- | --- |
| `in-sync` | Install and pack match | Nothing |
| `push` | Changed or added locally | Copies it into the clone |
| `pull` | Changed or added on GitHub | Copies it into the install |
| `conflict` | Changed on both sides, or differs on the first sync | Refuses until told which side wins |
| `local-deleted` | Deleted locally | Deletes it from the clone, only with `--allow-delete` |
| `remote-deleted` | Deleted on GitHub | Deletes it from the install, only with `--allow-delete` |

## Steps

1. **Check.** Run `bash ~/.claude/skills/sync-skills/sync.sh status`. If every line is `in-sync`, say so and stop.
2. **Review generality.** Read every `push` and `conflict` skill in full, and diff it against the clone. A skill in the pack must work in any project. Fix problems in the install, then rerun `status`.
   - No names of a specific project, client, organization, repository, or person. The exception is a skill whose job is managing one of the user's own repositories, such as this one or `new-brain`.
   - No machine paths except defaults under `~` that can be overridden. `status` prints a `warning` line for each absolute path it finds.
   - No credentials, tokens, or account emails.
   - Provider-specific or tool-specific detail lives in a reference file the skill reads only when the project uses that provider. It is never an assumption in `SKILL.md`.
   - A skill that only makes sense for one project does not go in the pack. Add its name to `.sync-ignore` so it stays installed locally but unsynced.
3. **Resolve.** For each conflict, show the user both versions. Use the side they choose, or merge by hand into the install and treat it as local. Confirm each deletion with the user.
4. **Apply.** Run `sync.sh apply`, adding `--take-local <name>`, `--take-remote <name>`, or `--allow-delete` as resolved.
5. **Update the pack's docs.** In the clone, keep the skills table in `README.md` matching the skill folders. `NOTICE.md` lists only skills derived from upstream sources. Add a skill there only if it is derived.
6. **Test.** For each pushed skill with a `tests/` folder, run its tests. `sync-skills` has `bash tests/test-sync.sh`.
7. **Ask.** Show `git -C <clone> status --short` and a one-line summary per skill. Ask to commit and push.
8. **Publish.** On approval, commit with a message naming the skills, push to `origin main`, then run `sync.sh record`. Without approval, leave the clone as it is and tell the user that the next `status` refuses to run until the clone is committed or discarded.
