---
name: plan
description: "Use before writing code, whenever deciding what to build or how: choosing between approaches with no precedent, weighing a product or scope tradeoff, or producing an implementation plan, roadmap, sequencing, or pre-execution handoff. Also triggers on requests for adversarial plan review. Covers exploring the design space and hardening the resulting plan."
---

# Plan

## Purpose

Find the right shape, then write a plan that survives hostile review grounded in repository truth. Both halves are one job: a plan built on an unexplored design space is decision-complete about the wrong design.

This extends — never replaces — repository instructions, user-intent clarification, and active Plan Mode rules. Ground it with `investigate`; shape the resulting code with `implement`.

**The letter of this workflow is the spirit.** Skipping the review because the plan feels solid is the exact failure this exists to catch.

## When to Use

- The user asks for any plan, approach, strategy, sequencing, or handoff before execution.
- A decision has no precedent in the codebase, or a product/scope tradeoff comes up.
- You are facing bulk or repetitive work, or you catch yourself writing the same instruction a second time.
- Hidden assumptions could create implementation risk.

**Skip only for:** tiny one-shot edits, simple command outputs, or already-approved execution where the work is to implement rather than plan.

## Phase A — Explore the Design Space

Skip this phase only when the pattern is established, the target state is clear (a defect fix or refactor), or constraints dictate one viable approach.

### A1. Build competing prototypes before committing

When a novel interaction or architectural decision has no established precedent, build two or three concrete alternatives and compare them side by side. Building the wrong thing costs more than exploring three options. A second flavor of the first shape does not count as an alternative.

**Before asking which approach to take, classify the question.** If the answer is a fact you could observe by running something — behavior, timing, layout, output, performance — it is not a question for the human. Sketch it and let the result decide. Reserve the question for a genuine product or preference call that no experiment can settle.

### A2. Choose the experience over the convenience

When implementation convenience conflicts with the experience of whoever consumes the work, choose the experience.

- Every feature, control, and option must justify itself.
- Ship fewer things, polished, over more things, rough.
- Get the details right: transitions, alignment, spacing, feedback, error states.
- Every feature should serve the central workflow or get out of the way.

The user is whoever consumes the work: the end user for a UI, the colleague who imports it for a library, and the engineer who maintains this code next. Weigh their experience the same way, and explain impact from their perspective rather than from the implementation's.

### A3. Build the lever

When the work is not trivial, build the tool that does it instead of doing it by hand.

Two payoffs. Throughput, because a script does the work the same way every time and reruns for free. Confidence, because the tool is one artifact a reviewer can read and rerun. Hand-done changes can only be re-verified by redoing them. A deterministic script turns "trust me" into "run this."

- Do the first unit by hand to learn the recipe, then build the tool. Prove it by rerunning it on that unit and diffing against your hand-done version.
- Make the lever safe to rerun; see the idempotence rules in `implement`.
- A codemod or script for edits, a generator for repetitive files, a query for analysis, a rerunnable check for verification.
- A deterministic lever beats fanning work out. If the tool can process every unit in one pass, run it rather than delegating hand-application.
- When you do fan work out, write the recipe, the verification contract, and the do-not-touch fences into one artifact every worker reads.
- Applying this produces a file. If you claimed it and there is no script, codemod, or generator in the diff, you did not apply it.

**The bar is triviality, not repetition.** A one-off still earns a lever when the lever is what makes the work checkable. Build the smallest script that does or proves the job, never a framework.

### A4. Encode recurring lessons in structure

When you catch yourself writing the same instruction a second time, stop writing instructions.

1. Ask whether it can be a lint rule, a metadata flag, a runtime check, or a script.
2. If yes, encode it and delete the instruction.
3. If it genuinely requires judgment, make the instruction more prominent and add an example of the failure it prevents.

**Pick the strongest mechanism available**, in this order: a state that cannot compile, then a lint or banned API that fails CI, then a canonical helper, then a runtime check. Engineers and agents copy whatever the surrounding code already does, so a weak guard becomes the next template.

