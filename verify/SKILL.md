---
name: verify
description: "Use before claiming that anything works, is safe, is done, or has no regressions, and whenever a change needs proving end to end — browser, API, data, response. Also covers what a change breaks outside its own diff. Governs the evidence standard for every claim you make; `implement` governs the code itself."
---

# Verify

## Purpose

Keep non-trivial work evidence-based and provable. Three jobs, one standard:

1. **Claims** — what you are allowed to say, and what has to back it.
2. **Blast radius** — what the change breaks outside its own diff.
3. **The flow** — whether the thing actually works end to end, in a browser or a runtime, not just in a build log.

A writeup that sounds right is worthless, because it reads as convincing whether or not it is true. Run code.

This does not override repository instructions or expand authorization for commits, pushes, pull requests, deployments, or memory writeback. Outward-action boundaries are owned by the user's standing autonomy rule.

## When This Triggers

- You are about to say "works", "safe", "done", "fixed", or "no regressions".
- A dev server just started, or the user says something is not quite right or almost works.
- The user asks you to verify a feature or check the full flow.
- A brief asserts something about existing code ("make X public", "X already handles Y") and you are about to design against that assertion.
- You are reviewing a diff you do not trust.

---

# Part 1 — Claims

## 1.1 Mark important claims

- Confirmed claims name evidence: file path, command, runtime check, source read, PR or check status, or artifact.
- Inferred claims say they are inferred and name what would confirm them.
- Do not turn a diagnosis, root cause, "works", "safe", or "no regression" claim into fact from one weak sample.

## 1.2 Capture the baseline before claiming no regression

- Record starting branch, commit, and dirty state when code or memory changes.
- For tests and checks, capture the baseline count or named failures before comparing later results.
- Report deltas: `baseline 2 failing {a,b} -> still 2 failing {a,b}`, or `now 3: +c, likely caused by this change`.

## 1.3 Use gates that can fail

- Prefer real tests, builds, lint and typecheck, HTTP smoke, browser or device checks, generated artifact inspection, or source readback. `test-design` decides whether the test itself can fail for a defect.
- A compile or build alone does not prove runtime behavior. For visual, stateful, or user-facing work, inspect the actual screen or artifact when feasible.
- If a stage cannot be verified, label it unverified instead of implying confidence.

## 1.4 Treat agent and reviewer output as hypotheses

Do not accept a subagent's "complete", a review finding, stale memory, or a README statement without checking the cited files or output. Keep findings that survive direct inspection; discard contradicted ones and say why if relevant.

## 1.5 Stay scoped

- Stage only files intentionally changed for this task.
- Name unrelated dirty or untracked work and leave it alone.
- If a file contains mixed user and agent changes, inspect before staging. Do not blanket-add a directory unless the task is explicitly a consolidation.

## 1.6 Close with state

Say what changed, what was verified, what is committed or pushed or PR'd, what remains dirty, and what is inferred or unverified. For user-side checks, name exactly what only the user can verify.

---

# Part 2 — Blast Radius

Listing the callers is not the job. A search finds those in a second. The job is the breakage a search will not show you.

Run this before design, not only before shipping, when a brief asserts something about existing code. The assertion is a hypothesis, and the census of consumers is what decides the design.

## 2.1 The confidence ladder

For each fact the change's safety depends on, get it as far down this list as is cheap, and state where it stopped.

1. **You said so.** Worthless on its own.
2. **You pointed at the line.** A real `file:line`, or the dependency's own source.
3. **You showed the bad case cannot happen.** You walked the failure step by step and it does not reach.
4. **You ran it.** A script or test that calls the real code and fails loudly if you are wrong.
5. **You reproduced it in the running application.**

Any safety fact you cannot get to step 4, say so. Do not write it up as settled. Step 4 is usually one small script that imports the same dependency the application ships and calls the exact function you are worried about.

## 2.2 Steps

