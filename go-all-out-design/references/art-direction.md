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
- **Contrast blocks:** use occasional `#1A1A1A` tiles with flat geometric illustrations.
- **Lists:** align the label left, muted metadata right, and separate rows with hairline dividers.
- **Layout:** use a narrow centered column of roughly 640–720 px for text and up to roughly 1100 px for grids. Use three-up card grids where the viewport and content support them. Adapt these proportions for mobile rather than shrinking desktop layouts.

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
