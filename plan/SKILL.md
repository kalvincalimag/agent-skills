---
name: plan
description: "Use before writing code, whenever deciding what to build or how: choosing between approaches with no precedent, weighing a product or scope tradeoff, or producing an implementation plan, roadmap, sequencing, or pre-execution handoff. Also triggers on requests for adversarial plan review. Covers exploring the design space and hardening the resulting plan, so the result is technically precise, demoable when it has a user-facing result, and built to last and to extend, with planning effort matched to risk."
---

# Plan

## Purpose

Find the right shape, then write a plan that survives hostile review grounded in repository truth. Both halves are one job: a plan built on an unexplored design space is decision-complete about the wrong design.

Every plan serves four outcomes the user wants. The reviewer in B3 attacks a plan that misses one.

- **Technically precise.** Every path, contract, version, number, and command in the plan is exact and checked against the repository or a current primary source. The implementer never has to guess.
- **Demoable, when the work has a user-facing result.** The plan ends in something a person can run and watch work end to end, and it reaches a thin working version early.
- **Built to last.** The care goes to the decisions that are costly to reverse. The plan names the likely extensions and keeps them cheap to add, without building them now.
- **Efficient, effective planning.** Effort goes where a wrong call is expensive. Research runs in parallel, the user is asked once, and the plan is no longer than decision-completeness needs. The implementer can follow it to the success criteria without coming back with questions.

This extends — never replaces — repository instructions, user-intent clarification, and the rules of any active planning-only mode, such as Plan Mode. Ground it with `investigate`; shape the resulting code with `implement`.

**The letter of this workflow is the spirit.** Skipping the review because the plan feels solid is the exact failure this exists to catch.

## When to Use

- The user asks for any plan, approach, strategy, sequencing, or handoff before execution.
- A decision has no precedent in the codebase, or a product/scope tradeoff comes up.
- You are facing bulk or repetitive work, or you catch yourself writing the same instruction a second time.
- Hidden assumptions could create implementation risk.

**Skip only for:** tiny one-shot edits, simple command outputs, or already-approved execution where the work is to implement rather than plan.

## Size the effort to the decision

Spend planning effort where a wrong call is expensive. This sets how deep each phase goes. It never decides whether B3 runs.

- **One-way decisions** are costly to undo once code, data, or people depend on them: the stored data model, a public contract such as an API or a file format, the choice of framework or vendor, and the permission model. Give each one alternatives (A1) when more than one is viable, checked facts (B1), a written-out contract (B2), and the reviewer's attention (B3).
- **Two-way decisions** are cheap to change later: internal names, the layout inside a module, a library hidden behind your own interface. Take the conventional default, state it in one line, and move on.
- **Length is not rigor.** Cut every sentence that does not change what the implementer does. Do not restate the request, and do not describe code the implementer would write the same way without being told.

## Phase A — Explore the Design Space

Skip this phase only when the pattern is established, the target state is clear (a defect fix or refactor), or constraints dictate one viable approach.

### A1. Build competing prototypes before committing

When a novel interaction or architectural decision has no established precedent, build two or three concrete alternatives and compare them side by side. Building the wrong thing costs more than exploring three options. A second flavor of the first shape does not count as an alternative.

Keep each prototype to the least code that answers its question, and build independent prototypes at the same time. A prototype is evidence, not a first draft. Rebuild the winner under `implement`, keeping only what already meets its rules.

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

- Read project instructions and only task-relevant project memory. Do not import another project's memory or brain unless the user explicitly authorizes a scoped transfer.
- Inspect the actual repository: files, contracts, tests, schemas, runtime boundaries, open PRs, deploy notes, current branch state. Use `investigate` when the subsystem is unfamiliar.
- Check every outside fact the plan relies on against a current primary source. For a library, framework, API, or platform, find the version the project pins in its manifest or lockfile, then read that version's documentation or changelog. An API you remember is often a version out of date.
- Run independent research at the same time. Batch unrelated reads and searches, and give separate subsystems to subagents or background tasks where the session allows them.
- Treat decisions the user already made as fixed inputs. Reopen one only when new evidence contradicts it, and say what changed.
- Separate discoverable facts from product preferences. Ask the user only for high-impact choices that cannot be derived. Ask them all at once and early, each with your recommended default and what it changes. Keep working on whatever the answers do not block.

### B2. Draft the plan

State goal, success criteria, boundaries, interfaces, data flow, edge cases, tests, rollout, and verification. It must be **decision-complete**: the implementer never chooses files, contracts, sequencing, or acceptance criteria.

