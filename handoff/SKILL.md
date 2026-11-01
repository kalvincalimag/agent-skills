---
name: handoff
description: "Use when moving an in-progress session to another machine or session — laptop to phone, local to cloud, or ahead of a context limit. Summarizes what this session knows into a handoff the user can open on the other device and hand to a fresh session. Not for publishing finished work; that is `ship`."
---

# Handoff

## Purpose

Carry a live session's working state onto another device, where a session will start with
nothing. That session gets the handoff and no conversation. Everything it needs to continue, or
to take a new request against this work, has to be in the handoff.

The origin machine may be asleep or offline when the handoff is read. Anything that depends on
it is not delivered.

**Boundary.** This skill packages state. It does not open a pull request, merge, or deploy —
that is `ship`. It does not design the work — that is `plan`. Its only outward action is a
work-in-progress commit and push of the current branch, and that requires authorization like
any other.

---

# Part 1 — Choose the carrier

Two things may need to travel, and they travel differently. Decide both before writing.

**The thinking** — what was decided and what comes next. This is the handoff proper. It must
land somewhere the user can open on the receiving device with the origin machine switched off.

**The code** — only if the next session will edit it. Nothing but a pushed branch moves code.
A handoff document does not carry it, and saying otherwise strands the next session.

**If the project has a brain, the brain is the carrier.** A brain is a curated knowledge base
that the project's sessions read at startup, under rules of their own: an `AGENTS.md` with
startup and writeback rules, and usually a memory index. Write the handoff into the brain
itself, so that the next session needs only the brain and a prompt. Do not make a separate doc.

- First, write all durable knowledge back to the brain the way its own rules say: decisions,
  findings, sessions, plans. The handoff is then a thin **pickup note** that points into that
  knowledge rather than repeating it.
- Put the pickup note where the brain keeps active plans, or where its rules say. Name it with
  the work and the date. Mark any older pickup for the same work as superseded so that only one
  is live.
- Follow the brain's own rules on what may go in it. Local-only state, such as recordings,
  folders on the user's machine, or signed-in sessions, is described generically ("only on the
  user's laptop, in the demo workspace") and never by private path when the brain forbids that.
- Commit and push it the way the brain's writeback rules say, since those rules authorize that
  write.

Without a brain, the default carrier is a **shareable doc** from whichever doc tool is
connected, such as a Claude doc, Notion page or Google Doc. It syncs to the user's account,
opens on any device, needs no repository, and can be handed to the next session as a link or
pasted in whole. If no doc tool is connected, ask where the user wants it. If they name nothing,
write a local file and also print the handoff in chat. Substitute when the situation is clearly
better served:

| Situation | Carrier |
| --- | --- |
| The project has a brain | The brain's pickup note, pushed per its rules. No doc. Report its path in the brain. |
| No brain; phone, tablet, any second device | Shareable doc. Report the link. |
| User wants to paste it into a session with no fuss | Print it in chat, or send it to themselves on a connected chat tool such as Slack. |
| Work already tracked in a ticket | That ticket or page, if its tracker is connected. If not, print the text for the user to paste there. |
| Next session is a cloud coding session that will edit this branch | Shareable doc **and** a pushed branch. Put the file at `plans/handoff-<branch-slug>.md` too so the next session reads it beside the code. |
| Next session is another local session or worktree | File on the branch. |

A repository file alone is the wrong default. It reaches the user only through a cloud session
on that branch, which is more machinery than reading a page.

For the raw conversation rather than a summary, mention once that the agent can export the
transcript to a file, if it can (in Claude Code, `/export`). Say so once; do not produce both unless asked.

---

# Part 2 — Take the inventory before writing

Read the working state from the repository, not from memory. A long session may have been
compacted, and recollection of file state is the first thing to go.

```bash
git branch --show-current
git status --porcelain
git log --oneline -8
git diff --stat
git stash list
```

Also establish, by looking rather than assuming: which files this session actually changed,
whether anything is running (dev server, ports, background jobs), and what local-only state
exists (`.env`, seeded database, authenticated CLI tools).

If the session was compacted, say so in the handoff and mark which sections are reconstructed
from a summary rather than recalled directly. A confident wrong handoff costs more than an
honest gap.

---

# Part 3 — Write the file

