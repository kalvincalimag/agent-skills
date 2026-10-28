# Adversarial design review

Run this after the beginner test and normal product review, before presenting the direction for approval or calling the product polished.

The goal is to find evidence that the design is confusing, fragile, generic, incomplete, or inconsistent with the product requirements. Do not try to confirm the designer's conclusion.

## When to run it again

Run a new review after every change that reaches the artifact, not only after the first direction. A refinement round, a new or edited screen, a new state, and a new mode such as dark mode each need their own review of what changed. Give the new reviewer the changed screens together with the screens around them, so they can test the journey and not just the parts in isolation.

## Keep the reviewer independent

Use a fresh reviewer who did not create the design. Give them:

- the approved product requirements;
- the target user and main task;
- the editable artifact or working product;
- the supported platforms and important limits;
- the user's recorded taste and rejected examples, from the project's notes. These are part of the brief, not the designer's rationale.

Export the screens with annotations hidden as image files and give the reviewer their paths, so they review exactly what a user sees. Give a short summary of the requirements instead of the full documents when the documents are long. Ask for their first-look answers word for word, before they see the other screens, and ask for the report format in "Report evidence" below.

Do not give them the designer's rationale, preferred direction, annotations, previous scores, expected findings, or proposed fixes. If no independent reviewer is available, mark the adversarial review as unverified.

## Try to break the direction

Review the direction on its own. Actively look for counterexamples to its claims.

### Understanding

- Find every term, icon, control, or visual metaphor that assumes prior knowledge.
- Look for another reasonable but wrong interpretation of the first screen and main action.
- Check whether decoration, identity, or motion competes with the task.
- Remove the product name mentally and ask whether the category and purpose remain clear.

### Main task

- Try the most likely wrong action first.
- Try to complete the task without gestures, hints, or designer notes.
- Interrupt the journey, go back, change a choice, and repeat the task.
- Check whether progress, saved state, and consequences remain clear.

### Data and edge conditions

- Use missing, unknown, zero, conflicting, stale, long, and unusually large values.
- Test empty, partial, loading, offline, denied, failed, and retry states where relevant.
- Test larger text, narrow screens, localization pressure, and the weakest supported device.
- Check that realistic data does not cause clipping, overflow, hidden controls, or misleading summaries.

### Recovery and trust

- Trigger a realistic mistake and look for unclear or irreversible outcomes.
- Check undo, cancel, retry, confirmation, and return paths.
- Look for hidden costs, destructive effects, permissions, or data changes.
- Confirm that the interface never presents unknown information as zero or certain.

### Identity

- Check whether the design could be mistaken for an unrelated product or generic component kit.
- Remove the headline and annotations; check whether the chosen metaphor still appears in layout, components, objects or illustration, and motion.
- Test whether the logo, color, type, imagery, icons, and voice form one recognizable system.
- Check that the canvas remains neutral, color is borrowed from meaningful content or one warm accent, and multiple accents do not compete.
- Check that each screen or section has at most one crafted surprise and enough quiet space around it.
- Check whether a mascot or character has a useful recurring role.
- Remove decorative brand elements and identify what product-specific character remains.
- Check every screen against the user's recorded taste, and look for any failing quality of their rejected examples.
- Check every screen against the Guardrails in the main skill: added scope, mixed imagery, competing numbers, unreal content or typos, and copied reference material.

### Interaction and accessibility

- Check touch, mouse, keyboard, focus, screen-reader meaning, reduced motion, zoom, and non-color cues where relevant.
- Look for controls that appear interactive but are not, or work only through a hidden gesture.
- Check whether motion delays the task, loses context, or hides the final state.
- Run the important interaction repeatedly and look for fatigue or annoyance.

### Artifact integrity

- Check prototype links, component use, editability, text styles, variables, and state coverage.
- Inspect the real artifact for clipping, overlap, broken navigation, placeholder content, and staged behavior that does not work.
- Compare the artifact with the approved requirements. Record missing or contradicted decisions.

## Report evidence

Record each finding with:

- severity: blocker, major, or minor;
- the screen, state, or action affected;
- the exact evidence or reproduction steps;
- the likely user impact;
- the smallest useful fix.

Do not report vague preferences as defects. Separate observed failures from hypotheses that need a real user test.

Any blocker in product understanding, main-task completion, recovery, accessibility, or requirement fidelity prevents approval. Fix supported blockers and major findings, then repeat the affected tests with fresh context. Report unresolved risks instead of lowering the standard or explaining them away.
