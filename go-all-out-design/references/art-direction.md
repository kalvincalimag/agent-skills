# Mandatory art direction

These rules define the skill's house style. They win over conflicting aesthetic or interaction preferences elsewhere in the skill. They do not override product requirements, beginner usability, accessibility, or platform constraints.

## Core principles

1. **Concept first.** Choose one concrete metaphor, such as an alarm clock or paper and physical objects. Express it through composition, components, illustration, objects, and motion—not only naming or copy.
2. **Restraint with one surprise.** Keep every screen or section calm. Give it one playful, crafted, or technically delightful moment rather than several competing effects.
3. **Thematic progress.** For scrolling experiences, replace or supplement the ordinary scrollbar with an on-theme indicator, such as a clock, dial, ruler, ticket edge, or another form derived from the metaphor. It must communicate real progress, remain unobtrusive, and have a reduced-motion treatment.
4. **Neutral canvas, borrowed color.** Build on grayscale. Let color enter through illustrations, objects, content, or one warm accent—not through a multicolor UI palette. Draw a small set of flat illustrations of the product's own subject matter, such as dishes for a meal planner or places for a travel app, save them as components, and let them carry most of the color.
5. **Hierarchy through contrast.** Use near-black headings and mid-gray body copy. Prefer weight, spacing, alignment, and tonal contrast over many sizes or colors.
6. **Show, do not tell.** Demonstrate value with live interactions, realistic product tiles, object behavior, or mascot scenes. Replace walls of claims and feature bullets with evidence.
7. **Tactile materiality.** Suggest a physical surface with restrained grain or noise, torn or zigzag edges, tape stripes, cut-paper layers, or realistic objects against flat UI. Material cues must serve the metaphor and must not reduce readability.
8. **Character as a system.** If a mascot appears, reuse the same character consistently. Give it one prop per idea and a useful role in guidance, feedback, recovery, or progress. The character itself is designed with the `mascot-design` skill.
9. **Human handwriting.** Use small handwritten annotations or arrows as invitations, such as “hey! click me ↗”. Keep them secondary, concise, and never the only label for an essential action.
10. **One idea per screen.** Prefer a centered single column, generous whitespace, and short sections. Each screen should have one purpose and one dominant action.
11. **Understated identity.** Keep names and logos small. Let the concept, objects, interactions, and product work carry the personality. A mascot is part of that work, not the logo, and may be the hero of a screen or page.
12. **Voice as design.** Write short, witty, confident copy. Be playful but never mean, obscure, or less precise about what an action does.

## Visual tokens

- **Canvas foundation:** this neutral canvas is the default. When the user asks for a different canvas, or the project's notes record one, use that instead and save it the same way. Save it as variables, as the main skill describes. Default values are light / dark:
  - `canvas/base` `#EDEDED` / `#161616`: page and screen background.
  - `canvas/raised` `#FFFFFF` / `#222222`: cards, sheets, pills.
  - `canvas/well` `#F4F4F4` / `#1C1C1C`: recessed areas inside a raised card, such as chips and empty-state panels.
  - `canvas/sunken` `#E2E2E2` / `#2A2A2A`: recessed areas on the base, such as inactive tabs and segmented-control tracks.
  - `canvas/shape` `#D8D8D8` / `#2E2E2E`: large decorative shapes on the canvas.
  - `canvas/faint` `#BFBFBF` / `#4A4A4A`: faint decoration and dashed outlines of empty slots.
  - `canvas/edge` `#E0E0E0` / `#333333`: hairline dividers and card outlines.
  - `text/strong` `#111111` / `#F2F2F2` and `text/body` `#6B6B6B` / `#A3A3A3`.
  - Shadows: soft (y 4, blur 16, black 6%) and lifted (y 12, blur 32, black 12%).

  The canvas is flat by default. Add a subtle monochrome grain only when the metaphor needs a physical surface.
- **Text:** use near-black `#111111` for headings, `#6B6B6B` for body copy, and a quieter gray for metadata.
- **Accent:** use one restrained warm family—orange, amber, or rust. Borrow other color only from meaningful illustrations, objects, or content.
- **Playful type:** use a heavy rounded geometric display face such as Nunito Black.
- **Refined type:** use a neutral grotesk such as Inter at smaller sizes.
- **Shapes:** prefer pill controls, cards with roughly 24–32 px radii, and soft or no shadows.
- **Buttons:** use one solid black primary pill. Use an outlined secondary pill with an accent-colored label.
- **Contrast blocks:** use occasional dark tiles. See "Identity layer" below for how to use them.
- **Lists:** align the label left, muted metadata right, and separate rows with hairline dividers.
- **Layout:** use a narrow centered column of roughly 640–720 px for text and up to roughly 1100 px for grids. Use three-up card grids where the viewport and content support them. Adapt these proportions for mobile rather than shrinking desktop layouts.

