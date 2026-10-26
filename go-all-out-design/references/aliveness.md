# Designing for useful aliveness

Read this only after the plain journey passes the beginner usability check.

Aliveness means the product responds clearly and pleasantly when the user acts. It does not mean the product must be loud, unusual, or heavily animated.

## Keep the clear path

Do not replace a familiar button, label, or navigation pattern with a gesture or metaphor that the user must discover.

Drag, swipe, flip, scrub, voice, and other expressive inputs may be added when they make the task faster or easier to understand. Keep a visible tap or click option for every essential action.

If the expressive version needs instructions but the familiar version does not, use the familiar version as the main path.

## The response loop

For an important action, show this loop:

1. **Invitation:** The control looks actionable and its label says what it does.
2. **Action:** The user acts through a familiar control or an optional shortcut.
3. **Response:** The product acknowledges the action at once.
4. **Result:** The user can see what changed and why it matters.
5. **Recovery:** The user can correct, undo, retry, or continue.

Do not add steps to manufacture interaction.

## Restraint with one surprise

Keep the baseline calm: stable layout, restrained motion, clear state changes, and generous whitespace. Give each screen or section at most one expressive interaction, crafted object, mascot scene, or delightful response. The surprise should make the concept memorable without slowing or competing with the task.

## Use identity to help

Use the neutral canvas and borrowed-color rules in [art-direction.md](art-direction.md). Sound, illustration, objects, and mascots can make the product easier to recognize and understand.

A character may explain a new idea, point to the next step, help with an empty state, soften an error, or celebrate meaningful progress. Do not use a character to cover unclear labels or navigation.

## Direction test

Check the direction with the annotations hidden:

- Is the next action clear before anything moves?
- Does the response make the result easier to understand?
- Can the user complete the task without the expressive gesture?
- Does the motion keep the user's place and focus?
- Does the design still work with reduced motion?
- Does the personality remain useful after repeated use?

Remove any behavior that adds delay, confusion, pressure, or tiring repetition.

## Reject these patterns

- hidden gestures for essential actions;
- motion that delays navigation, data entry, saving, or recovery;
- decoration that moves without responding to the user;
- celebration for trivial actions until it becomes noise;
- a mascot used only as decoration;
- playful wording that makes a label less clear;
- a staged animation that the editable prototype cannot perform;
- transitions that lose scroll position, selection, or focus;
- copied interactions that do not fit the product.

Test the journey at normal speed, with reduced motion, after interruption, and during recovery. Record what was tested. Do not score an intended interaction as a working interaction.
