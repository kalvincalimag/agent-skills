---
name: new-brain
description: "Use when the user wants a new brain: a local, curated knowledge base for one purpose, such as life admin or a software project, where an agent session started in its directory reads the brain's memory and writes durable knowledge back. Reviews and improves brain-template before copying it. Also use to carry template feedback from an existing brain back into the template. Not for working inside an existing brain; that brain's own AGENTS.md governs."
argument-hint: "[purpose]"
---

# New brain

Request: $ARGUMENTS

## Purpose

Create a standalone local brain for one purpose, and leave brain-template better for the next purpose. The template is general. The brain is tailored to this purpose, from what the user says in the interview.

The procedure lives in the template's `TEMPLATE.md`, so it improves with the template and any agent can follow it. This skill supplies this user's locations and boundaries, then runs that procedure.

## Locations

- Template remote: `https://github.com/kalvincalimag/brain-template`, a private repository on the personal account.
- Template clone: `~/Desktop/Master/Code/Personal/brain-template`, unless the user names another. If it is missing, clone the remote there.
- Default home for new brains: `~/Desktop/Master/Code/Personal/brains/<slug>`. Offer it, and use whatever the user picks.

## Boundaries

- Read only the template. Never read from or write to another brain, including work brains, unless the user names it for a scoped transfer.
- Facts about the new brain's subject go only into the brain. The template stays general, and its examples never reveal what this user uses it for.
- The new brain gets no Git remote.
- Skills are out of scope. Creating a brain never installs, checks, or copies skills.
- Committing or pushing the template, and the brain's first commit, each need the user's authorization in this session.
- Use plain `git` for the template. If `gh` is needed, first confirm `gh auth status` shows the personal account, not the work account.

## Steps

1. Get the purpose from the request or ask for it.
2. In the template clone, read `TEMPLATE.md`, then follow "Create a brain" from step 2 onward. Read it fresh each run, since the template may have changed.
3. For the end-to-end check in step 8, run `claude -p "In two lines: what is this brain for, and which memory files does its index list?"` from the brain directory.
4. Report the brain's path, how to start a session there, each template change in one line, and anything unverified.

To carry feedback from an existing brain back into the template, follow "Carry feedback back from a brain" in `TEMPLATE.md`.