1. **Read the change.** The diff, the symbols it adds, changes, and deletes, and what it now does differently, including the part the diff does not spell out.
2. **Find the one fact it is safe because of.** Most changes that look risky are safe because of a single fact, such as "this call only drops already-dead cache entries and does nothing else". Find that fact. If it holds, most of the risky cases clear at once. Spend your time here, not on a long list of maybes.
3. **Look where a search stops.** Read the source of the dependency you call, and check its pinned version and any local patch. Work out when things run: microtasks, teardown, framework scheduling. Follow what a symbol search misses: the JSON an API returns, a database column, a wire format, another language reading the same bytes, a feature flag, code three hops downstream, a cached value, a deployed client still on the old shape.
4. **Be honest about each risk.** Give it a real chance of happening and a real cost if it does. Keep the risks you confirmed and list the ones you checked and cleared separately. Cite a real `file:line`. A search that finds nothing is still an answer. Never invent a caller or an API.
5. **Prove the one fact.** Write a script or test that runs the real code, run it, and paste what happened. If you cannot prove it cheaply, mark it unproven rather than overstating.
6. **For a wide change, get a second opinion.** Ask the same question against a different model and merge the answers. Different models catch different real defects. Agreement is high signal.

## 2.3 What to hand back

- **What it does.** What changed, including the part that is not obvious from the diff.
- **The one fact it is safe because of.** State it, name the ladder step you reached, and show the proof. If you could not prove it, write unproven.
- **Risks.** Only the real ones. Each names how it breaks, the `file:line`, how likely and how costly, and how to check it.
- **Cleared.** What you checked and why it is fine.
- **Before you merge.** The cheapest test or reproduction that catches the real defect, including the script you wrote.

Write it through `writing-discipline`. Strip anything private before it goes anywhere public.

---

# Part 3 — The Flow

Do not run a single check. Infer the complete user story being built and verify every boundary in it with evidence.

## 3.1 Infer the user story

1. Read recently edited files: the diff or recent edit history.
2. Identify the feature boundary: which routes, components, API endpoints, and data sources are involved.
3. Scan the package scripts and route structure. Inspect environment-variable names and configuration presence without printing secret values.
4. State the story in one sentence: *"The user is building X which flows from [UI entry point] to [API route] to [data source] to [response rendering]."*

**Do not skip this.** Every subsequent check anchors to the inferred story. Use `investigate` when a boundary is genuinely unclear.

## 3.2 Establish the evidence baseline

| Layer | How to check | What to capture |
|-------|-------------|-----------------|
| **Browser** | Part 4 | Visual state, console errors, network failures |
| **Server terminal** | Read the dev server process output | Startup errors, request logs, compilation warnings |
| **Runtime logs** | The project's own log command, or server stdout | API response codes, error traces, timing |
| **Environment** | Check configuration names and scope without printing values | Missing variables, wrong scope, environment mismatch |

Use the project's real tooling. Do not reach for a hosting provider's CLI the project does not use.

Report each layer before proceeding: what you are looking at, what you found (quote actual output), and what it means for the next step.

## 3.3 Walk the data flow

1. **UI trigger** — what user action initiates the flow: button click, page load, form submit.
2. **Client to server** — what request is made. Check the fetch or action call; verify the URL, method, and payload match the route.
3. **Route handler** — read the file. Does it handle the method, validate input, call the right service or database?
4. **External dependencies** — if it calls a database, third-party API, or hosted service, verify the client is initialized, required credential names are configured without exposing values, and the call shape matches the authoritative SDK documentation.
5. **Response to UI** — does the response format match what the client expects? Is error handling present on both sides?

Common breaks at each boundary: a missing `await`; a method mismatch (GET handler, POST fetch); an environment variable absent at runtime but present in the local env file; an import mismatch across the server/client boundary; a type mismatch between response and expectation; a missing error boundary letting an unhandled rejection kill the page silently.

