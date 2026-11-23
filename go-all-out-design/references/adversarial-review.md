# Adversarial design review

Run this after the beginner check and the polish rubric, before presenting a direction for approval or calling a product polished. It also runs on its own to review a product that is already built. See "Review an existing product" below.

The goal is to find evidence that the design is confusing, fragile, generic, incomplete, or inconsistent with the product requirements. Do not try to confirm the designer's conclusion.

## When to review again

A review covers only the screens and modes it saw. Any change that reaches the artifact makes it stale for what changed: a refinement round, a new or edited screen, a new state, or a new mode such as dark mode.

- Before reporting a change as done, run a fresh review of every new or changed screen. Give the reviewer those screens together with the screens around them, so they test the journey and not isolated parts.
- Screenshot every defined mode on the real screens.
- Never reuse an earlier reviewer, because they have already seen the design.
- If a required review did not run, do not call the work done or approval-ready. Name each unreviewed screen and mode, and run the review before asking for approval.

## Keep the reviewer independent

Use a fresh reviewer who did not create the design. Give them:

- the approved product requirements, as a short summary when the documents are long
- the target user and main task
- the supported platforms and important limits
- the user's recorded taste and rejected examples from the project's notes, which are part of the brief
- the screens exported as image files with annotations hidden, so they review exactly what a user sees, plus the editable artifact or working product

Ask for their first-look answers word for word, before they see the other screens, and ask for the report format in "Report evidence" below.

Withhold the designer's rationale, preferred direction, annotations, previous scores, expected findings, and proposed fixes. If no independent reviewer is available, mark the adversarial review as unverified. Independent checks, such as one reviewer per flow, can run in parallel.

## Try to break the direction

Look for counterexamples to every claim the design makes.

### Understanding

- Find every term, icon, control, or visual metaphor that assumes prior knowledge.
- Look for another reasonable but wrong reading of the first screen and the main action.
- Check whether decoration, identity, or motion competes with the task.
- Remove the product name mentally and ask whether the category and purpose stay clear.

### Main task

- Try the most likely wrong action first.
- Complete the task without gestures, hints, or designer notes.
- Interrupt the journey, go back, change a choice, and repeat the task.
- Check whether progress, saved state, and consequences stay clear.

### Data and edge conditions

- Run the worst-case content check from the main skill on every screen.
- Add missing, unknown, zero, conflicting, and stale values, and the weakest supported device.
- Check that no summary misleads, and that the interface never presents unknown information as zero or certain.

### Recovery and trust

- Trigger a realistic mistake and look for unclear or irreversible outcomes.
- Check undo, cancel, retry, confirmation, and return paths.
- Look for hidden costs, destructive effects, permissions, or data changes.

### Identity

- Run the identity check and approval check in [art-direction.md](art-direction.md) on each screen.
- Check whether the design could be mistaken for an unrelated product or a generic component kit. Remove decorative brand elements and name the product-specific character that remains.
- Run a replica check against every named reference, side by side. Look for the same palette combination (canvas, contrast tile, and accent all matching), the same composition on an equivalent screen, and the same signature components or copy patterns. Someone who knows the reference must not mistake the product for it, or for its sibling.
- Check every screen against the user's recorded taste, and look for any failing quality of their rejected examples.
- Check every screen against the Guardrails in the main skill: added scope, mixed imagery, competing numbers, unreal content or typos, and copied reference material.

### Clean

- Measure the busiest everyday screens against the targets in [clean.md](clean.md), and list what makes each miss.
- Look for camouflaged actions, cropped pictures, outlines and nested cards that could become fills and spacing, and more than one saturated block per screen.
- Check that the clean pass left one signature identity element on every screen.

### Fun

- Run the fun audit in [fun.md](fun.md). Look for any input, decision, empty state, wait, finish or mistake that feels like a chore.
- Look for playful elements that slow a frequent action, hide meaning, distort a number, or add pressure such as streaks or guilt.

### Interaction, motion, and accessibility

- Check touch, pointer, keyboard, focus, screen-reader meaning, reduced motion, zoom, and non-color cues where relevant.
- Look for controls that appear interactive but are not, or work only through a hidden gesture.
- Put every animation through the gate in [aliveness.md](aliveness.md). Flag motion on high-frequency actions, motion without a named purpose, missing press feedback, entrances from nothing, ease-in curves, and interface animation over 300 ms.
- Check whether motion delays the task, loses context, or hides the final state.
- Run the important interaction repeatedly and look for fatigue or annoyance.

### Artifact integrity

- Check prototype links, transition curves, component use, editability, text styles, variables, and state coverage.
- Inspect the real artifact for clipping, overlap, broken navigation, placeholder content, and staged behavior that does not work.
- Compare the artifact with the approved requirements, and record missing or contradicted decisions.

## Report evidence

Record each finding with:

- severity: blocker, major, or minor
- the screen, state, or action affected
- the exact evidence or reproduction steps
- the likely user impact
- the smallest useful fix

Do not report vague preferences as defects. Separate observed failures from hypotheses that need a real user test.

Any blocker in product understanding, main-task completion, recovery, accessibility, or requirement fidelity prevents approval. Fix supported blockers and major findings, then repeat the affected tests with a fresh reviewer. Report unresolved risks instead of lowering the standard or explaining them away.

## Review an existing product

When the user asks for a review of a product that is already built, these steps replace "Report evidence" above.

- Walk the main journeys in the real implementation, from entry to result, using the checks above. Look hardest for anything that could confuse users, slow them down, or cause mistakes.
- Look in particular for inconsistencies between screens, such as the same action labelled, placed, or confirmed differently. Also look for friction that adds steps or waiting, unclear or missing feedback after an action, and missing states.
- Ground every finding in the current implementation. Name the screen or flow, and give what the user sees or the steps that reproduce it. Leave out speculative problems.
- Rank usability gains above cosmetic polish. Skip the Identity and Fun checks unless the user asks for them.
- Recommend the simplest effective improvement for each finding, not a broad redesign.
- Shortlist no more than seven findings, ranked by impact. Keep the rest available on request.

Report each shortlisted finding as:

- **Issue.** What happens and where.
- **Impact.** Who it affects and why it matters.
- **Recommendation.** The simplest effective improvement.
- **Effort.** Low, medium, or high.

Present the shortlist and stop for the user's approval before changing anything. After approval, apply only the approved items, then review again what changed.
