---
name: handoff
description: "Use when work moves to a session that starts with no memory of this one: switching AI provider or account before a usage limit hits, starting a clean session to free up context, or continuing on another machine. Syncs everything durable from this session into the project's brain, writes a pickup note that a cold-start agent can resume from without drift (end goal, what is done and proven, what is left, fixed decisions, next steps, subagent lanes), tests it with a cold-read review, and returns the opening prompt. Also use when starting work from a pickup note. Not for publishing finished work, which is `ship`."
---

# Handoff

## Purpose

Move in-progress work to a session that starts with nothing. That session may run on another provider, another account, another model, or the same agent with a clean context. It receives two things, the brain and an opening prompt. From those alone it must continue as if the first session never ended. It knows the end goal, what is done and how that was proven, what is left, which decisions are fixed, and the first command to run.

A handoff is a brain sync plus an opening prompt. The brain carries everything, and the prompt points into it. Never hand off through a doc tool, a hosted artifact, a chat message, a ticket, or a transcript export. Those split the record from the brain, and the next session cannot keep them current as it works.

Common triggers:

- A usage limit is close on one provider, and the work continues on another.
- The session is long, and a clean one will attend to the work better.
- The work continues on another machine or in a cloud session.

**Boundary.** This skill syncs knowledge and packages state. `plan` designs the work, and `ship` publishes it. The only outward actions here are delivering the brain writeback and, when the code must reach another machine, pushing the work branch.

## Order the work so a cutoff still leaves a handoff

A handoff often runs just before a session ends. Work in this order, so that stopping after any step leaves something the next session can use:

1. Find the brain (Part 1). Choose the pickup note's path and copy the template there, with its status `partial` (Part 4). If the budget is nearly gone, print the opening prompt now (Part 6).
2. Take the inventory (Part 2).
3. Fill the core of the pickup note: "End goal", "As of", "State", and "Next steps" (Part 4).
4. Sync durable knowledge into the brain (Part 3).
5. Finish the pickup note (Part 4).
6. Check it mechanically, then by cold read (Part 5).
7. Deliver, set the status to `ready`, and report (Part 6).

Write each piece to disk as soon as it exists. Knowledge that lives only in the conversation is lost when the session ends.

---

# Part 1. Find the brain

A brain is a curated knowledge base with an `AGENTS.md` that sets startup and writeback rules, and a memory index. Find the project's brain in this order: a project-to-brain map in the user's agent instructions, a pointer in the work repository's agent instructions, then the current directory.

Read the brain's `AGENTS.md` and memory index before writing anything. Its rules decide where knowledge goes and what may go in, for example whether machine paths or personal details are allowed. This skill adds only the pickup note, the cold-read review, and the opening prompt.

**No brain.** Ask once whether to create one with `new-brain`, and recommend it when the work will run across more sessions. If the user declines, or the budget cannot fit the interview, write the pickup note as one file in the work repository at `plans/handoff-<work-slug>.md`. Leave it uncommitted unless the user says otherwise. That file is then the whole record, and the rest of this skill still applies to it.

---

# Part 2. Take the inventory from the source

Read state from the repositories and the conversation, not from recollection. A long session may have been compacted, and file state is the first thing recollection gets wrong.

For each repository the work touched, record:

```bash
git rev-parse --show-toplevel
git branch --show-current
git rev-parse --short HEAD
git status --porcelain
git stash list
git log --oneline -8
git rev-list --left-right --count @{u}...HEAD   # behind and ahead of the upstream, when one is set
```

Then establish, by looking rather than assuming:

- Which files this session changed.
- What is running, such as dev servers, ports, background jobs, and watchers.
- What exists only on this machine, such as `.env` files, seeded databases, signed-in tools, and downloaded files.
- The commands that set up, build, test, and run each repository, and what each gives today.

Then walk the conversation from its start and list:

- Every decision, with what was rejected and why.
- Every correction the user made and every preference they stated, quoted. A fresh agent gets these wrong first.
- Findings, each with its evidence.
- Dead ends, each with why it failed.
- Terms coined during the session. A fresh agent cannot know what a nickname for a design direction or a component refers to.
- Approvals the user gave in this session, such as permission to push a branch.
- What was verified, how, and what was not verified.
- Open questions.