The content is the same whatever the carrier. Title it with the branch and the date so several
handoffs are distinguishable at a glance. When a repository copy is also going out, name it per
branch — `plans/handoff-<branch-slug>.md`, or `HANDOFF-<branch-slug>.md` at the root if the
repository has no `plans/` — so parallel worktree sessions do not overwrite each other.

Write for a reader with zero context. Do not restate the repository's agent instructions (`AGENTS.md`, `CLAUDE.md`), its conventions, or
the stack; the next session loads those itself. `writing-discipline` governs the prose.

Sections, all of them, in this order:

**1. Start here.** Repository, branch, current commit. Then the literal prompt the user pastes
into the next session, quoted on its own line and ready to copy.

**2. The task.** What this session was asked for, in the user's own framing. State plainly
whether it is finished, partway, or blocked.

**3. State of the work.** Done, in progress, not started — each tied to the files it lives in.
"In progress" means: what is half-written and what condition it is in.

**4. Decisions and why.** The expensive part to reconstruct. For each: what was chosen, what
was rejected, and the reason. A decision without its reason will be relitigated or reversed.

**5. Files that matter.** Path, one line on why it matters, and whether this session changed it.

**6. Dead ends.** What was tried and did not work, so the next session does not pay for it
twice. Omit the section only if there genuinely were none.

**7. What does not travel.** Uncommitted work, `.env` and secrets, running servers, local
database state, authenticated tools. Then the consequence: name what the next session therefore
cannot do — run the app, hit a live service, reproduce a bug that needs real data.

**8. Next steps.** Ordered and concrete. The first one runnable as written.

**9. Open questions.** Only what needs the user's decision, and what each answer would change.

---

# Part 4 — Carry it across

Writing the brain's pickup note and pushing it under the brain's writeback rules, creating the
shareable doc, or writing the file locally is the delivery itself. Do it without asking, and
report where it lives.

Pushing is a separate, outward action. **Stop and ask**, and say what will be pushed: the
unfinished work in the tree, and the handoff file if one is going to the repository. Unfinished
work is the point — a push that leaves the working tree behind gives the next session a branch
that does not match the handoff.

Never push to a protected branch. The work-in-progress commit belongs on the current feature
branch.

**Report, in this order:**

1. The link or path the user opens on the receiving device.
2. **The opening prompt, in a fenced code block, ready to copy in one gesture.** See below.
3. Whether the branch is pushed.

If the code was not pushed, say plainly that the next session can read the handoff but cannot
continue the work, and name what is missing from the remote.

## The opening prompt

The user is about to copy this on a phone, one-handed, possibly on a moving bus. It has to
survive that.

- Put it in a fenced code block on its own. Nothing else inside the block.
- **Spell the URL out in full, literally.** Never a markdown link, never a shortened or
  reference-style link, never "the doc above" or a placeholder standing in for the real
  address. The raw address has to be visible in the copied text.
- Make it self-contained: it names the repository and branch where those apply, tells the next
  session to read the handoff before doing anything, and ends with a marked slot for the new
  request.
- Never emit it with the link unresolved. If the carrier failed and there is no address yet,
  say so instead of shipping a prompt with a hole in it.

With a brain, the prompt names the brain repository and the pickup note's path inside it, and
tells the next session to follow the brain's startup rules first. No link to anything outside
the brain:

```
Pick up work from another session. Follow the startup rules of the <brain name> brain
(<brain repository>, branch <default branch>), then read <pickup note path> in full
before doing anything else. The brain is the reference for state, decisions and next steps.

Then: <your new request here>
```

Without a brain, use this shape, with every angle-bracket slot filled in for real:

```
Read this handoff from another session in full before doing anything else:
<the complete link or path>

It has the state of the work, the decisions and why, and what does not travel.
Repository <name>, branch <branch>.

Then: <your new request here>
```

Fill the request in yourself. You know what is done and what is left, so write the concrete next
task:

- what to start with;
- what can run in parallel;
- what to bring to the user for decisions;
- what "done" means.

Leave a `<your new request here>` slot only when the next request genuinely cannot be inferred.
When the user asks for the prompt as a file, write it there with the request already filled in.
After the block, add one line naming what to do if the link does not open on the other device:
paste the handoff text itself, which is written to stand alone.
