---
name: new-brain
description: "Use when the user wants a new brain: a local, curated knowledge base for one purpose, such as life admin or a software project, where an agent session started in its directory reads the brain's memory and writes durable knowledge back. Reviews and improves brain-template before copying it. Also use to carry template feedback from an existing brain back into the template. Not for working inside an existing brain; that brain's own AGENTS.md governs."
argument-hint: "[purpose]"
---

# New brain

## Purpose

Create a standalone local brain for one purpose, and leave brain-template better for the next purpose. The template is general. The brain is tailored to this purpose, from what the user says in the interview.

The procedure lives in the template's `TEMPLATE.md`, so it improves with the template and any agent can follow it. This skill supplies this user's locations and boundaries, then runs that procedure.

## Locations

- Template copy: a local clone of the user's template repository, kept wherever the user wants it. Look in this order: the `BRAIN_TEMPLATE_DIR` environment variable, a location the user's own agent instructions give, then the default `~/Desktop/Brains/brain-template`. If none exists, offer to clone the template repository to the default or to a folder the user names. The original template is `https://github.com/kalvincalimag/brain-template`. If the user picks a non-default folder, suggest setting `BRAIN_TEMPLATE_DIR` so the next run finds it.
- Every run updates the template copy from GitHub before using it, so it always starts from the latest version. The copy stays on disk, because template improvements are made and published from it.
- Where to create the brain: ask, offering `~/Desktop/Brains/<name>` as the default, and use whatever the user picks.

## Boundaries

- Read only the template. Never read from or write to another brain, including work brains, unless the user names it for a scoped transfer.
- Facts about the new brain's subject go only into the brain. The template stays general, and its examples never reveal what this user uses it for.
- The new brain gets no Git remote.
- Skills are out of scope. Creating a brain never installs, checks, or copies skills.
- Committing or pushing the template, and the brain's first commit, each need the user's authorization in this session.
- Use plain `git` for the template. If `gh` is needed, first confirm `gh auth status` shows the account that owns the template repository.

## Steps

1. Get the purpose from the request or ask for it.
2. In the template clone, read `TEMPLATE.md`, then follow "Create a brain" from step 2 onward. Read it fresh each run, since the template may have changed.
3. For the end-to-end check in step 8, start a fresh session of the agent you are running in, from the brain directory and without tools. For example, `claude -p "<question>"` or `codex exec "<question>"`, asking what the brain is for and which memory files its index lists.
4. Report the brain's path, how to start a session there, each template change in one line, and anything unverified.

To carry feedback from an existing brain back into the template, follow "Carry feedback back from a brain" in `TEMPLATE.md`.
