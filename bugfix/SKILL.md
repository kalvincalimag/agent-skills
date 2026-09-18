---
name: bugfix
description: "Use when a user reports behavior that is broken, incorrect, or regressed and wants it repaired. Covers reproducing the exact reported state, aiming the fix at the real cause, repairing test-first, and proving the symptom is gone. Not for understanding code that is working correctly — that is `investigate`."
---

# Bugfix

## Purpose

Turn a reported symptom into a verified repair without losing the exact state that exposed it, and without aiming the fix at the symptom instead of the cause.

Compose with `verify` for claim discipline and evidence, `test-design` for whether the regression test can actually fail, and `ship` when delivery or deployed QA is requested — from the beginning of the task, not bolted on after a local fix. Repository instructions and explicit user direction take precedence.

## Boundaries

- In Plan Mode, produce only the investigation plan, evidence gates, and handoff criteria. Do not mutate code, git, deployments, browsers, or memory.
- A diagnosis-only request is read-only. Investigate and report; do not edit, commit, merge, or deploy unless the user authorizes a fix.
- Stop before destructive, irreversible, financial, or production actions unless the user explicitly authorizes that exact action.
- Default to one implementation agent. Use parallel agents only when explicitly requested, or when the work has genuinely independent investigation or review lanes that cannot conflict.

## 1. Establish the Reproduction Contract

Inspect every supplied screenshot, recording, error, log, or linked artifact before forming a diagnosis. Capture:

- exact route or entry point;
- user, auth, and account state, plus feature flags;
- viewport, device, browser, and network conditions when relevant;
- the data state that matters for this project: selected entity, locale, time range, environment, or whatever the project's own domain state is;
- expected behavior and the observed behavior;
- console, network, server, and persisted-state evidence;
- repeatability and any known intermittent timing.

Reproduce the symptom on the unchanged baseline when safe. If exact reproduction is blocked, record the missing prerequisite and distinguish confirmed evidence from hypotheses. **Never silently replace the reported state with an easier nearby state.**

Template: `evidence-templates.md` in this skill directory.

## 2. Freeze the Regression Matrix

Before edits, fill the regression matrix from `evidence-templates.md`. Include the exact reported state, adjacent states sharing the same contract, empty/loading/error states, and any old client, cache, or environment contract that may still exist. Capture named baseline failures and passes before claiming a delta.

## 3. Diagnose at the Defect Boundary

Trace the failing value or behavior across its real boundaries: source data, normalization, state selection, cache and freshness logic, API contract, rendering, and deployment or runtime configuration. Prefer evidence from the narrowest boundary that explains both the symptom and the unaffected cases.

### 3.1 Fix root causes, not symptoms

Symptom fixes accumulate. Each workaround makes the system harder to reason about and the real defect survives.

- Reproduce first. A fix aimed at a symptom you never reproduced is a guess.
- Ask why until you reach the cause. Stop when the next why has no answer inside your system.
- Do not add guards. A nil check that silences a crash is a symptom fix.
- If a workaround needs a paragraph of comment to justify it, the code is wrong. Fix the code, not the comment.
- Check for the pattern, not the instance. Search for the same shape elsewhere and fix every occurrence in scope.
- When stuck, instrument. Do not guess. Add logging and read the actual error.

**Restart defects: suspect state before code.** When something fails after a restart, suspect stale persistent state first: config, caches, lock files, serialized state. If clearing a state file restores behavior, the fix is state validation.

### 3.2 After two failed fixes, attack the premise

When two or more attempts that share one assumption have failed the same check, the assumption is the suspect, not the attempts. Each failure under a shared premise is evidence about the premise.