## Identity layer

A calm, neutral screen can be polished and still look white and redundant: every card the same white or the same pale tint, with the accent only on links. These qualities carry identity without adding noise. Use them together, within the restraint rules above.

- **Canvas contrast.** Keep the base visibly darker than the raised cards, such as `#EDEDED` under `#FFFFFF`. A near-white base makes every surface read as one white sheet.
- **Own palette, borrowed qualities.** Take a reference's qualities, never its palette. If the canvas, contrast tile, and accent together match a reference's, it reads as a replica. Change at least the contrast tile to a colour from the product's own world, such as a leaf, a material, or a place, and borrow a second illustration colour from the subject.
- **Contrast tiles.** Dark tiles in the product's own deep colour, near-black only as a last resort. Each has a short title, a one-line state, and one large object from the product's world. Give the tile a faint material cue from the metaphor, such as leaf veins, wood grain, or paper fibre, so it reads as a surface rather than a slab. Use one as the screen's single hero, or as one surface holding a list of choices, such as an add menu. Avoid grids of identical dark tiles; they are a common reference signature. Text carries the meaning; the object carries identity. Do not copy a reference's tile signature, such as its tilt-and-crop of flat art. Do not turn a settings or profile page into a grid of dark tiles; it looks like a common reference skeleton. Keep settings as rows, and give at most one block a product-specific picture.
- **One imagery style.** Prefer the content imagery style, such as food stickers, product renders, or place photos, inside tiles too. A second, flat interface style doubles the system and tends to look like whichever reference it came from.
- **Accent as mass.** The warm accent fills the large shapes that matter: the primary button, the current-day or current-item marker, selected chips and segments, an active toggle, a progress ring. Keep destructive actions out of the accent's main job: a red text row with an icon and Undo, not a second full-width button.
- **Hero numeral.** Give a card one large, heavy number when a number drives the next action, such as a time, a count left, or a stepper value, with a small sentence-case label. Never more than one per card.
- **Labels from the product's world.** A small label above a card's heading names the card, such as "Tonight" or "This week". Style it from the metaphor, such as masking tape, a stamp, a receipt, or a ticket stub, not as a generic solid-accent pill. It is a label, never a score or status badge.
- **Character in the content.** Where a mascot exists, stage it in the product's own objects and scenes, inside the card, rather than peeking over a card edge, a common reference pose. Use a plain-language verdict as the headline above any numbers. Do not add a mascot where the notes put identity work on hold.
- **Bento rhythm.** Vary the shapes down a screen, mixing full-width cards, 2-up tiles, and small pills, so no screen is a stack of identical white cards.
- **Objects bleed.** Let a large content object, such as a dish, a product, or a scene, bleed off a card's corner instead of sitting in a small centered thumbnail. Never let it cover text or controls.

Identity check: with annotations hidden, every screen shows at least one of a contrast tile, an accent mass beyond a link, or an illustrated object large enough to read at arm's length. Every screen also stays within the one-surprise and one-focus rules. If a screen fails either test, fix it before review.

## Interaction preferences

- Tie scroll-linked motion to the metaphor, such as a rotating dial or clock widget that communicates progress.
- Reimagine one familiar control as the signature interaction when it remains understandable—for example, a signature field that behaves like an Etch A Sketch.
- Use a simple custom cursor, such as a dot, only where it fits the metaphor and does not reduce precision or accessibility.
- Use looping mascot or object animation in feature sections when it remains calm, purposeful, and removable under reduced motion.
- Use live social proof, such as a running counter in the header, only when the data is real, current, and useful. Never fabricate activity.

Every expressive interaction needs a familiar visible control, immediate feedback, a clear final state, and a reduced-motion alternative.

## Reject these patterns

- gradient-heavy SaaS-template heroes;
- multiple competing accent colors;
- hero-sized names or logos without a structural concept;
- walls of feature bullets where a visual demonstration would work;
- generic stock illustrations or icons;
- several playful moments competing in one screen or section;
- metaphorical decoration that does not affect layout, components, or motion.

## Approval check

With annotations hidden, verify that a reviewer can identify the metaphor from the structure and behavior, not merely from the headline. Confirm that the neutral canvas dominates, the warm accent is scarce, the single surprise has room to land, and the product remains fully usable when custom motion, cursor behavior, texture, handwriting, and mascot animation are removed or reduced.