- [ ] Every file to create or modify is named with a path.
- [ ] Every interface, type, or contract change is written out, not described.
- [ ] Every success criterion is observable. It names a command, test, screen, or measurement and the result that passes, with numbers and units where they apply.
- [ ] Every dependency the plan adds or relies on is named with its version and checked per B1.
- [ ] Tests are listed by name and behavior, riskiest paths first.
- [ ] Sequencing and gates between steps are explicit, and each unit ends in a check. See `test-design`. Units that can run in parallel are marked, with the shared seam that lands first (`implement` 1.8).
- [ ] Verification commands are runnable as written.
- [ ] Rollout and rollback are stated when production behavior changes.
- [ ] The demo path and the long-term notes below are written, or marked not applicable with the reason.

#### Demo path

When the work produces something a person uses, such as a screen, an app, an endpoint, a command-line tool, or a report, plan the demo first and build toward it.

- Write the path: the steps a person takes, what they see at each step, the data it runs on, and the one command or link that starts it. This is the story `verify` Part 3 checks.
- Make the first milestone the thinnest version of that path, working end to end through the real layers. Each later milestone widens it and leaves it working.
- Plan demo data as seed data that loads through the same path real data takes.
- When a part cannot be real yet, such as an outside service with no test environment, name the fake, keep it behind the real interface, and say what replaces it.

#### Long-term notes

- **One-way decisions.** List each with the choice, the strongest alternative, and why the choice wins.
- **Likely extensions.** Name the changes the user has mentioned or the domain makes likely. For each, say where it would go, and check that the plan keeps it cheap. Stored data and contracts should grow by adding fields, and a new variant should be caught at every site that must handle it, by the compiler or a test. Do not build the extensions now.
- **Dependencies.** Prefer what the project already uses. A new dependency is the current stable release, actively maintained, and not deprecated.
- **Shortcuts.** List each shortcut taken for the demo or a deadline, with what replaces it and when. An unlisted shortcut becomes the design.

### B3. Adversarial review

- Spawn a dedicated adversarial reviewer on a different model when a subagent path is available and allowed. A research subagent does not count unless it explicitly attacks the plan.
- **Hand it:** the full plan, the goal, the four outcomes in Purpose, verified repository facts with file paths, and the constraints. **Require back:** findings with severity, each backed by a file path, contract, or runtime fact, not vibes.
- Fall back to local self-critique only when no subagent path exists or session rules prohibit one, and state that fallback in the final plan notes.
- The reviewer is hostile to: unverified runtime assumptions, vague seams (any component named without its exact contract), missing tests on risky paths, hidden state transitions, deploy and rollback gaps, stale branch context, and scope creep.
- It also attacks every miss on a Purpose outcome:
  - An unchecked version, or a success criterion nobody can measure.
  - A user-facing result with no demo path, or a demo that runs on fakes the plan does not list.
  - A one-way decision with no alternative weighed, a plan that blocks a named extension, or a shortcut the plan does not list.
  - Text that changes nothing the implementer does.
- Delegate only in trusted repositories. Preserve the full original contract on every retry; never chain only the preceding reviewer's text.
- The parent agent owns test, build, and runtime gates and must verify reviewer claims directly.

**Severity rubric:**
- **P0** — plan produces wrong behavior, data loss, broken deploy, or violates a repository contract. Blocks output.
- **P1** — plan forces the implementer to make a significant undocumented decision or rework, or misses a Purpose outcome the user would notice in the result. Blocks output.
- **P2** — polish, optional hardening, future work. Record as deferred; does not block.

### B4. Iterate to convergence

Revise for every P0 and P1, then re-review the revised plan. **Cap: 3 review rounds.** If P0 or P1 findings persist after round 3, stop looping and surface the unresolved questions to the user as explicit decision points instead of grinding. Preserve deferred P2 items explicitly; never silently drop them.

### B5. Output the final plan

One complete replacement plan, not a diff against drafts.

Title / Summary / Key Changes / Demo Path / Test Plan / Long-term Notes / Assumptions and Rollout Notes / Review Notes (what the critique changed, deferred P2s, fallback used if any). Drop Demo Path when the work has no user-facing result. Add other sections only when they prevent implementation mistakes. Write it through `writing-discipline`.

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
| "The demo can wait until it is all built" | Then nothing runs until the end, and integration fails last. Plan the thin path first. |
| "I know how this library works" | You know some version of it. Check the pinned version's documentation. |
| "Every decision deserves the full process" | Only the costly-to-undo ones. Default the rest in one line. |
| "More detail makes the plan safer" | Detail that changes nothing for the implementer is reading time. Cut it. |
