# Product design review

Judge the real artifact at its target size with realistic content and annotations hidden.

## Scoring

- **0, Missing.** Broken, absent, or confusing.
- **1, Weak.** Partly usable but needs coaching, prior knowledge, or substantial revision.
- **2, Strong.** Clear, coherent, and ready for serious review.
- **3, Excellent.** Unusually thoughtful without adding effort or confusion.

A go-all-out result has no applicable category below 2. Understanding, ease of use, interface text, and recovery should reach 3 before extra visual or interactive polish matters.

## Beginner gate

These caps apply whatever the visual quality, animation, or novelty.

- If a fresh reviewer cannot say what the product does and what to do first, Product understanding scores 1 at most.
- If they cannot complete the common task without coaching, Ease of use scores 1 at most.
- If an essential action depends on discovering a gesture, Controls and interaction scores 1 at most.
- If labels assume unexplained product or technical knowledge, Interface text scores 1 at most.
- If they cannot explain what changed or recover from a mistake, Feedback and recovery scores 1 at most.
- If there was no fresh review, mark beginner usability as unverified instead of passing it.

## Categories

Score them in this order and fix failures before moving on.

### 1. Product understanding

- The first screen makes the product's purpose and benefit clear.
- The next action is obvious without instructions.
- The product assumes no prior industry or technical knowledge.

### 2. Ease of use

- The common path has no avoidable step, field, decision, or wait.
- The user sees one dominant action at a time.
- Defaults reduce work and stay easy to review or change.
- Progress and context survive interruptions.

### 3. Interface text

- Labels use short, everyday words, and buttons say what will happen.
- New ideas are explained when they first appear.
- Instructions, validation, errors, and empty states help the user act.

### 4. Feedback and recovery

- Every action gets immediate, understandable feedback, as the response loop in [aliveness.md](aliveness.md) describes.
- The user can tell what changed and whether it was saved.
- Mistakes can be corrected, undone, retried, or cancelled, and errors name the next useful action.

### 5. Information and navigation

- Each screen has one clear purpose, and importance is clear through order, spacing, size, and contrast.
- The user knows where they are and how to continue or go back.
- Secondary controls do not compete with the main task.

### 6. Identity and recognition

- The screens pass the identity check and approval check in [art-direction.md](art-direction.md).
- Logo, color, type, shape, icons, imagery, and voice feel related, and the product does not look like an unchanged component kit.
- The name and logo stay understated while the product work carries the identity.
- Placeholder identity work is marked, and a mascot, when used, has a useful recurring role.

### 7. Controls and interaction

- Controls look actionable and behave familiarly.
- Essential actions have a visible tap, click, or keyboard path.
- Focus, pressed, selected, disabled, and keyboard behavior are covered where relevant, and hover on pointer devices.

### 8. Motion and polish

- The interface is clean, consistent, and suits the audience.
- Every animation passes the gate in [aliveness.md](aliveness.md) and uses its timing and easing.
- Reduced-motion behavior is complete.
- Spacing is measured, not eyeballed: no element sits outside its parent's padding, matching sides have matching padding, and no line ends with a single orphan word.

### 9. States and worst-case content

- The main journey is designed from entry through success and return use.
- The states and the worst-case content check in the main skill pass on every screen.

### 10. Accessibility and context

- Contrast, text size, target size, focus order, and keyboard access meet the platform standard.
- Meaning does not depend on color, sound, motion, or gesture alone.
- The design supports the expected input methods and one-handed use when relevant.

### 11. Trust and control

- Cost, privacy, permissions, destructive effects, and data use are explained before commitment.
- The user can review, correct, cancel, undo, export, or recover where appropriate.
- The design uses no hidden choices or false urgency.

### 12. Implementation and performance

- The working result matches the approved design and content, with realistic data rather than a staged example.
- Layout stays stable and feedback is immediate.
- Broken links, errors, clipping, overflow, and avoidable delays are fixed.

### 13. Fun and lightness

- Every screen passes the chore test in [fun.md](fun.md), or its record says why no fun move fits.
- Inputs, decisions, empty states, waits, finishes, repeated chores and mistakes use a fun move that adds value.
- No fun move breaks the guardrails in [fun.md](fun.md): it stays fast, clear, honest, accessible and free of pressure.

### 14. Calm and clean

- Resting screens meet the targets in [clean.md](clean.md), or the record names the reason: strong edges 7% or less, quiet area 60% or more, pictures 4 or fewer, outlines 3 or fewer, text sizes 5 or fewer, one level of cards.
- Each screen has one hero and one signature identity element, not several competing blocks.
- No action is camouflaged against its background, and no picture is cropped by a mask, ring or card edge.

## Interaction gate

For an interactive product, static screens can support review but cannot prove interaction. Each important action must show its response loop, quiet or not. Decorative animation does not count. If the design tool cannot demonstrate an important behavior, build a small working prototype for that part, after the beginner gate passes.

Then run [adversarial-review.md](adversarial-review.md), and report as the main skill describes.
