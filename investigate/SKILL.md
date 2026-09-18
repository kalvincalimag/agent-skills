---
name: investigate
description: "Use to understand existing code without changing it: how a subsystem works, why it was built this way, where something should live, or to explain it to a person. Read-only — stops at the answer and never edits. Not for checking whether a change works; that is `verify`."
---

# Investigate

## Purpose

Build an accurate mental model of code that already exists. Read-only. This is the grounding step `plan`, `bugfix`, and `verify` each depend on, and it is also a complete answer on its own when the question is only "how does this work?".

Three questions, three modes. Pick the one asked.

- **How** something works: runtime flow, architecture, ownership, layering, where a thing should live.
- **Why** it works that way: design rationale, the tradeoff someone made, a regression's origin, a threshold's justification.
- **Teach**: explain it to a person so they actually understand it, blending both.

## Boundaries

- Read-only. Do not edit, commit, or mutate state. If the investigation reveals a defect, report it and stop.
- Cite real evidence. A `file:line`, a commit, a linked discussion. A search that finds nothing is still an answer worth reporting.
- Never invent a caller, an API, a commit, or a quote.
- Separate confirmed from inferred, and name what would confirm each inference.

## How It Works

Answer at the level of a senior engineer onboarding onto a subsystem. Enough to build a working mental model, not so much that it reads like annotated source.

1. **Size the question.** A single module or a narrow question is one pass. A subsystem spanning several files or services, a cross-cutting feature, or a full architectural overview earns two to four parallel exploration angles first. When in doubt, take the simple path.
2. **Explore.** Trace the real path: entry point, the state it reads and writes, the boundaries it crosses, what runs when. Follow what a symbol search misses: the JSON an API returns, a database column, a wire format, a feature flag, code three hops downstream.
3. **Explain.** Cover overview, the key concepts, how it works, where things live, and the gotchas. Drop any section that does not apply.

For a placement question, answer it directly: which module owns this, what layer it belongs in, and what the current owner would have to know if it moved.

## Why It Works That Way

Motivation lives outside the code. Query every evidence source available in parallel, then report what each did and did not show.

- Source control: the commit that introduced it, the pull request that discussed it, the revert that followed.
- Issue tracker: the ticket and its comments.
- Long-form documents: design docs, RFCs, architecture records.
- Team chat: the thread where it was argued.
- Observability, error tracking, and analytics: the data that justified a threshold.

Record which categories you could not query, so the reader can weigh the gaps. Keep confidence language exact. A hedge is a finding, not a style choice. "The commit message says X" and "X appears to be the reason" are different claims and must read differently.

When the record is silent, say so. A missing rationale is a real answer and often the most useful one.

## Teach

The goal is that the person understands it, not that anything changes.

1. **Decide the few things they should walk away with.** Choose from why they are asking, which you read from the conversation rather than quizzing them. Skip what they plainly know. Put the depth where their question is.
2. **Run the how and why work first.** Do not redo it in the explanation.
3. **Start with a plain definition.** Name the thing, say what it is in general terms with its common name, then tie it to the case in front of them. Build from there: how it works, the deeper reasons, the edge cases.
4. **Give the smallest complete answer first**, a sentence or two, then stop. Add layers when they ask. Never a wall of text.
5. **Keep it a conversation.** No quizzes. Do not announce that a part is important, tricky, or interesting. Do not print framing labels such as "the key insight" or "at its core". Just say it.
6. **Show, do not only tell.** Open the diff or the code when that lands it fastest. For anything with three or more moving parts, draw a short series where each picture adds one part, rather than one diagram containing everything.

Write it through `writing-discipline`, in plain spoken English, at the density of: "Virtualization runs in two parts, one for rendering and one for loading from disk. When an item scrolls out past the buffer, both its DOM node and its in-memory data are evicted."

## Output

Lead with the answer. Then the account, then the threads worth chasing. Cite `file:line` for structural claims and a commit, ticket, or thread for motivation claims. Name the evidence sources you could not reach.

## Red Flags — STOP, you are rationalizing

| Excuse | Reality |
|--------|---------|
| "I know how this works" | Branch state and contracts drift. Read the current code. |
| "The commit message explains it" | That is one source. Check whether the discussion contradicts it. |
| "I will summarize the files" | Listing functions is reference, not understanding. Trace the path. |
| "There is probably a reason" | Find it or report that the record is silent. Do not invent one. |
| "I will fix it while I am here" | Read-only. Report the defect and stop. |
