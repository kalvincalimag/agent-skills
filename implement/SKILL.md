---
name: implement
description: "Use whenever writing or refactoring implementation code: sizing a diff, deciding whether an abstraction earns its place, designing a type or function signature, placing validation and error handling, keeping an API contract in sync, and the cleanup pass before the diff is handed over. Governs what the code should look like, not whether it works."
---

# Implement

## Purpose

What the work should look like when it lands: its structure, its types and boundaries, its contracts, and the residue removed before anyone else reads it. Apply it while writing, not as a review pass afterward, because every rule here is cheap at write time and reads as a refactor later.

`plan` decides what to build. This decides what it looks like. `verify` decides whether you may call it done.

## Boundaries

- This shapes code. It does not authorize commits, pushes, or scope expansion.
- Do not refactor code the task did not ask you to touch. Name what you noticed and leave it.
- Prefer boring code when the current shape is already clear, local, and unlikely to grow.

---

# Part 1 — Structure

## 1.1 Subtract before you add

Adding to a complex system compounds complexity. Removing first leaves less code, reveals the real structure, and usually makes the next design obvious.

- Sequence removal before construction. Cut to the minimum before investing in quality.
- Design for observed usage. No speculative validators, parsers, guards, or edge cases beyond what the spec demands.
- When a reference has no novel content, delete it rather than leaving a stub.
- Leave the design slightly simpler behind the same or smaller surface than you found it.

## 1.2 Make the smallest change that solves the problem

- Prefer deletion. When asked to refactor or improve, look for removals before additions.
- Fewer lines beat elegant boilerplate.
- Consolidate decisions. Do not repeat the same choice in several places. Put it behind one source of truth and pass the result as a simple flag.
- Question the threading. If a task asks you to pass a new signal through types, schemas, and pipelines, stop and look for a more direct path.
- Remove tiny pass-throughs, representation leaks, and duplicated choices before they spread.

**The test:** if a human developer would find the code exhausting to maintain, it is a bad solution.

## 1.3 Minimize reader load

Maintainability is the work a reader must do. Track two independent axes: how many layers sit between the question and the answer, and how much hidden or mutable state the reader must hold.

- Collapse layers that cost more than they save: wrappers with one caller, adapters with no second implementation, indirection that was never needed.
- A layer that repeats the same methods and arguments adds reader load without compression. Collapse it.
- Prefer boundaries that hide meaningful decisions over broad interfaces that hide little.
- Shrink state scope: pure functions over mutations, locals over fields, fields over module state, module state over globals. Derive instead of sync.
- Name the invariant at the boundary, not in every consumer, so the reader learns it once.
- Before adding a layer or a piece of state, ask whether it reduces reader load somewhere else by at least as much.

**The test:** can a new reader answer "where does X come from?" and "what can change X?" in under thirty seconds?

## 1.4 Get the data shape right first

Define core types before writing logic. Trace every access pattern and choose structures matching the dominant paths.

- DRY the structure, not every line. Three similar statements beat a premature abstraction.
- If something helps every later phase, do it first. CI, linting, test infrastructure, and shared types are scaffold. Subtraction comes before scaffolding.
- Each increment should land a coherent abstraction or deepen an existing one. Do not spread a new capability across callers as special-case coordination.

## 1.5 Redesign rather than bolt on

When integrating a new requirement, do not attach it to the existing design. Read the affected files, ask what you would build if this requirement had been there from the start, then propagate the change through every reference including types, docs, and examples. Think about the whole redesign and deliver it incrementally.

## 1.6 Migrate callers, then delete

When a new internal API is the right design, migrate callers and remove the old one in the same wave. Keeping both creates dual-path complexity and makes the codebase feel append-only.

- Do not keep a legacy path only because internal callers still exist.
- Treat temporary adapters as exceptional and time-boxed.
- Update tests to assert the new contract. Delete tests that only protect pre-refactor implementation details.
- This applies when no external consumer depends on the old shape. When one does, document the rollout boundary instead, and prove the census of consumers through `verify`.

## 1.7 Converge on the end state

During a planned migration with explicit phases, optimize for the intended end state rather than keeping every intermediate step smooth. Temporary compatibility code becomes long-lived debt.

Intermediate breakage is acceptable when it is planned, scoped, and reversible. Declare where it is acceptable, keep high-signal checks on actively touched areas, and require full verification at plan completion.

---

# Part 2 — Types and Boundaries

The type checker is a proof assistant. A case the types let you ignore becomes a runtime failure the compiler could have stopped. Applies to any statically typed language; a language-specific skill, if one is installed, grounds it in syntax.

## 2.1 Make illegal states unrepresentable

Model variants as sum types: discriminated unions, enums with payloads, sealed classes, algebraic data types. Do not model state as a bag of optional fields where contradictory combinations compile.

`{ completed: boolean; completedAt?: Date }` admits `completed: true` with no date, which is meaningless. Derive the boolean from `completedAt !== null`, or model the variants as `{ kind: 'open' } | { kind: 'done'; at: Date }`.

