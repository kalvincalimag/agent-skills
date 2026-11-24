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
| Visible text | 0–1 short lines; mostly labels, numbers and data | about 400 characters, many full sentences |

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
10. **Show the workflow, don't explain it.** People skim; they do not read sentences. On a resting screen use no sentences and at most one short line of 8 words or fewer, only where it prevents a mistake. Titles are 1–4 words, labels and buttons 1–3 words, and metadata is short tokens ("2 servings · 25 min", "12 items"). Let structure, position, pictures, numbers, checkmarks and a step guide carry the meaning. Delete instructions such as "Tap a dish to…" when the control already shows it. Sheets get a short title and options of 2–5 words; money, health and safety keep each price, date, limit and consequence, as one short line, not a paragraph.

## Align and balance

1. **One left edge.** Inside a card or sheet, every row, label and action starts at the same inset. Do not mix a stray pill or side-by-side text links into a list.
2. **Actions in a list.** A sheet's secondary actions form one grouped list. A destructive action gets its own group, in the accent or warning colour.
3. **Headers above groups.** A group's header sits above it, outside the card. Build it the same way on every sibling screen.
4. **One side margin.** Cards, hero tiles, lists and buttons on a screen share one side margin. A nested container must not add its own extra inset.
5. **Symmetric alternatives.** Options shown side by side get equal tile sizes, equal picture areas and the same number of text lines. Nothing, not even a mascot, overlaps one of them.
6. **No dead space, no floating cards.** Fill a large empty area with content the user needs at that moment, or move the next element up. Do not park a card at the bottom of the screen far from the content it belongs to.
7. **Lists scroll under floating bars.** A long list continues under a floating tab bar and fades. Do not cut it mid-row inside a fixed box.
8. **Text is never clipped.** After any type or size change, check descenders (g, y, p) and long words. A text box never clips its own text.

## Words in the layout

1. **Menu items are a verb and an object.** Give each a 2–5-word line underneath that tells it apart from its siblings, such as "Plan a meal · Pick a dish for a day" beside "New recipe · Write your own". Two options that a beginner could mistake for each other fail.
2. **Context once.** Put shared context in the title, such as the day being edited, and keep each option short. Do not repeat the context in every option.
3. **No empty placeholder rows.** When a global add action exists, a screen shows only what is there. It does not show a row per empty slot with its own "Add".
4. **Small beside large.** A badge or quick link, such as "Today", is smaller than the text it sits beside. Put it in a quiet neutral pill, and darken the accent if the pill lowers the contrast.
5. **Disclaimers are one line.** A legal, medical or money disclaimer is one short line in secondary text next to what it qualifies. Never make it a block that takes a large share of the screen.

## Small parts, finished

- **Light confirmations.** A toast after an action is a white surface with a soft shadow, a small success mark and the accent action, such as Undo. A dark slab adds a new colour block to the screen.
- **A custom main action at system quality.** A custom floating button, such as a centred add button, is a raised white circle with layered soft shadows and a crisp glyph in the accent colour. Never a flat disc inside a ring.
- **Provider marks.** "Continue with" sign-in buttons show each provider's official mark. Platform rules require it, and people look for the mark.
- **A mark for AI.** An entry point to an AI feature carries a recognisable AI mark, such as a sparkle, and looks like a button, not bare text. A mascot never fronts it.

## Keep identity while cleaning

Clean does not mean generic. Keep one signature identity element on each screen, such as the product's material as the hero surface, a mascot at a meaningful moment, or a crafted object. Remove the rest of the decoration. If removing everything decorative leaves a screen that could belong to any app, the signature element is missing. Restore one; do not restore all.

## Things to avoid

- A tinted canvas, warm or cool, under white cards.
- More than one saturated block on a screen, or a dark slab on every screen.
- Tags, pills or chips in a third colour that exists only to decorate.
- Outlined chips, outlined amount pills, and dashed "add" boxes.
- A picture or sticker on every row; 3D pictures and line icons side by side in the same row.
- Several bold headlines competing on one screen.
- Sentences that explain what the layout already shows, helper paragraphs under titles, and labels longer than the thing they label.
- A card inside a card inside a card.
- **Camouflaged actions.** A light grey button on a light grey canvas disappears. Every action needs contrast against its own background: the primary action is filled with the accent; a secondary action is a white surface on the canvas, or accent-coloured text that meets 3:1 contrast.
- **Cropped content.** A circular mask, a ring or a card edge that cuts through a dish, an illustration or a sticker's outline. Keep the whole object inside its frame with padding, or crop on purpose as a full-bleed image, never halfway.
- Cleaning by deleting meaning: a removed picture or colour that carried state must be replaced by a label or a quiet indicator.
- **Floating mid-screen menus.** Option lists and short tasks open as bottom sheets; see [native-feel.md](native-feel.md).
- **Black toasts and slabs** that add a colour block for a passing message.
- **Misaligned rows**, such as a value in a grey pill whose text starts further in than the rows around it.
- **Lopsided pairs**, such as two option tiles of different sizes, or a character overlapping one of them.
- **Repeated weekday letters** on every row of a multi-week calendar, and rings, pictures or connector lines inside calendar cells.
- **Look-alike labels**, such as "Meal" and "Your own recipe" in one menu.
- **A disclaimer box** that is bigger than the content it qualifies.

## Clean and fun together

Resting screens stay calm. Fun lives in moments: choosing, finishing, first use, empty states, waits and mistakes, as [fun.md](fun.md) describes. One crafted surprise per screen is enough. A playful object that repeats on every row is clutter, not fun.

## Measure it

Measure at the target size with a screenshot, before and after:

1. Strong edges: the share of pixels where an edge filter exceeds a fixed threshold. Target 7% or less on resting screens.
2. Quiet area: the share of 10 px blocks whose luminance standard deviation is below 2. Target 60% or more.
3. Count pictures, outlines (excluding checkboxes, inputs and selected states), text sizes, colour families, nesting depth and visible characters from the design file. Targets: pictures 4 or fewer except in pickers and galleries, outlines 3 or fewer, text sizes 5 or fewer, nesting 1, about 150 visible characters or fewer on a resting screen and no full sentences (lists may need more for their items).

A screen that misses a target needs a reason, such as a picker, a gallery or a dense data view the requirements call for.

## Clean an existing design

1. Copy two or three of the busiest everyday screens and work on the copies, next to the originals.
2. Apply the principles in order: canvas, outlines and shadows, nesting, colour blocks, pictures, type.
3. Keep the signature identity element and the fun moments.
4. Re-measure, show before and after side by side, and roll out to the rest only after the user approves.
5. Then check every screen for camouflaged actions and cropped content, which a clean pass often creates.
