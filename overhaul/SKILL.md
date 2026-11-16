---
name: overhaul
description: "Use when the task is to raise the quality of a whole codebase or a large part of it, rather than one change: a code-quality, architecture, or modularity overhaul, paying down duplicated, dead, or AI-generated code, untangling modules, or adding quality gates so the gains hold. Measures before editing, ranks hotspots, locks behavior, refactors in ordered waves, and ratchets the gates. Not for the cleanup pass on a single diff; that is `implement`."
---

# Overhaul

## Purpose

A repo-wide quality pass fails in two ways. It rewrites by taste and breaks behavior nobody wrote down, or it cleans once and decays within a month. This skill prevents both. Measure, rank, define the target, lock behavior, refactor in waves, then ratchet the gates.

It adds only what the other skills lack. `implement` governs the shape of every edit. `plan` designs the target and hardens the wave plan. `test-design` decides whether the safety net can fail. `verify` decides what you may claim.

## Boundaries

- Behavior stays the same. A behavior change found along the way is a separate change the user approves, never part of a refactor commit.
- When the user says today's behavior is not the specification, the behavior to keep is the required behavior, per `test-design` section 8. Each place the code disagrees is a discrepancy, fixed as its own approved change.
- Scope is what the user named: the repository, a directory, or a list of modules. Feature work stays out.
- This covers local edits. Commits, pushes, pull requests, and changes to shared CI follow the user's standing rule for outward actions.
- Use the project's own tools and conventions first. Add a tool only when nothing in the project measures the symptom.

## 1. Measure before you edit

Run one deterministic analyzer per symptom. Save the counts per module to a baseline file in the repository. The baseline is the ledger the overhaul is judged against. Without it, "cleaner" is an opinion.

| Symptom | What to count |
| --- | --- |
| Dead code | Unused files, exports, types, helpers, components, and dependencies |
| Dead surface | Endpoints, pages, database tables and columns, flags, environment variables, and jobs that nothing reaches |
| Duplication | Cloned blocks, the duplicated-line percentage, and columns, indexes, endpoints, or types that repeat another's job |
| Size and complexity | Files and functions over the size limit, and cyclomatic or cognitive complexity |
| Boundaries | Dependency cycles, and imports that bypass a module's public entry |
| Type escapes | Casts, `any`-style types, and suppressed checker errors |
| Error handling | Empty or swallowing catch blocks, and silent fallbacks |
| Churn | Commits per file over the last year |

`toolkit.md` lists analyzers per ecosystem. Before adding one, check whether the project already runs it with a narrowed config. A dead-code tool limited to files and dependencies misses every unused export.

An AI-slop scorer is an optional second opinion. Read its score as a trend on this repository only, because different scorers measure different things. Do not try to detect which code an AI wrote. Detectors fail outside their training data, and the problems are the same whoever wrote the code. Gate on quality, not on origin.

## 2. Rank by hotspot, not by taste

Work where change frequency and complexity are both high. Multiply churn by complexity per file and sort. Code nobody changes can stay ugly. Restructuring it adds risk and saves no maintenance.

Rank structural problems above cosmetic ones. Duplicated decisions, dead code, boundary violations, and oversized files in hot paths cost real maintenance time. Narrating comments and redundant try/catch blocks are cheap to remove and rarely matter. One prompt-only cleanup tool, measured on real pull requests, found that 0.5% of its findings were real and missed every defect the reviewers caught.

The output is a ranked hotspot list with each file's baseline numbers.

## 3. Define the target, then encode it

Design the module map with `plan`. Each module owns one body of domain knowledge (`implement` 2.1), is named for what it owns (`implement` 1.10), exposes one public entry, and depends on other modules only in an allowed direction. Write the map to a short file that every wave refers to.

Before you move any code, encode the map as a dependency rule that lint or the build runs (`plan` A4). Start the rule in baseline mode, so existing violations are recorded and only new ones fail. The violation count then measures progress for the boundary wave.

## 4. Lock behavior before you move it

Apply `test-design` section 7 to every hotspot before its wave starts. Write the tests for a whole wave up front, so the wave's refactor commits all land on a locked base. When the user says today's behavior is not the specification, write them from the requirements instead, per `test-design` section 8.

## 5. Refactor in waves, in this order

Each wave makes the next one cheaper. Finish one wave before starting the next.

**When the overhaul covers an API and its database, settle the API first.** Run every wave on the API and freeze its contract. Then derive the minimal schema from what the frozen API, pages, jobs, and scripts read and write and what the business rules require, and run the database's waves once. A schema reshaped while its API still moves gets reshaped twice, and database changes are the costliest to redo. This is the one exception to running each wave in every layer.

