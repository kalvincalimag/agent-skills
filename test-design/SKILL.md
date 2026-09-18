---
name: test-design
description: "Use whenever writing, changing, reviewing, or deciding whether to keep a test, and when sequencing a multi-step change into units that each end in a check. Governs whether a test can actually fail for a defect — not whether the suite currently passes."
---

# Test Design

## Purpose

`bugfix` requires a regression test that fails before the fix. `verify` requires gates that can fail. Both assume the test is real. This skill is how you tell.

A test calls the code the way its users do and asserts the result they observe against a literal expected value. A test that asserts which calls the code made, or restates a constant the code contains, does neither.

## 1. The Keep-or-Delete Check

Before keeping any test, ask whether it would still pass if every function it imports returned `undefined`. If yes, it observes no behavior and cannot fail for a defect. Rewrite the assertion or delete the test.

A test that cannot fail for a defect costs CI time and review attention and catches nothing. A constant pin is worse than nothing: it also fails when someone edits the constant, so it blocks the edit it was never protecting.

## 2. Five Shapes That Fail the Check

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

## Red Flags — STOP, you are rationalizing

| Excuse | Reality |
|--------|---------|
| "It asserts the function was called" | That passes when the function does nothing. Assert the payload or the resulting state. |
| "I pinned the config value so it cannot change" | You blocked the edit and caught no defect. Test the mechanism that reads it. |
| "The test is green" | Green proves nothing until you have seen it red for the right reason. |
| "I will verify the whole sweep at the end" | Then the break is buried. Check each unit before the next. |
| "The expected value comes from the helper" | The helper is the code under test. Write the literal. |
| "The assertion was too strict so I loosened it" | Say the contract changed and get authorization, or fix the code. |