1. **Write the premise down.** One sentence that every failed attempt assumed.
2. **Take a census before the next attempt.** Count the imbalance per actor. The census shows which actors hold it, not how large it is. Write it as a rerunnable script, per `plan` A3.
3. **Read the skew.** If the same few actors hold most of the imbalance on every run, something assigns them that role. Find what assigns it. That assignment is the next why.
4. **Remove the asymmetry rather than compensating for it.** Rotate the role, randomize the assignment, or move it, so no actor holds it every run. A return path, a shared pool, or a periodic rebalance leaves the assignment in place and adds work forever.

**Stop conditions.** Do not start the next fix before the premise is written and the census exists. If the census is even across actors, the premise is not the cause. Look elsewhere and keep the census as evidence.

This is distinct from redesigning around a new requirement. It questions a fact the current design already assumes.

### 3.3 State the cause at the right confidence

A root cause is confirmed only when code or runtime evidence supports the whole causal chain. Otherwise label it inferred and name the check that would confirm it. One weak sample does not promote a hypothesis to a diagnosis.

## 4. Repair with TDD

1. Add the smallest regression test that reproduces the defect at the boundary where it belongs.
2. Run it against the unchanged implementation and verify it fails **for the expected reason**.
3. Make the smallest scoped fix that satisfies the intended contract, shaped by `implement`.
4. Run the focused test, then the regression matrix and broader repository gates required by risk.
5. Do not weaken tests or rewrite their intent to make a failure disappear. If intended behavior changed, explain the contract change and obtain required approval.

Make time, cache, environment, and race conditions deterministic in tests. Preserve unrelated dirty work and avoid opportunistic refactors.

When the defect is in an API endpoint, the contract rules in `implement` Part 3 supply the spec change inside this loop. One test-first cycle covering both behavior and contract, not two.

## 5. Verify the Exact User State

Manual QA must exercise the original route and state, not merely a component story or adjacent page. For UI defects, use the relevant viewport and inspect visible output plus console and network behavior, per `verify` Part 4. Save screenshots or equivalent artifacts for visual claims.

Repeat the original workflow enough times to cover its timing characteristics. Mark the symptom no longer reproducible only when the exact reproduction contract passes and the regression matrix stays green.

If delivery is requested, complete local gates, merge through `ship`, confirm the deployed build serves the exact merged commit, and repeat the same QA against that deployment. An HTTP 200 or a green build is not manual QA.

## 6. Treat QA Failures as New Bugs

For every failure found during local or deployed QA: add it to the QA iteration ledger, reproduce it deterministically where feasible, add a red regression test, fix the smallest causal boundary, rerun focused and broad gates, then repeat the original workflow and affected regression rows.

**Cap: 3 full fix-and-re-QA cycles.** When the cap is reached, stop and report the repeated pattern, the evidence, and the last verified state rather than rounding partial success up to done.

## Completion Contract

Report completion only when:

- the original symptom is no longer reproducible in its exact state;
- the defect-boundary regression test failed before the fix and passes after it;
- every required regression row and local gate passes;
- requested deployed QA ran against the exact merged commit and passed;
- no unauthorized irreversible action was taken.

If a gate cannot run, report the precise blocker and last confirmed state. Use the completion evidence checklist in `evidence-templates.md` for the final handoff.

## Red Flags — STOP, you are rationalizing

| Excuse | Reality |
|--------|---------|
| "A null check here fixes it" | It silences it. The value should not be null. Find why it is. |
| "I could not reproduce it but the fix looks right" | You are guessing. Reproduce, or say the fix is unverified. |
| "Third attempt will land it" | Two failures under one premise means attack the premise, not retry. |
| "It only happens sometimes" | Timing, cache, or stale state. Instrument rather than theorize. |
| "It works after a restart" | Persistent state is the suspect. Validate it. |
| "This instance is fixed" | Search for the pattern. The next instance is already written. |
| "I reproduced it on a simpler page" | That is a different bug. Use the reported state. |
| "The test is green now" | Did you see it red first, for the right reason? |
| "One more fix cycle will do it" (after 3) | A persistent failure pattern is information the user needs. Escalate. |