The same rule at the module level: reach for a state machine instead of scattered lifecycle booleans, a typed model instead of loose parameters, a map or registry or discriminated union instead of branching spread across files, a reducer or event model instead of ad hoc mutation, or a module organized around one body of domain knowledge rather than a sequence of phases. Execution order is not ownership.

Do not force an abstraction. Be skeptical of one that adds indirection without removing branches, duplicated rules, invalid states, or lifecycle risk.

**The test:** if you can write a comment explaining when a combination of fields is valid, the type is too loose. Split it. **The sign you skipped this:** a new feature grows an existing if/else chain by one more branch, or a second boolean must stay in sync with the first.

## 2.2 Construct types, do not carve them

Build the type up from the values you want rather than carving them out of a looser type with checks. A non-empty list is a head plus a rest, not a list with a length check. A valid time range is a start plus a duration, not two timestamps you must keep ordered. Choose the shape that cannot build the illegal value, then expose the interface callers need on top.

## 2.3 Brand semantic primitives

`UserId` and `OrderId` are strings underneath and must not be interchangeable. Use newtypes, opaque types, value classes, or branded intersections. Validate once at creation and trust the type downstream.

**The test:** do two function arguments share a primitive type but mean different things? Brand them.

## 2.4 External data is untyped until parsed

RPC payloads, JSON, IPC messages, CLI arguments, config files, environment variables, database rows. Every boundary gets a parse function that turns unstructured input into the typed model.

## 2.5 Do not lie to the compiler

Casts, unsafe coercions, and assertion helpers that bypass the checker are latent crashes. If the compiler cannot prove a fact, prove it by validating or narrowing, or accept explicitly that the cast is a hazard.

**The test:** where did this `any`, this `as`, this `assertNotNull` come from? Trace it to the boundary and validate there instead.

## 2.6 Exhaustive matching is the compiler's job

When you match on a sum type, adding a variant must fail compilation until every site handles it. Use the idiom the language provides.

**The test:** if a new variant is added next month, will the compiler tell the next engineer where to add a case?

## 2.7 Derive from authoritative schemas

When a protocol buffer, OpenAPI spec, GraphQL schema, database migration, or design-token file defines a shape, derive from it instead of hand-rolling a parallel type.

## 2.8 Strengthen types only where partiality appears

A runtime assertion or a "this should never happen" throw marks a place the type is too weak. Push that check into the type, then stop. The job is to track the cases each call site must handle, not to describe the data as precisely as possible. Prefer total functions. Summing an empty list is zero, so it takes the plain list. Taking the head of an empty list has no answer, so it demands the non-empty one.

## 2.9 Concentrate guards at boundaries

Place validation, narrowing, and defensive error handling at system boundaries. Trust internal code unconditionally. Scattered validation is noisy, redundant, and gives false confidence.

- **At boundaries** (CLI arguments, config, external APIs, network protocols): validate, return errors, handle defensively.
- **Inside the system:** typed data, error propagation, no re-validation.
- **Across the boundary:** expose domain concepts, not the boundary's private representation. Do not re-export transport, storage, or framework types through the public surface.

Business logic lives in pure functions with no framework dependency, so it can be tested without the framework. The shell is thin and mechanical.

**The test:** is this data crossing a system boundary right now? If not, the validation is redundant. Can this be a pure function the shell just calls? Then extract it.

## 2.10 Make operations idempotent

Every state-mutating operation answers two questions: what happens if this runs twice, and what happens if the previous run crashed halfway.

- Convergent startup: scan for existing state, clean stale artifacts, adopt live sessions.
- Compare by content equivalence, not creation order.
- Detect stale locks rather than trusting them.
- Failed work respawns cleanly.

If the answer to either question is "it depends what state was left behind," the operation needs a reconciliation step.

## 2.11 Separate shared state before serializing it

When concurrent actors might write the same file, branch, key, or object, first ask whether they need the same mutable object at all.

1. Identify shared mutable state.
2. Default to eliminating the shared write target. Two workers writing their own field into one `state.json` is still shared mutation. Two separate state files is not.
3. Only when one shared target is a real invariant, serialize structurally with a lockfile, sequential phases, a single-writer actor, or atomic compare-and-swap.

Treat "we need a lock" as a design smell to check, not the default answer. Instructions and conventions are not concurrency control.

---

# Part 3 — API Contracts

Applies whenever you create, modify, move, or delete an API endpoint, or change its auth, params, request or response bodies, or status codes. Executable behavior and the repository's canonical contract document move in the same change, including changes that leave the route and method unchanged.

