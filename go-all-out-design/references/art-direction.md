# Mandatory art direction

These rules define the skill's house style. The main skill sets their rank: they give way to product requirements, beginner usability, accessibility, platform constraints, and the user's recorded taste, and they win over any other aesthetic guidance.

## Core principles

1. **Concept first.** Choose one concrete metaphor, such as an alarm clock or paper and physical objects. Make it structural. It must shape layout, components, illustration or objects, and motion. A concept that appears only in the name, headline, copy, or annotations does not count.
2. **Restraint with one surprise.** Keep every screen or section calm: stable layout, clear state changes, and generous whitespace. Give it at most one crafted surprise, such as an expressive interaction, a crafted object, a mascot scene, or a delightful response. The surprise makes the concept memorable and never slows or competes with the task.
3. **Thematic progress.** On long scrolling pages, such as a marketing site, replace or supplement the ordinary scrollbar with an on-theme indicator derived from the metaphor, such as a dial, ruler, or ticket edge. It must show real progress, stay unobtrusive, and have a reduced-motion treatment. In app screens, keep the platform's scroll indicator.
4. **Neutral canvas, borrowed color.** Build on grayscale, with an untinted near-white canvas and white cards separated by tone, as [clean.md](clean.md) describes. Color enters through illustrations, objects, content, or one warm accent, never through a multicolor interface palette. Draw a small set of illustrations of the product's own subject matter, such as dishes for a meal planner or places for a travel app, in the product's one imagery style. Save them as components and let them carry most of the color.
5. **Hierarchy through contrast.** Prefer weight, spacing, alignment, and tonal contrast over many sizes or colors. Give each screen one hero that is clearly the largest, and keep the rest small and light. Use the text tokens below.
6. **Show, do not tell.** Demonstrate value with live interactions, realistic product tiles, object behavior, or mascot scenes. Replace walls of claims and feature bullets with evidence.
7. **Tactile materiality.** Suggest a physical surface with restrained grain, torn or zigzag edges, tape stripes, cut-paper layers, or realistic objects against flat interface. Material cues serve the metaphor and never reduce readability.
8. **Character as a system.** If a mascot appears, use the same character everywhere, with one prop per idea and a useful role. Stage it inside the product's own objects and scenes, not peeking over a card edge, which is a common reference pose. The `mascot-design` skill designs the character, and the main skill decides its jobs.
9. **Human handwriting.** Use small handwritten annotations or arrows as invitations, such as "hey! click me ↗". Keep them secondary and concise, and never the only label for an essential action.
10. **One idea per screen.** Each screen has one purpose and one dominant action, with generous whitespace and short sections. On phones, use one column and vary the shapes inside it, as "Bento rhythm" below describes. On wide screens, use a centered text column of about 640 to 720 px and grids up to about 1100 px, with three-up grids where the content supports them. Adapt proportions for mobile rather than shrinking desktop layouts.
11. **Understated identity.** Keep names and logos small. The concept, objects, interactions, and product work carry the personality. A mascot is part of that work, not the logo, and may be the hero of a screen.
12. **Voice as design.** Write short, witty, confident copy. Be playful but never mean, obscure, or less precise about what an action does.

## Visual tokens

The neutral canvas below is the default. When the user asks for a different canvas, or the project's notes record one, use that instead. When the user asks for a platform's native feel, use that platform's system greys from [native-feel.md](native-feel.md). Save every token as a variable, as the main skill describes. Values are light / dark.

- `canvas/base` `#EDEDED` / `#161616`: page and screen background.
- `canvas/raised` `#FFFFFF` / `#222222`: cards, sheets, and pills.
- `canvas/well` `#F4F4F4` / `#1C1C1C`: recessed areas inside a raised card, such as chips and empty-state panels.
- `canvas/sunken` `#E2E2E2` / `#2A2A2A`: recessed areas on the base, such as inactive tabs and segmented-control tracks.
- `canvas/shape` `#D8D8D8` / `#2E2E2E`: large decorative shapes on the canvas.
- `canvas/faint` `#BFBFBF` / `#4A4A4A`: faint decoration, and the dashed outline of a drop target.
- `canvas/edge` `#E0E0E0` / `#333333`: hairline dividers between rows. Cards and chips get no outline.
- `text/strong` `#111111` / `#F2F2F2` for headings, `text/body` `#6B6B6B` / `#A3A3A3` for body copy, and a quieter gray for metadata.
- Shadows: soft (y 4, blur 16, black 6%) and lifted (y 12, blur 32, black 12%).

The canvas is flat by default. Add a subtle monochrome grain only when the metaphor needs a physical surface.