If the session was compacted, say so in the note, and mark which items come from the summary rather than from direct recall. A confident wrong handoff costs more than an honest gap.

---

# Part 3. Sync durable knowledge

Write back everything durable under the brain's own writeback rules: topical memory files, decision records, the session file, and the memory index. Writeback runs without asking.

Put each piece of knowledge in one place:

| Knowledge | Where it goes |
| --- | --- |
| A fact about the subject that will stay true | The topical memory file the brain's rules name |
| A decision with its reasons | A decision record, per the brain's rules |
| What happened in this session | The session file, which is history |
| A user preference or working rule | The memory file the brain uses for working norms |
| The live state of the work: goal, progress, next steps, lanes | The pickup note, which looks forward |

The pickup note links to the other places instead of repeating them. It restates each fixed decision in one line, so the next agent can act without opening every record. If the line and the record ever disagree, the record wins.

Make the knowledge easy to find, and exact once found:

- In the memory index, add or update one active-context bullet that links the pickup note. A session that starts in the brain then finds the work even without the prompt.
- Use the names the code and the brain already use. Define every term coined in the session under the pickup note's "Traps".
- Fill the pickup note's "Map" with where each topic of this work lives, so the next agent opens a file instead of searching.
- Write exact identifiers in code font: repository-relative paths, commit hashes, branch names, full commands, URLs, and IDs. "The config file" sends the next agent searching. `apps/web/next.config.ts` does not.
- When this session made something stale, update or supersede it in place, and list it under the pickup note's "Traps".

Then tick off the inventory from Part 2. Each item now lives in a named file, or you dropped it on purpose because it is not durable.

Never store a secret in the brain. Say where it lives instead, if the brain's rules allow that.

---

# Part 4. Write the pickup note

Copy `pickup-note.md` from this skill's folder. Fill every section, and delete each guidance comment once its section is filled.

The pickup note is the work's active plan. It carries the objective, status, and next action that the brain's planning rules ask of a plan, so it is not agent runtime state. Put it with the brain's active plans, which is `planning/active/YYYY-MM-DD-<work-slug>.md` in a brain built from the usual template. If the brain's rules name another place for active plans, use that place.

Keep one live pickup note per piece of work:

- If an active plan or pickup note for this work already exists, update it in place.
- If a new pickup note replaces an older one, mark the older one superseded with a link to the new one, and archive it under the brain's rules.

Write for a reader with no context, who may be a different model from a different provider:

- Write nothing that needs the conversation to decode, such as "as discussed" or "the approach we chose".
- Give every done item its evidence: a commit, a test command and its result, or a screenshot path. An item without evidence goes under "In progress", marked unverified.
- End every next step in a check that can fail. Make the first step runnable as written.
- Split the remaining work into lanes a subagent can take alone, using the parallel test in `plan` (Phase B2, "Decide what runs in parallel"). Write each lane's brief so it stands alone, because a subagent receives the brief and not the pickup note.
- Name what stays in the main thread: integration, any file more than one lane writes, and questions for the user.
- If the work follows one of the user's skills, or needs a connected tool, list it under "What does not travel" with where it lives. The next agent may run on a provider that does not load it.

Keep the pickup note short enough to read in one pass, about 150 lines once filled. Move detail into linked memory, decision, or session files.

---

# Part 5. Check the pickup note

## Mechanical check

Run the note checker from this skill's folder. Pass the brain root and every repository the pickup note refers to:

```bash
bash <this skill's folder>/check-note.sh <pickup note> <brain root> <repository root> ...
```

It fails on a path or link that does not exist, a commit hash that no given repository has, a template comment or placeholder left in, and a core section that is missing or empty. Fix each failure, or confirm it is a false alarm, such as a generic type written outside code font. Then run the brain's own validator.

## Cold-read review

The test of a handoff is whether an agent with no context does the right next thing. This session cannot run that test on itself, because it cannot forget the conversation. The cold read tests whether a fresh reader understands the pickup note. Whether the plan inside it is right is `plan`'s review, so do not repeat that review here.