## 3.4 Report with evidence

```
## Verification Report: [Feature]

**Story**: [one sentence]

| Boundary | Status | Evidence |
|----------|--------|----------|
| UI renders | pass/fail | [screenshot or console output] |
| Client to API | pass/fail | [request/response or error] |
| API to data | pass/fail | [log output or error trace] |
| Data to response | pass/fail | [response shape or error] |
| Response to UI | pass/fail | [rendered output or error] |

### Issues
1. [Issue]: [evidence] -> [fix]

### Verified working
- [what was confirmed, with evidence]
```

## 3.5 Stop conditions

**Stop when:** every boundary is confirmed with evidence; or you hit the **first** broken boundary — report it with evidence and a specific fix and do not continue past the break; or two consecutive layers return no useful signal, in which case flag the observability gap and recommend adding logging first.

**Do not:** run the same check more than twice, continue past a confirmed broken boundary, verify unrelated features, or spend time on cosmetic issues unless asked.

---

# Part 4 — Browser Checks

Run `command -v agent-browser` before the first browser action. If the CLI is unavailable, use an already-available repository-approved browser or Playwright workflow that gives equivalent visual, console, and interaction evidence. If no equivalent runtime exists, report manual browser QA as **blocked** — do not claim it passed, and do not install a dependency without the required approval.

Command reference: `agent-browser.md` in this skill directory.

## 4.1 Checklist

1. **Page loads** — open succeeds without timeout.
2. **No blank page** — the snapshot shows meaningful content, not an empty body.
3. **No error overlay** — no framework error overlay or dialog present.
4. **Console errors** — captured and reported.
5. **Key elements render** — an interactive snapshot shows the expected elements.
6. **Navigation works** — verify at least the home route when several exist.

## 4.2 On failure

Screenshot the error state, capture the overlay text or console output, close the browser, fix the code, and re-run. **Maximum 2 retry cycles.**

## 4.3 Diagnosing a stuck page

The browser is half the story. Correlate it with server-side evidence.

| Browser shows | Server shows | Likely issue |
|--------------|-------------|-------------|
| Loading forever | No recent invocations | The route is not being called — check the fetch URL in client code |
| Loading forever | Started, no step logs | A step is stuck — instrument entry and exit |
| Blank page, no errors | Build fine, no runtime errors | Hydration issue or missing data — check server vs client rendering |
| Network request pending | Gateway timeout in logs | Function timeout — raise the limit or optimize the step |
| "Failed to fetch" | Identity or credential error | Inspect the documented environment setup without exposing values |
| Error overlay | Stack trace in runtime logs | Read the server error; it usually has more detail than the client |

---

## After Implementation

When you finish building a feature, briefly mention the user can ask for a verification pass. One sentence. Skip it for a small fix or a question.

## Before Sending

- Can a reader tell confirmed claims from inferred claims?
- Did you claim no regressions without a baseline?
- Did you trust an agent, reviewer, or memory claim without direct evidence?
- Did you stage files outside the task scope?
- Did you check what still speaks the old contract, and prove it?
- Is the answer larger than the task deserves?

## Red Flags — STOP, you are rationalizing

| Excuse | Reality |
|--------|---------|
| "The build passed" | A build does not prove runtime behavior. |
| "I listed every caller" | A search found those. The breakage a search misses is the job. |
| "It is a small diff" | Small diffs to shared code have the widest radius. |
| "The types would catch it" | Not across a wire format, a cached value, or a deployed client. |
| "I am confident it is safe" | Which ladder step? If it is below four and step four is cheap, run it. |
| "I will write up the risk analysis" | A convincing writeup is not evidence. Prove the one fact. |
| "The server started, so the page works" | Blank pages and hydration errors are visible only in the browser. |
| "The page returned 200" | That is not QA. Exercise the workflow and read the console. |
| "The subagent said it was complete" | A hypothesis until you check the cited files. |