1. Locate the endpoint source, the canonical contract document (an OpenAPI file, GraphQL schema, protobuf definition, or the project's equivalent), and the existing contract tests. If the repository has API source but no canonical contract and its instructions name none, ask before creating one. If the user agrees, write it in the project's own format and add a parser-based contract test as part of the change.
2. Before changing behavior, add or update a failing test expressing the intended contract. Cover path, method, security, request, response, status, error, and behavioral limitations — not only route existence.
3. Implement the change and update the matching operation in the same working change. Synchronize: public path and method; authentication and authorization; path, query, header, and cookie parameters; request schema, required fields, formats, constraints, and examples; success and error schemas with exact status codes; idempotency, concurrency, retry, redaction, and environment behavior; limitations such as configuration-only checks or unimplemented external probes.
4. When an endpoint moves or is removed, remove the stale operation. Use `deprecated: true` only when the old endpoint still exists and intentionally remains supported.
5. Review the source and contract diff together. Do not expose internal folder or module names in public paths unless the approved wire contract includes them.

Parse the document with the repository's own parser or validation command, and run the endpoint's focused behavioral tests plus the contract test. A missing, stale, or unparsable contract update is an incomplete API change; do not claim completion.

Never place live tokens, API keys, signing secrets, credentials, private URLs, or sensitive customer payloads in examples, tests, diffs, or verification output. Preserve provider-specific wire contracts at their adapter boundary; document a normalized endpoint only when the implementation actually exposes that contract.

---

# Part 4 — Cleanup Before Handoff

Run this against the diff before commit and before handing the branch to `ship`. Scope is the diff against the base branch including uncommitted work, or the files the caller named — not the surrounding code. Behavior stays unchanged unless you are fixing a clear defect; say so if you are. Prefer minimal focused edits; a cleanup pass that reshapes unrelated code is no longer a cleanup pass.

## 4.1 Delete comments that earn nothing

Keep a comment only for a non-obvious *why* that the code itself cannot show. Delete everything else.

- **Phase narration.** `// Phase 1: add cards`, `// Step 2: validate`. The code is the steps. In a script or test, the assertion or log string documents the step: `assert(ok, "persisted across restart")`.
- **Restatement.** A comment that says in English what the next line says in code.
- **Section banners** and decorative dividers.
- **Changelog comments.** `// updated to handle the new format`. Version control owns that.
- **Apology comments.** A workaround that needs a paragraph of justification is the wrong code. Fix the code; see `bugfix`.

Keep a comment that records a constraint you cannot express in code: a known upstream defect with a link, a non-obvious ordering requirement, a legal or protocol rule.

**Constraint comments** that say do not remove, do not change wording, or talk to someone before changing, get one extra step. Offer the cheapest type, runtime, test, or lint check that would encode the rule, per `plan` A4. If the encoding lands, delete the comment. If it does not, keep the comment and report the constraint as unenforced.

## 4.2 Remove residue the rules above already forbid

Apply 2.9 and 2.5 to the lines this branch introduced:

- Try/catch blocks around code that cannot throw, or that swallow an error nobody handles.
- Nil and undefined checks deep in call chains the boundary already validated.
- Fallback values that silently paper over a case that should be impossible. If it is possible, model it. If it is not, let it fail loud.
- Every `any`, every `as`, every assertion helper that tells the compiler to stop asking. Trace each to its boundary and validate there. If one must remain, say so in the report and why.

## 4.3 Flatten what early returns would flatten

Deep nesting that guard clauses would collapse. Count the layers between the question and the answer, per 1.3.

## 4.4 Match the surrounding file

The strongest signal is the code already there. Comment density, naming, error idiom, import style. A diff that reads as written by a different author is residue even when every line is defensible on its own.

## 4.5 Report

Deletion count, casts removed and any that remain with the reason, constraints you offered to encode and what happened to each, and anything left alone because it sat outside the diff. One to three sentences unless something needs authorization.

---

## Red Flags — STOP, you are rationalizing

| Excuse | Reality |
|--------|---------|
| "I will clean it up in a follow-up" | The follow-up is not scheduled. Shape it now, while it is cheap. |
| "It is more flexible this way" | Flexibility nobody asked for is reader load you chose to add. |
| "One more branch will not hurt" | That is the signal you skipped 2.1. Model it. |
| "The abstraction is cleaner" | Does it remove branches, duplicated rules, or invalid states? If not, it is indirection. |
| "I need to thread this through five layers" | Look for the direct path first. |
| "I will keep the old API for safety" | Name the external consumer or delete it. |
| "I will just cast it here" | You moved a compile error to runtime. Validate at the boundary. |
| "The optional fields are fine, we know the rules" | If the rules need a comment, the type is too loose. |
| "I will add a nil check to be safe" | Inside the system that is noise. At the boundary it is the job. |
| "It is only ever called once" | Until a retry, a crash, or a restart. Answer the two questions. |
| "We will add a lock" | First check whether they need the same object at all. |
| "It is a string, same thing" | Two strings meaning different things is the defect branding prevents. |
| "The route did not change, so the spec is fine" | Auth, params, and status codes are the contract too. |
| "The comment explains the tricky part" | Then the code is tricky. Fix the code or record the constraint. |
| "I will clean up the whole file while I am here" | Out of scope. Name it and leave it. |