**If the fix is structural, use only the structural fix.** The instruction is the symptom.

**Anti-patterns:** acknowledging a correction without recording it, recording it without routing it to a mechanism, and fixing one instance while leaving the pattern intact.

## Phase B — Write and Harden the Plan

### B1. Ground in truth

- Read project instructions and only task-relevant project memory. Do not import another brain unless the user explicitly authorizes a scoped transfer.
- Inspect the actual repository: files, contracts, tests, schemas, runtime boundaries, open PRs, deploy notes, current branch state. Use `investigate` when the subsystem is unfamiliar.
- Separate discoverable facts from product preferences. Ask the user only for high-impact choices that cannot be derived.

### B2. Draft the plan

State goal, success criteria, boundaries, interfaces, data flow, edge cases, tests, rollout, and verification. It must be **decision-complete**: the implementer never chooses files, contracts, sequencing, or acceptance criteria.

- [ ] Every file to create or modify is named with a path.
- [ ] Every interface, type, or contract change is written out, not described.
- [ ] Tests are listed by name and behavior, riskiest paths first.
- [ ] Sequencing and gates between steps are explicit, and each unit ends in a check. See `test-design`.
- [ ] Verification commands are runnable as written.
- [ ] Rollout and rollback are stated when production behavior changes.

### B3. Adversarial review

- Spawn a dedicated adversarial reviewer on a different model when a subagent path is available and allowed. A research subagent does not count unless it explicitly attacks the plan.
- **Hand it:** the full plan, the goal, verified repository facts with file paths, and the constraints. **Require back:** findings with severity, each backed by a file path, contract, or runtime fact, not vibes.
- Fall back to local self-critique only when no subagent path exists or session rules prohibit one, and state that fallback in the final plan notes.
- The reviewer is hostile to: unverified runtime assumptions, vague seams (any component named without its exact contract), missing tests on risky paths, hidden state transitions, deploy and rollback gaps, stale branch context, and scope creep.
- Delegate only in trusted repositories. Preserve the full original contract on every retry; never chain only the preceding reviewer's text.
- The parent agent owns test, build, and runtime gates and must verify reviewer claims directly.

**Severity rubric:**
- **P0** — plan produces wrong behavior, data loss, broken deploy, or violates a repository contract. Blocks output.
- **P1** — plan forces the implementer to make a significant undocumented decision or rework. Blocks output.
- **P2** — polish, optional hardening, future work. Record as deferred; does not block.

### B4. Iterate to convergence

Revise for every P0 and P1, then re-review the revised plan. **Cap: 3 review rounds.** If P0 or P1 findings persist after round 3, stop looping and surface the unresolved questions to the user as explicit decision points instead of grinding. Preserve deferred P2 items explicitly; never silently drop them.

### B5. Output the final plan

One complete replacement plan, not a diff against drafts.

Title / Summary / Key Changes / Test Plan / Assumptions and Rollout Notes / Review Notes (what the critique changed, deferred P2s, fallback used if any). Add sections only when they prevent implementation mistakes. Write it through `writing-discipline`.

## Red Flags — STOP, you are rationalizing

| Excuse | Reality |
|--------|---------|
| "The user did not ask for a plan" | Default workflow. Explicit naming is not the trigger; planning is. |
| "The first approach seems fine" | If there is no precedent, you have not seen the alternatives yet. |
| "I will ask which one they want" | If running it would answer the question, run it. |
| "The plan is simple enough" | Simple plans hide unverified runtime assumptions. Review takes minutes. |
| "I already know this codebase" | Branch state, contracts, and deploys drift. Ground in current truth. |
| "The reviewer would just agree" | Then the review is cheap. If it would not, you need it. |
| "It is faster to just edit the files" | Faster to write, impossible to re-verify. Build the lever. |
| "I will note it in the instructions" | Second time writing it means it should be a check, not a sentence. |
| "I will fix gaps during implementation" | That converts P1s into mid-execution rework and scope creep. |
| "One more review round will fix it" (after 3) | Persistent blockers are user decisions, not yours. Escalate. |
