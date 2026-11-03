---
name: test-design
description: "Use whenever writing, changing, reviewing, or deciding whether to keep a test, when configuring how tests run in CI, when sequencing a multi-step change into units that each end in a check, and before restructuring existing code. Governs whether a test can actually fail for a defect, and how the suite runs fast without losing coverage — not whether the suite currently passes."
---

# Test Design

## Purpose

`bugfix` requires a regression test that fails before the fix. `verify` requires gates that can fail. Both assume the test is real. This skill is how you tell.

A test calls the code the way its users do and asserts the result they observe against a literal expected value. A test that asserts which calls the code made, or restates a constant the code contains, does neither.

## 1. The Keep-or-Delete Check

Before keeping any test, ask whether it would still pass if every function it imports returned nothing (`undefined`, `None`, `nil`, or your language's equivalent). If yes, it observes no behavior and cannot fail for a defect. Rewrite the assertion or delete the test.

A test that cannot fail for a defect costs CI time and review attention and catches nothing. A constant pin is worse than nothing: it also fails when someone edits the constant, so it blocks the edit it was never protecting.

## 2. Five Shapes That Fail the Check

The matcher names below are Jest-style. The same shapes apply in any test framework.

- **Weak or absent assertion.** No assertion at all, or only `toBeDefined`, `toBeTruthy`, `not.toThrow`, `toBeInstanceOf`, `toBeGreaterThan(0)`.
- **Mock or absence only.** Only `toHaveBeenCalled`, `not.toHaveBeenCalled`, `toBeUndefined`, `toEqual([])`, `toHaveLength(0)`, `not.toBe(wrongValue)`.
- **Self-referential.** The expected value comes from the code under test: `expect(f(a)).toBe(f(a))`, or comparing a parsed field against the same builder that produced it.
- **Constant pin.** The assertion restates a hand-maintained constant, config default, table row, or prompt string: `expect(LIMITS.maxTools).toBe(8)`, `expect(PROMPT).toContain("You are")`.
- **Fixture asserts fixture.** The assertion reads data the test built or a value computed in setup, and the subject never runs inside the body.

## 3. The Fix for Each

Call the subject inside the test body with one concrete input and assert the literal output or the observable effect: `expect(slugify("Hello, World!")).toBe("hello-world")`.

- For an absence, assert the presence on the other input in the same test.
- For a constant, test the mechanism that reads it with one input instead of restating the value.
- For a mock, assert the payload it received or the state after the call, not that it was called.
- When no such assertion exists, delete the test.

**Keep** a test that asserts a relation across a table's rows, such as a key present in two tables or a parent that exists, and keep compile-time type tests.

## 4. Do Not Weaken Tests to Make Failures Disappear

Do not rewrite a test's intent to turn it green. If the intended behavior genuinely changed, say so explicitly, explain the contract change, and get authorization before landing it.

Make time, provider, cache, environment, and race conditions deterministic rather than tolerant.

## 5. Sequence Work Into Units That Each End in a Check

Order work as small units, each ending in a state you can verify, and do not advance until the current one is green. A break caught at the unit that caused it is cheap to localize. A break caught after a batch is buried under work built on a broken base.

**While executing.** In a sweep, migration, or any run of similar edits, verify each change before starting the next. Each unit is a bracket: known-good state, one change, run the check, proceed. Rebase onto clean trunk first so every check measures against the real baseline. When a script does the edits, the per-unit check is nearly free. Run it anyway.

**While delivering.** Stack commits in the order that proves the work. The canonical shape is the failing test first, then the fix on top. Other honest orders are a subtraction before a reshape, a baseline capture before a treatment, a scaffold before a feature. Each commit stands on its own and the sequence reads as an argument a reviewer can replay.

## 6. Run the Suite in Parallel on CI

A slow suite gets run less, retried, and trimmed. Make it fast by structure, never by testing less. When you add or change tests that run on CI, configure them to run in parallel unless they cannot.

**Parallel by default.**

- Turn on the runner's own parallelism: worker processes or threads per file, and per test where the runner supports it. Set the worker count from the CI machine's cores and memory, not a guess.
- Independent CI stages (lint, typecheck, unit, build, browser) run as separate jobs side by side, not as sequential steps in one job.
- Shard a suite across jobs when one job's run time is well above its setup time. Balance shards by recorded timings, not file count. Do not shard below that point; every job pays its own setup.

**Make tests safe to run together.** A test that breaks under parallelism shares state it should not.

- Give each test or worker its own data: unique IDs, a per-worker database or schema, ports and temp directories derived from the worker index.
- Remove the shared write target before reaching for serial execution, per `implement` 2.11.

**When a group must run serially,** name the reason in the config (one external sandbox, one shared account, a real rate limit) and move only that group into its own job or project, so the rest stays parallel.

**Optimize what cannot be parallelized.**

- Cache dependencies and build outputs between runs. Build once and hand the artifact to every test job.
- Do expensive setup once per worker or per run (seed, login state, server boot), not once per test.
- Test each behavior at the cheapest tier that can still fail for its defect. Keep browser tests for what only a browser shows.
- Wait on conditions, never fixed sleeps.
- Selecting only affected tests is fine for early feedback when the full suite still gates the merge.

**Never buy speed with coverage.** Do not add retries to hide flakes, skip or delete failing tests, lower coverage thresholds, or loosen assertions to make the suite faster. A flaky test is a determinism defect; fix it per section 4.

Measure before and after from the CI run timings, and report the change in wall time with the evidence `verify` requires.

## 7. Lock Behavior Before You Restructure

A refactor is safe only when some test fails if behavior changes. Before you move, split, or rewrite existing code:

- Check the tests that cover it against section 1. A suite that passes when the subject returns nothing protects nothing.
- Where coverage is missing, write characterization tests first, at the code's public surface. Assert what the code returns today as literals, including outputs that look wrong.
- Record suspected bugs as findings and leave them in place. A behavior change inside a refactor hides in the diff.
- Commit the characterization tests before the refactor, so a reviewer sees them pass on the old code, per section 5.
- If the project runs mutation testing, run it on the code you are about to move, to confirm the tests catch changes.

Code with no such test gets only the changes a tool can prove safe, such as deleting an export that no file imports.

## Red Flags — STOP, you are rationalizing

| Excuse | Reality |
|--------|---------|
| "It asserts the function was called" | That passes when the function does nothing. Assert the payload or the resulting state. |
| "I pinned the config value so it cannot change" | You blocked the edit and caught no defect. Test the mechanism that reads it. |
| "The test is green" | Green proves nothing until you have seen it red for the right reason. |
| "I will verify the whole sweep at the end" | Then the break is buried. Check each unit before the next. |
| "The expected value comes from the helper" | The helper is the code under test. Write the literal. |
| "The assertion was too strict so I loosened it" | Say the contract changed and get authorization, or fix the code. |
| "The tests are flaky in parallel, so run them serially" | They share state. Isolate the data; serialize only the group with a named reason. |
| "Add a retry, it passes the second time" | The retry hides a determinism defect. Fix it. |
| "Skip those tests to speed up CI" | Speed comes from structure, not from testing less. |
| "The tests pass, so the refactor is safe" | Only if they fail when behavior changes. Check them first, per section 7. |
| "I will fix this bug while I refactor" | Record it and leave it. Fix it in its own change. |