1. **Subtract.** Delete dead code and dead surface in every layer, with the proof each layer needs (see the table below). This wave carries the least risk and shrinks every wave after it.
2. **Deduplicate.** Merge copies of the same decision into one source of truth, in every layer (see the redundancy table below). Leave similar code that encodes different decisions alone. Three similar lines beat a wrong abstraction (`implement` 1.4).
3. **Fix boundaries.** Break cycles, move code to the module that owns its knowledge, migrate callers, and delete the old path in the same wave (`implement` 1.6).
4. **Split hotspots.** Break oversized files and functions apart by responsibility. Pull pure logic out of framework shells (`implement` 1.9 and 2.9).
5. **Tighten types and errors.** Replace casts with parsing at the boundary, and remove swallowed errors (`implement` 2.5 and 4.3).
6. **Clear residue.** Fix comments, nesting, and naming (`implement` 1.10 and Part 4), only in files the earlier waves touched. Rename with the language's rename tool so every caller updates.

Analyzers see only imports. Anything reached by a URL, a query, a string, or another system needs evidence from outside the code before it counts as dead.

| Layer | Dead when | Delete how |
| --- | --- | --- |
| Helpers, types, components, files | The analyzer finds no import, and no dynamic import, registry, or string lookup reaches it | Delete it with its tests |
| Pages and routes | No link or redirect reaches it, and traffic logs show no visits over a window that covers the slowest cycle, such as a monthly job | Delete it with its tests and navigation entries |
| API endpoints | No caller in any repository you control, no requests in the logs over that window, and no external consumer | Remove the handler and its API contract entry in the same change. With an external consumer, deprecate first and tell its owner. |
| Database tables and columns | No reference in code, raw SQL, views, reports, or other services, and no reads in the database's statistics where it keeps them | Stop writing to it and deploy. Drop it in a later migration, after a backup. Migrations need the user's approval, and so does dropping data someone may still need. |
| Flags, environment variables, config, jobs | The flag has one value everywhere, or nothing reads the variable or runs the job | Remove the flag and the branch it no longer selects. Removing values from a deployed environment needs the user's approval. |

Redundancy is the same fact or job held in two places that must stay in sync. Each layer merges it differently.

| Layer | Redundant when | Merge how |
| --- | --- | --- |
| Code | Two helpers, types, or components encode the same decision | Keep one, migrate callers, delete the other (`implement` 1.6) |
| Types | A hand-written type repeats a shape that a schema or API contract defines | Derive it from the schema (`implement` 2.7) |
| Validation | The same check runs in several layers | Keep it at the boundary and delete the rest (`implement` 2.9) |
| API endpoints | Two endpoints read or change the same resource for the same caller | Keep the one that matches the API's established shape, migrate callers, and remove the other with its contract entry. With an external consumer, deprecate first. |
| Database columns and tables | Two columns or tables store the same fact, or a column can be computed from others | Keep one source of truth and derive the rest with a view, a generated column, or a query. Backfill, switch reads, stop writes, then drop, under the same migration rules as dead surface. Keep a copy only for a measured performance need, and name what keeps it in sync. |
| Indexes | An index repeats another, or its columns are a leading prefix of another's | Drop it, unless it backs a unique or primary-key constraint |

Within a wave:

- Check each unit before starting the next (`test-design` section 5).
- Use a lever for mechanical moves: the language's refactoring engine, a language-server rename or move, or an AST codemod (`plan` A3). Keep hand edits and model edits for the parts that need judgment.
- Once the shared seam lands, run units in parallel, split by file ownership (`implement` 1.8).
- Land one wave per branch or pull request, so a reviewer reads one kind of change at a time.
- Re-measure after the wave and lower the baseline. A wave that did not move its numbers did not happen.

## 6. Ratchet so the gains hold

- Every analyzer from step 1 runs in CI and fails only on findings a change adds over the baseline. Use the tool's own baseline or new-code mode where it has one. Otherwise compare counts against the baseline file.
- The baseline only goes down. Lower it after each wave. Raising it needs the user's approval and a recorded reason.
- Never loosen a threshold or suppress a finding to make a check pass. Fix the code, or record the exception and its reason beside the code.
- Put a rule in the project's agent instructions only when no tool can check it, and give an example of the failure it prevents.

## 7. Report

Give before and after counts per symptom from the baseline file, the waves finished, the gates added, any behavior changes found and whether they were approved, and the hotspots still open.

## Red flags: stop, you are rationalizing

| Excuse | Reality |
| --- | --- |
| "The code is obviously bad, no need to measure" | Without a baseline you cannot show it improved or notice it got worse. |
| "Start with the worst-looking file" | Start with the hottest file. Ugly code nobody changes costs nothing. |
| "Strip the AI comments and try/catch first" | That wave yields the least. Do it last, in files you already touched. |
| "Do all the waves in one branch" | A reviewer cannot judge six kinds of change at once. One wave per branch. |
| "Keep the old module for compatibility" | Name the external consumer or delete it. |
| "Push the slop score to 100" | A score is a trend, not a target. Work the hotspot list. |
| "Raise the baseline, the new code needs it" | The baseline only goes down unless the user approves. |
| "Reshape the tables while the API is still moving" | Freeze the contract first, then derive the schema once. |
| "Add a rule to the agent instructions" | If a tool can check it, make it a check. |