1. Start a reviewer with no context: a fresh subagent, or a fresh non-interactive session of any installed agent. If you know which agent will receive the handoff and it is installed, use it, since that tests the real reader. Otherwise prefer a different model from this one. Give the reviewer only the opening prompt and read access to the brain and the repositories, and tell it to change nothing.
2. Have it follow the opening prompt and the pickup note's pick-up steps, without acting on them, then answer:
   - What is the end goal, and what does done mean?
   - What is done, and what proves it?
   - What is in progress, and in what condition?
   - What would you run first, and why?
   - What must you not change or reopen?
   - What would you ask the user before starting?
   - Where did you have to guess, infer, or search? Which claims could you not verify against the repositories?
   - Which instruction could you read two ways? What in the brain contradicts the pickup note?
3. Compare its answers with what you know. Each mismatch is a defect in the pickup note, not in the reviewer.
4. Grade each defect:
   - **P0.** The reviewer would do the wrong thing, or would undo a fixed decision.
   - **P1.** The reviewer would have to ask, guess, or rediscover something costly.
   - **P2.** Polish.
5. Fix every P0 and P1, then run a new reviewer on the revised pickup note. Stop after two rounds. Record open findings and deferred P2 items under "Review", so nothing is dropped silently.

If no reviewer can be started, or the session cannot fit one more round, skip to delivery and set the cold-read line to `not run`. The receiving session then lists its own guesses as open questions before it acts.

---

# Part 6. Deliver and report

**The brain.**

- On the same machine, the next session reads the brain from disk. No commit or push is needed for the handoff. Commit only as the brain's rules and the user's standing instructions say.
- For another machine or a cloud session, the brain must be pushed. If its rules and the user's standing instructions authorize the push, push it. If they do not, or the brain has no remote, ask the user. A brain that exists only on this machine cannot cross to another one, so say that plainly if the user declines.

Then set the pickup note's status to `ready`.

**The code.**

- On the same machine, leave the working tree as it is. The pickup note's "As of" records it, and the next session checks it.
- On another machine or in a cloud session, only a pushed branch moves code. Commit work in progress on the current feature branch, never on a protected branch, and ask before pushing unless a standing rule covers it. If the code is not pushed, tell the user that the next session can read the handoff but cannot continue the work, and name what is missing from the remote.

**Report, in this order:**

1. The opening prompt, in a fenced code block on its own.
2. The folder to start the next session in. Pick the folder the work writes to, usually the code repository. Some agents can write only inside the folder they start in, so say when the brain must be added as a second folder.
3. Where the pickup note lives.
4. Whether the brain and the code are committed and pushed.
5. The cold-read result: the rounds run and the open findings, or that it did not run.
6. What does not travel, in one line.

## The opening prompt

The user may paste the prompt into any agent, from any provider, in a hurry. It has to work there.

- Use plain instructions only. Leave out slash commands, tool names, and skill names the receiving agent may lack.
- Spell out every path and address in full. Never use a placeholder, a markdown link, or "the note above". On the same machine, give the brain's absolute path. For another machine, give the brain's repository and branch.
- Fill in the next task yourself. You know what is done and what is left.
- Name the lanes to hand to subagents. A user who pastes the prompt has then asked for those subagents, which matters to agents that start subagents only on request.
- Never print the prompt with an unresolved path. If the pickup note could not be written, say so instead.

```
Continue work handed off from another session. You have no memory of that session. The brain is the record.

1. Open the <brain name> brain at <absolute path, or repository and branch> and follow the startup rules in its AGENTS.md.
2. Read <pickup note path inside the brain> in full, then follow its "How to pick this up" steps before anything else. It holds the end goal, what is done, what is left, and the decisions and fences not to cross.
3. Then: <the next task, written out: where to start, which lanes to hand to subagents, what to bring to the user, and what done means>
```

---

# Part 7. Pick up from a pickup note

When you are the receiving session, follow the pickup note's "How to pick this up". Those steps live in the pickup note, so an agent without this skill follows the same ones. To change them, change `pickup-note.md`, not this part.
