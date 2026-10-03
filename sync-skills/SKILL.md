---
name: sync-skills
description: "Use when the user wants their skills folder and their skills repository brought in line: after editing, adding, or deleting a skill locally, to pull skill changes made elsewhere, or to set up the skills on a new machine. Pushes local edits, pulls remote ones, stops on conflicts, and checks that every skill stays general across projects and agents."
---

# Sync skills

## Purpose

The skills repository is the source of truth. The skills folder the agent loads is a Git clone of that repository, so skills are edited where the agent reads them, and syncing is Git: pull what changed remotely, commit and push what changed locally.

## The skills folder

This skill lives inside the skills folder, so the folder is the parent of this skill's folder. Agents look for personal skills here:

| Agent | Skills folder |
| --- | --- |
| Claude Code | `~/.claude/skills` |
| OpenAI Codex | `~/.agents/skills` |

A user of both agents keeps one clone and links the other folder to it. The repository's `README.md` shows how on macOS, Linux, and Windows.

## Boundaries

- Commit and push only with the user's authorization in this session. Ask once, after the review.
- Push to the branch the clone tracks, normally `main`. Pull requests are not this skill's job.
- Delete a skill only after the user confirms.
- If `gh` is needed, first confirm `gh auth status` shows the account that owns the repository.
- The repository's `.gitignore` covers folders an agent's app manages, such as `synced/` and `.trash/`. A skill the user keeps on one machine only goes in `.git/info/exclude`.

## Set up

- **Empty or missing folder:** `git clone <repository> <skills folder>`.
- **Folder that already has skills:** in the folder, run `git init -b main`, `git remote add origin <repository>`, `git fetch origin`, `git reset origin/main`, and `git branch -u origin/main`. This changes no files. `git status` then shows how the folder differs from the repository. Treat those differences as local changes in step 2.

## Steps

1. **Check.** In the skills folder, run `git fetch`. Local changes are in `git status --short`. Remote changes are in `git log --oneline HEAD..@{u}` and `git diff --stat HEAD...@{u}`. If neither side changed, say so and stop.
2. **Review local changes.** Run `bash sync-skills/check.sh`. It must pass. A warning names a frontmatter field that only some agents understand, so keep it only when the skill needs it. Then read each changed skill in full and check that it stays general:
   - No names of a specific project, client, organization, repository, or person. The exception is a skill whose job is managing one of the user's own repositories.
   - No machine paths except defaults under `~` that the user can override.
   - No credentials, tokens, or account emails.
   - It works for any agent that reads the Agent Skills format. Detail for one agent or one provider lives in a reference file the skill reads only when needed.

   Fix problems in place and run the check again. A skill that only makes sense for one project stays out of the repository: add it to `.git/info/exclude`.
3. **Test.** For each changed skill with a `tests/` folder, run its tests. This skill's are `bash sync-skills/tests/test-check.sh`.
4. **Ask.** Show `git status --short`, one line per changed skill, and the incoming remote commits. Ask to commit and push.
5. **Sync.** On approval, run `git add -A`, commit with a message that names the skills, then `git pull --rebase` and `git push`. With no local changes, `git pull --ff-only` is enough and needs no approval.
6. **Resolve conflicts.** If the rebase stops on a conflict, show the user both versions and ask which to keep, or merge them by hand. Never discard either side without the user's choice. Then run `git rebase --continue`.
7. **Report.** Say what was pushed and what was pulled. Agents load changed skills in their next session, and some sooner.