- **Accent:** one restrained warm family, such as orange, amber, rust, or a warm red. Borrow other color only from meaningful illustrations, objects, or content.
- **Type:** a heavy rounded geometric display face, such as Nunito Black, for playful moments, and a neutral grotesk, such as Inter, at smaller sizes. Tighten the tracking of large headings slightly. Keep body lines to about 65 characters.
- **Shapes:** pill controls, cards with roughly 24 to 32 px radii, and soft or no shadows.
- **Buttons:** one solid primary pill filled with the accent, or near-black when the accent fails text contrast. A secondary action is a white pill on the canvas or accent-colored text with at least 3:1 contrast, never a light grey pill on a light grey canvas.
- **Lists:** label left, muted metadata right, and hairline dividers between rows, in inset groups with headers above them, as [native-feel.md](native-feel.md) describes.

## Identity layer

A calm, neutral screen can be polished and still look white and redundant: every card the same white or the same pale tint, with the accent only on links. These qualities carry identity without adding noise. Use them together, within the restraint rules above.

- **Canvas contrast.** Keep the base visibly darker than the raised cards, such as `#EDEDED` under `#FFFFFF`. A near-white base makes every surface read as one white sheet.
- **Own palette, borrowed qualities.** If the canvas, contrast tile, and accent together match a reference's, the product reads as a replica. Change at least the contrast tile to a color from the product's own world, such as a leaf, a material, or a place, and borrow a second illustration color from the subject.
- **Contrast tiles.** Dark tiles in the product's own deep color, with near-black only as a last resort. Each has a short title, a one-line state, and one large object from the product's world. Give the tile a faint material cue from the metaphor, such as leaf veins, wood grain, or paper fibre, so it reads as a surface rather than a slab. Use one as the screen's single hero, or as one surface holding a list of choices, such as an add menu. Text carries the meaning and the object carries identity. Avoid grids of identical dark tiles, and do not copy a reference's tile signature, such as its tilt-and-crop of flat art. Keep settings and profile pages as rows, with at most one block that has a product-specific picture.
- **One imagery style, inside tiles too.** A second, flat interface style doubles the system and tends to look like whichever reference it came from.
- **Accent as mass.** Use the accent on few elements per screen, but give those elements mass: the primary button, the current-day or current-item marker, selected chips and segments, an active toggle, or a progress ring. Keep destructive actions out of the accent's job: a red text row with an icon and Undo, not a second full-width button.
- **Hero numeral.** When a number drives the next action, such as a time, a count left, or a stepper value, give the card one large, heavy number with a small sentence-case label. Never more than one per card. Put a plain-language verdict as the headline above any numbers.
- **Labels from the product's world.** A small label above a card's heading names the card, such as "Tonight" or "This week". Style it from the metaphor, such as masking tape, a stamp, a receipt, or a ticket stub, not as a generic solid-accent pill. It is a label, never a score or status badge.
- **Bento rhythm.** Vary the shapes down a screen, mixing full-width cards, 2-up tiles, and small pills, so no screen is a stack of identical white cards.
- **Objects bleed.** Let a large content object, such as a dish, a product, or a scene, bleed off a card's corner instead of sitting in a small centered thumbnail. Never let it cover text or controls.

Identity check: with annotations hidden, every screen shows at least one of a contrast tile, an accent mass beyond a link, or an illustrated object large enough to read at arm's length. Every screen also stays within the one-surprise and one-focus rules. Fix any screen that fails either test before review.

## Interaction preferences

[aliveness.md](aliveness.md) sets the rules every motion must pass. Within them, these are the house style's signature moves.

- Reimagine one familiar control as the signature interaction when it stays understandable, such as a signature field that behaves like an Etch A Sketch.
- Use a simple custom cursor, such as a dot, only on pointer devices, where it fits the metaphor and does not reduce precision or accessibility.
- Loop a mascot or object animation only on marketing pages or rare moments, and stop it after a few cycles. In product screens, play it once, in response to a cause.
- Use live social proof, such as a running counter in the header, only when the data is real, current, and useful. Never fabricate activity.

## Reject these patterns

- gradient-heavy SaaS-template heroes
- multiple competing accent colors
- hero-sized names or logos without a structural concept
- walls of feature bullets where a visual demonstration would work
- generic stock illustrations or icons

## Approval check

With annotations hidden, a reviewer can identify the metaphor from the structure and behavior, not merely from the headline. The neutral canvas dominates, the accent sits on few elements, and the single surprise has room to land. The product stays fully usable when custom motion, cursor behavior, texture, handwriting, and mascot animation are removed or reduced.
