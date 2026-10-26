# Product design review

Judge the real artifact at its target size with realistic content. Hide designer notes before testing whether the interface explains itself.

## Scoring

- **0, Missing:** Broken, absent, or confusing.
- **1, Weak:** Partly usable but needs coaching, prior knowledge, or substantial revision.
- **2, Strong:** Clear, coherent, and ready for serious review.
- **3, Excellent:** Unusually thoughtful without adding effort or confusion.

A go-all-out result has no applicable category below 2. Understanding, ease of use, interface text, and recovery should reach 3 before extra visual or interactive polish matters.

## Mandatory beginner gate

A direction is not approval-ready unless a fresh reviewer can use the interface without a spoken explanation.

- If the reviewer cannot say what the product does and what to do first, Product understanding cannot score above 1.
- If the reviewer cannot complete the common task without coaching, Ease of use cannot score above 1.
- If an essential action depends on discovering a gesture, Controls and interaction cannot score above 1.
- If labels assume unexplained product or technical knowledge, Interface text cannot score above 1.
- If the reviewer cannot explain what changed or recover from a mistake, Feedback and recovery cannot score above 1.
- If there was no fresh review, mark beginner usability as unverified instead of passing it.

Visual quality, animation, and novelty cannot raise these scores.

## Review categories

### 1. Product understanding

- The first screen makes the product's purpose clear.
- The user can see what the product helps them achieve.
- The next action is obvious without instructions.
- The product does not assume prior industry or technical knowledge.

### 2. Ease of use

- The common path has no avoidable step, field, decision, or wait.
- The user sees one dominant action at a time.
- Defaults reduce work and remain easy to review or change.
- Progress and context survive interruptions.

### 3. Interface text

- Labels use short, everyday words.
- Buttons say what will happen.
- New ideas are explained when they first appear.
- Instructions, validation, errors, and empty states help the user act.

### 4. Information and navigation

- Each screen has one clear purpose.
- Importance is clear through order, spacing, size, and contrast.
- The user knows where they are and how to continue or go back.
- Secondary controls do not compete with the main task.

### 5. Feedback and recovery

- Every action receives immediate and understandable feedback.
- The user can tell what changed and whether it was saved.
- Mistakes can be corrected, undone, retried, or cancelled.
- Errors explain the problem and the next useful action.

### 6. Identity and recognition

- The product has a recognizable point of view tied to its purpose.
- One concrete metaphor is visible in layout, components, objects or illustration, and motion—not only in copy.
- Logo, color, type, shape, icons, imagery, and voice feel related.
- The name and logo remain understated while the product work carries the identity.
- Placeholder identity work is clearly marked when final assets do not exist.
- A mascot or character, when used, has a useful recurring role.
- The product does not look like an unchanged component kit.

### 7. Controls and interaction

- Controls look actionable and use familiar behavior.
- Essential actions have a visible tap, click, or keyboard path.
- Gestures improve the task but are not required for understanding.
- Focus, hover, pressed, selected, disabled, and keyboard behavior are covered where relevant.

### 8. Visual polish and aliveness

- The interface is clean, consistent, and suitable for the audience.
- The neutral canvas dominates; meaningful objects, illustration, or one warm accent supply color.
- Each screen or section is calm and contains no more than one competing crafted surprise.
- Material cues, handwriting, and themed progress reinforce the concept without carrying essential meaning.
- Motion explains change, preserves context, or rewards meaningful progress.
- Playfulness never delays or hides the task.
- Reduced-motion behavior is complete.

### 9. Journey and state coverage

- The main journey is designed from entry through success and return use.
- Relevant empty, loading, partial, success, error, offline, denied, and retry states exist.
- Realistic long, awkward, and missing content remains usable.

### 10. Accessibility and context

- Contrast, text size, target size, focus order, meaning, and keyboard access meet the platform standard.
- Meaning does not depend on color, sound, motion, or gesture alone.
- Layout works at the target sizes and with larger text.
- The design supports the expected input methods and one-handed use when relevant.

### 11. Trust and control

- Cost, privacy, permissions, destructive effects, and data use are explained before commitment.
- The user can review, correct, cancel, undo, export, or recover where appropriate.
- The design does not use hidden choices or false urgency.

### 12. Implementation and performance

- The working result matches the approved design and content.
- The main path works with realistic data, not only a staged example.
- Layout remains stable and feedback is immediate.
- Broken links, errors, clipping, overflow, and avoidable delays are fixed.

## Mandatory aliveness gate

For an interactive product, important actions must respond visibly. Static screens can support review, but they cannot prove interaction.

The response may be quiet. It needs to show the action, acknowledgement, result, and recovery. Decorative animation does not count.

If the design tool cannot demonstrate an important behavior, use a small working prototype for that part. Do not build a motion study before the beginner gate passes.

## Review order

Run reviews in this order and fix failures before continuing:

1. Beginner understanding
2. Main-task completion
3. Interface text
4. Feedback and recovery
5. Identity and recognition
6. Controls and interaction
7. Visual polish and aliveness
8. State coverage
9. Accessibility and target sizes
10. Working implementation and performance
11. Independent adversarial review

After these passes, run [adversarial-review.md](adversarial-review.md). Report what was tested, who or what performed each review, what failed, what changed, and what remains unverified.
