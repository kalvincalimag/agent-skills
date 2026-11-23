# Calm and clean

Read this before adding identity and fun, and again in every review.

A clean screen gives the eye one place to start and plenty of quiet space around it. Calm comes from removing things, not from adding them. Identity and fun still belong. They live in one signature element and in moments, not on every row.

## What clean looks like, measured

Two clean reference apps, a travel booking app and an alarm app, were measured against a busy draft of a consumer app at the same phone size:

| Measure | Clean references | Busy draft |
| --- | --- | --- |
| Strong edges (how much the eye has to scan) | 3–5% of pixels | 9–10% |
| Quiet area (10 px blocks with almost no tonal change) | 62–66% | 43–57% |
| Colour families with real area | 1–2 | 3 |
| Pictures per screen | 0–1 | 8–14 |
| Outlines per screen | almost none | 16–25 |
| Text sizes per screen | 4–5 | 6–10 |
| Levels of nested cards | 1 | up to 4 |

A clean pass on the draft lowered strong edges to about 7.5% and raised quiet area to about 59%, and the user preferred the result at once. Treat the targets below as review gates, not as style.

## Principles

1. **Neutral canvas, surfaces by tone.** Use a near-white neutral canvas (very light grey with almost no tint) and white cards. Separate surfaces with a small tonal step, never with outlines or heavy shadows. A warm beige or sepia canvas beside white cards reads as old paper.
2. **One hero per screen.** One element is clearly the largest: a number, a route, the dish for tonight, the time. Everything else is small and light. Large type can be a lighter weight. Do not fix weak hierarchy by making every heading bolder.
3. **One accent for action and state.** One accent colour marks the primary action and the current state. The identity colour may appear as one signature surface on a screen, such as the product's own material. It never appears as several competing colour blocks.
4. **Pictures where the content is the subject.** Use pictures in a hero, a picker, a gallery, an empty state or a finishing moment. Leave them off list rows, section labels and buttons, where text and a quiet control are faster to scan.
5. **No outlines by default.** Cards, chips and pills use fills, not borders. Keep strokes only for controls that need them, such as checkboxes, inputs and selected states. Use dashed borders only for drop targets. Use shadows only for floating layers, such as a tab bar, a sheet or a toast.
6. **One level of cards.** Cards sit directly on the canvas. Inside a card, group with spacing and hairline dividers, not with another card.
7. **Few text styles.** Use four or five sizes per screen and two weights. Secondary text uses one grey.
8. **Few shapes.** Use two or three corner radii (card, control, pill) and one icon style.
9. **Quiet space is a feature.** At least 60% of a resting screen should be quiet.

## Keep identity while cleaning

Clean does not mean generic. Keep one signature identity element on each screen, such as the product's material as the hero surface, a mascot at a meaningful moment, or a crafted object. Remove the rest of the decoration. If removing everything decorative leaves a screen that could belong to any app, the signature element is missing. Restore one; do not restore all.

## Things to avoid

- A tinted canvas, warm or cool, under white cards.
- More than one saturated block on a screen, or a dark slab on every screen.
- Tags, pills or chips in a third colour that exists only to decorate.
- Outlined chips, outlined amount pills, and dashed "add" boxes.
- A picture or sticker on every row; 3D pictures and line icons side by side in the same row.
- Several bold headlines competing on one screen.
- A card inside a card inside a card.
- **Camouflaged actions.** A light grey button on a light grey canvas disappears. Every action needs contrast against its own background: the primary action is filled with the accent; a secondary action is a white surface on the canvas, or accent-coloured text that meets 3:1 contrast.
- **Cropped content.** A circular mask, a ring or a card edge that cuts through a dish, an illustration or a sticker's outline. Keep the whole object inside its frame with padding, or crop on purpose as a full-bleed image, never halfway.
- Cleaning by deleting meaning: a removed picture or colour that carried state must be replaced by a label or a quiet indicator.

## Clean and fun together

Resting screens stay calm. Fun lives in moments: choosing, finishing, first use, empty states, waits and mistakes, as [fun.md](fun.md) describes. One crafted surprise per screen is enough. A playful object that repeats on every row is clutter, not fun.

## Measure it

Measure at the target size with a screenshot, before and after:

1. Strong edges: the share of pixels where an edge filter exceeds a fixed threshold. Target 7% or less on resting screens.
2. Quiet area: the share of 10 px blocks whose luminance standard deviation is below 2. Target 60% or more.
3. Count pictures, outlines (excluding checkboxes, inputs and selected states), text sizes, colour families and nesting depth from the design file. Targets: pictures 4 or fewer except in pickers and galleries, outlines 3 or fewer, text sizes 5 or fewer, nesting 1.

A screen that misses a target needs a reason, such as a picker, a gallery or a dense data view the requirements call for.

## Clean an existing design

1. Copy two or three of the busiest everyday screens and work on the copies, next to the originals.
2. Apply the principles in order: canvas, outlines and shadows, nesting, colour blocks, pictures, type.
3. Keep the signature identity element and the fun moments.
4. Re-measure, show before and after side by side, and roll out to the rest only after the user approves.
5. Then check every screen for camouflaged actions and cropped content, which a clean pass often creates.
