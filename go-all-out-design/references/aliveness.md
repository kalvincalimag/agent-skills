# Motion and feedback

Read this only after the plain journey passes the beginner check.

Aliveness means the product responds clearly and pleasantly when the user acts. It does not mean loud, unusual, or heavily animated. The best animation is often none. Most candidate animations should fail the gate below.

The gate, timing, easing, gesture, and review rules adapt Emil Kowalski's skills (github.com/emilkowalski/skills, MIT License, copyright (c) 2026 Emil Kowalski), including the principles they distill from Apple's design talks.

## Keep the clear path

Do not replace a familiar button, label, or navigation pattern with a gesture or metaphor the user must discover. Drag, swipe, flip, scrub, voice, and other expressive inputs may be added when they make the task faster or clearer. Keep a visible tap or click option for every essential action. If the expressive version needs instructions and the familiar one does not, the familiar one is the main path.

## The response loop

For an important action, show this loop. Do not add steps to manufacture interaction.

1. **Invitation.** The control looks actionable and its label says what it does.
2. **Action.** The user acts through a familiar control or an optional shortcut.
3. **Response.** The product acknowledges the action at once, on press rather than on release. During a drag, slider, or swipe, the interface tracks the finger one to one the whole way, not only at the end.
4. **Result.** The user can see what changed and why it matters.
5. **Recovery.** The user can correct, undo, retry, or continue.

Never lock input during a transition. A user who acts mid-animation interrupts it, and the motion continues from where the element is on screen.

## Decide whether it moves

Every animation passes three questions, in order. Record the answers for the review.

1. **How often will the user see it?**

   | Frequency | Decision |
   | --- | --- |
   | 100+ times a day, such as tab switches, core navigation, and keyboard shortcuts | No animation |
   | Tens of times a day, such as list rows and frequent toggles | Opacity or color only, 150 ms or less, or none |
   | Occasional, such as sheets, menus, dialogs, and toasts | Standard animation |
   | Rare, such as first use, empty states, success, and completion | Delight allowed. The screen's one surprise lives here. |

2. **What is its purpose?** Name one: feedback, spatial consistency (showing where something came from or went), state indication, preventing a jarring change, or explanation in onboarding and marketing. Delight counts only in the rare tier. "It looks good" is not a purpose.
3. **Does it move data the user is reading or acting on?** Charts, tables, amounts, and counts do not move for style. Animate a number only when its value changes because of the user's action, from the old value to the new one.

## Timing and easing

Set every curve and duration explicitly, in prototypes and in code. Tool defaults are too weak.

| Element | Duration |
| --- | --- |
| Press feedback | 100 to 160 ms |
| Tooltips and small popovers | 125 to 200 ms |
| Menus and selects | 150 to 250 ms |
| Sheets, drawers, and dialogs | 200 to 500 ms, the larger the surface the longer |
| Marketing and explanation | Longer when the explanation needs it |

Keep interface animation under 300 ms unless a large surface needs more.

- **Entering or leaving:** a strong ease-out, such as `cubic-bezier(0.23, 1, 0.32, 1)`. It moves at once, which reads as responsive.
- **Moving on screen:** a strong ease-in-out, such as `cubic-bezier(0.77, 0, 0.175, 1)`.
- **Sheets and drawers:** an iOS-like curve, such as `cubic-bezier(0.32, 0.72, 0, 1)`.
- **Color changes:** a plain ease. **Constant motion, such as a progress bar:** linear.
- **Never ease-in on interface motion.** It delays the first frames, the moment the user watches most.
- **Springs** for gestures and anything the user can interrupt, because a spring continues from its current speed. Default to no bounce. Use a bounce of 0.1 to 0.3 only for physical, momentum-driven moves, such as drag to dismiss, or a playful direction's one surprise.

## Shape of the motion

- **Press feedback.** Every pressable element scales to 0.95 to 0.98 while pressed.
- **Nothing appears from nothing.** Start entrances at a scale of 0.9 to 0.97 with zero opacity, never at scale 0.
- **Grow from the trigger.** Menus, popovers, and anchored sheets grow from the control that opened them. Centered dialogs stay centered.
- **Leave the way it came.** A surface exits along the path it entered.
- **Slow where the user decides, fast where the system responds.** A hold to confirm a destructive action fills over about 2 s, linear. Release snaps back in about 200 ms.
- **Stagger groups lightly.** 30 to 80 ms between items, never blocking input. Skip it on lists the user opens many times a day.
- **Bridge crossfades.** When a crossfade shows two objects overlapping, add a slight blur, about 2 px, during the change so it reads as one object changing.
- **Match the identity.** The motion's character follows the metaphor and voice. A playful direction can be bouncier, and a dense tool stays crisp. Expressive motion belongs to the screen's one surprise.

## Gestures

- Require about 10 px of movement before committing to a direction, then track one to one.
- Dismiss on a quick flick, measured by speed, not only past a distance threshold.
- Animate to where the gesture is heading, carrying its speed into the settle.
- Past a boundary, add increasing resistance instead of a hard stop.
- Ignore a second finger once a drag has started.
- Give every gesture a visible control that does the same thing.

## Depth, haptics, and sound

- **Dim to focus, separate to keep flow.** A modal task gets a dimming scrim and pushes the background back. A non-blocking panel gets an offset or translucency without a scrim.
- **Never stack one light translucent surface on another.** Legibility collapses.
- **Haptics and sound** fire on the causal event, on the same frame as the visual change, and only for meaningful moments: a commit, a snap into place, success, and error. Feedback on every tap trains users to ignore all of it.

## Reduced motion and transparency

Reduced motion means gentler, not none. Keep opacity and color changes that aid understanding. Replace slides, springs, and parallax with short crossfades, and drop overshoot. When the user asks for reduced transparency, make translucent surfaces solid.

## Direction test

Check the direction with annotations hidden:

- Is the next action clear before anything moves?
- Does the response make the result easier to understand?
- Can the user complete the task without the expressive gesture?
- Does the motion keep the user's place and focus?
- Does the design still work with reduced motion?
- Does the personality stay useful after repeated use?

## Reject these patterns

- hidden gestures for essential actions
- motion that delays navigation, data entry, saving, or recovery
- animated tab switches, core navigation, or keyboard actions
- decoration that moves without responding to the user, including endless loops on persistent elements
- charts that redraw from zero, and numbers that count up, on every visit
- spinners or skeleton shimmer for loads under 300 ms, which flash like a glitch
- entrances from nothing, ease-in curves, and interface animation over 300 ms without a reason
- celebration for trivial actions
- a mascot used only as decoration
- playful wording that makes a label less clear
- a staged animation the editable prototype cannot perform
- transitions that lose scroll position, selection, or focus
- copied interactions that do not fit the product

## Review the motion

Watch each important interaction at normal speed, then at a quarter to half speed or frame by frame. Check that the curve starts and stops cleanly, the origin is right, and properties that move together stay in sync. Look again with fresh eyes in a later session. Test with reduced motion, after an interruption, and during recovery. Record what was tested. Do not score an intended interaction as a working one.

Fix in this order, and prefer the earliest fix that works:

1. Delete the animation.
2. Reduce it: shorter, smaller, fewer properties.
3. Fix the easing.
4. Fix the origin or the entrance.
5. Make it interruptible.
6. Make the timing asymmetric.
7. Polish it with blur, stagger, or springs.
