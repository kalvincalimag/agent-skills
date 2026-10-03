---
name: new-brain
description: "Use when the user wants a new brain: a local, curated knowledge base for one purpose, such as personal taxes and government contributions, where a session started in its directory reads the brain's memory and writes durable knowledge back. Reviews and improves brain-template before copying it. Also use to carry template feedback from an existing brain back into the template. Not for working inside an existing brain; that brain's own AGENTS.md governs."
argument-hint: "[purpose]"
---

# New brain

Request: $ARGUMENTS

## Purpose

Create a standalone local brain for one purpose, and leave brain-template better for the next purpose. A finished brain is a directory where `cd <brain>` then `claude` starts a session that already has the brain's rules and memory index loaded, and that writes durable knowledge back before it answers.

The template is never assumed to fit. Every run reviews it against the new purpose first.

## Locations

- Template remote: `https://github.com/kalvincalimag/brain-template`, a personal repository.
- Template clone: `~/Desktop/Master/Code/Personal/brain-template`, unless the user names another.
- Default home for new brains: `~/Desktop/Master/Code/Personal/brains/<slug>`. Offer it, and use whatever the user picks.

## Boundaries

- Read only the template. Never read from or write to another brain, including work brains, unless the user names it for a scoped transfer.
- Never put facts about the new brain's subject into the template. `TEMPLATE.md` in the clone defines what may go there.
- The new brain gets no Git remote.
- Committing or pushing the template, and the brain's first commit, each need the user's authorization in this session. Ask once, at the end, for all of them together.
- Use plain `git` for the template. If `gh` is needed, first confirm `gh auth status` shows the personal account, not the work account.

## Create a brain

1. **Get the purpose.** If the request states it, restate it in one sentence and confirm it during the interview. Otherwise ask what the brain is for, what it should help decide or do, and what is out of scope. Do not continue without a purpose.
2. **Sync the template.** In the clone, `git status --porcelain` must print nothing. Then run `git pull --ff-only`. If the clone is missing, clone the remote to the clone path. If the clone has uncommitted changes or has diverged from the remote, stop and ask.
3. **Review fitness.** Read `TEMPLATE.md`, then follow its "Fitness review" section for this purpose. Read every core file and every `PROFILE.md`. A profile does not fit because its name sounds right. It fits when its "Use when" matches and its "Do not use when" does not. The output is a short fit report: chosen profiles, and each gap with its level, which is core, profile, or brain. If a chosen profile's `PROFILE.md` lists skills it needs from the skills pack, run `bash ~/.claude/skills/sync-skills/sync.sh status`. Each listed skill must be installed and `in-sync`. If one is missing or behind, bring it in with the `sync-skills` skill before creating the brain.
4. **Improve the template.** For each core or profile gap, follow "Changing the template" in `TEMPLATE.md`. When no profile fits and the purpose is a class other brains will share, add a profile. Otherwise use core alone and handle the gaps in the brain. Run `bash tests/test-template.sh` until it passes, and add the changelog line. If every gap is brain-level, change nothing.
5. **Interview.** Ask in one batch. Include the brain's name, its location with the default offered, and the "Interview" questions of each chosen profile. Skip anything the request already answered. Use the question tool where there are real options, and plain questions where the answer is free text.
6. **Create.** From the clone, run:

   ```bash
   bash scripts/new-brain.sh --dest "<path>" --name "<name>" --purpose "<one-paragraph purpose>" --profile <profile>
   ```

   Repeat `--profile` for each chosen profile.
7. **Personalize.** In the new brain:
   - Fill `memory/overview.md` with scope, out of scope, and authority.
   - Record the interview answers in the files each profile names. Record only what the user stated, dated, and mark anything uncertain as unverified.
   - Do not research external rules now unless the user asks. Sourced research belongs in the brain's first real session.
   - Handle the brain-level gaps from the fit report, such as a brain-local skill or memory file this purpose needs.
   - Update the "Active context" in `memory/MEMORY.md`.
   - Write `sessions/YYYY/MM/YYYY-MM-DD-brain-created.md` from `templates/session-summary.md`, with the fit report.
8. **Verify.**
   - In the brain, run `bash scripts/validate-brain.sh`.
   - Run the end-to-end check from the brain directory: `claude -p "In two lines: what is this brain for, and which memory files does its index list?"`. The answer must name the purpose and the profile's memory files. That proves a fresh session loads the brain.
   - If the `claude` command is unavailable, say the end-to-end check did not run.
9. **Ask, then finish.** Ask in one question batch:
   - Commit and push the template changes to `origin/main`? Ask only if the template changed.
   - Make the first commit in the new brain?

   After an approved template commit, rewrite the "Origin" line in the brain's `memory/overview.md` with the new short commit hash. Report the brain's path, the command to start it, each template change in one line, and anything unverified.

## Carry feedback back to the template

Use this when the user asks to upstream template feedback, or when this skill runs inside a brain whose `planning/template-feedback.md` has open entries.

1. Read only that brain's `planning/template-feedback.md`, plus any structural file an entry names. Do not read its memory, sessions, records, or `private/`.
2. Sync the template, as in step 2 above.
3. For each entry, choose core, profile, or reject, using `TEMPLATE.md`. Rewrite the idea so it holds no facts about that brain's subject. Apply it, then run the tests.
4. Mark each entry in the brain's feedback file as carried over, with the date and template commit, or as rejected, with the reason.
5. Ask before committing and pushing the template.
