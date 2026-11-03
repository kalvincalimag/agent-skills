---
name: miro-as-built-diagrams
description: Draw or update an "as built" diagram pair on a Miro board, a sequence diagram of a user journey plus a table of the endpoints it calls, so the board matches what the code does. Uses a small SVG generator and the Miro MCP's Canvas Composer tools. Use when asked to diagram a flow that was just built, add a frame next to an existing one, list a feature's endpoints on a board, or check a board frame against the code.
---

# As-built diagrams on Miro

An as-built pair is two frames side by side:

- **The journey:** a sequence diagram. Lanes for each party (people on the left, our own system in the middle, outside systems on the right), one band per step of the page, and arrows in the order the code runs.
- **The endpoints:** a table with Method, Path, What it does and Who can call, grouped by the same steps.

The generator in `scripts/` draws both from a plain spec, so a new pair looks like the old ones and can be redrawn in one call.

## Pick the diagram first

Choose the type from the question the reader has. One diagram answers one question.

| The reader asks | Draw | Level |
| --- | --- | --- |
| Who talks to whom, at a glance? | Interaction overview: parties as boxes, numbered arrows, no lifelines | High |
| What steps does a person go through, and what happens behind each? | Sequence diagram with phase bands (the generator's `sequence`) | Medium |
| What can I call, and who may call it? | Endpoint table (the generator's `sheet`) | Reference |
| What depends on what? | Component map: boxes grouped by system, arrows for "calls" or "reads" | High |
| How does one record change state over time? | Lifecycle: states as boxes, transitions labelled with what causes them | Granular |
| How does money or data move in one operation? | Sequence diagram scoped to that operation, one row per write | Granular |

Before drawing, check whether an existing frame already answers the question. If it does, point to it instead.

## Write for the room

- **Write in the board owner's voice.** Read their frames first and match their register: spoken, everyday sentences ("we save the request first"), not terse labels ("Request: saved. Status: pending.").
- **Fewest items that reach the goal.** Every box, arrow and note must earn its place. Say a shared rule once. Reference tables keep the 3 to 5 columns that matter.
- **Comprehensible without background.** A reader who doesn't know the codebase should follow it. Name parties by what they are ("Our server", "Where we save things"), not by internal module names. Table and column names belong only in granular data-model diagrams.
- **One level per frame.** Don't mix a high-level overview with function names, or a lifecycle with page copy.

## Rules

- **Every label traces to code.** Read route handlers and services on a named commit, not the docs or a plan. Never invent a function, route or step. Anything not built goes in a yellow note as open, never as an arrow.
- **Arrows follow real hops.** A browser never talks to the database: a web-app read goes web app, then server, then database. An outside system calling us gets its own lane.
- **Plain English first.** Each arrow says what happens in everyday words, with the route or function in italics on the line below. Keep error paths and response shapes out. One shared rule goes in the band's description once, not on every arrow.
- **Show only what is new.** If an existing frame already draws a part of the flow, add a grey note pointing to it ("From here, it works exactly like …") instead of redrawing it.
- **Never edit someone else's frame.** Add a new frame next to it, name it "… (as built)", and let its owner decide what to delete. Ask before changing or deleting anything on a shared board.
- **Match the board's existing style.** If the board already has as-built frames, read one and copy its lanes, colours, widths and wording register. The generator's defaults are one such style.

## Procedure

1. **Pin the code.** Fetch the branch the board describes and note the commit.
2. **Collect the facts.** List the page's steps in order (from the page's step list, not memory). For each, read the route handler, then the service, and note what is checked, saved and called, and who may call it. Note limits and the human gates.
3. **Write the spec.** Copy `scripts/example.js`. Fill `lanes`, `phases` (each with `title`, `desc` and `steps`) and the endpoint `sections`. A step is `{ from, to, text, tech, reply }`, or `{ note, lane }`, or `{ note, span: [a, b], color }`. Grey notes are rules or pointers; yellow notes are gates or gaps.
4. **Generate and check.** Run `node <spec>.js`, then `node check.js <svg>`. It lists text that may not fit. Method pills flagged as a few units tight are fine.
5. **Find empty space.** Search the board for frames (`canvas_search` with `re:data-type="frame"`) and pick a spot next to the frames this pair belongs with. Set `x` and `y` in the spec.
6. **Create.** Load the Canvas Composer skill first (`canvas_get_canvas_composer_skill`), then send the SVG with `canvas_create_from_svg`. Check that each frame's `transform` in the result is where you asked; if not, move it with `canvas_update_from_svg`. The result can be too big to read inline: parse its `result_svg` for the frame ids and any `failed_items`.
7. **Look at it.** Open the board in a browser at `?moveToViewport=x,y,width,height` (board units), wait 30 to 40 seconds for it to render, and screenshot it close up and zoomed out. Check labels are readable and nothing overlaps.
8. **Record it.** Save the spec and the frame ids where the project keeps its knowledge, so the next update starts from the spec, not from the board.

## Miro MCP behaviour that matters

- There is a daily cap on MCP calls per organisation. Generate the whole pair and send it in one create call.
- Arrows between lifelines need an anchor at each end: a 4-unit ellipse with `fill="#ffffffff" stroke="#ffffffff"` (transparent). `none` is accepted but ignored, leaving visible circles. Arrows between two shapes can attach to the shapes directly.
- Connector captions render too small to read. Put each arrow's label in its own 22-unit text box above the arrow (the generator does this).
- A long arrow's label crosses other lifelines. `labelMask: true` puts a borderless box in the band's colour behind the label.
- Text at 22 units in Noto Sans runs about 12.8 board units per character. Text boxes grow around their centre when text wraps; read `data-rendered-bounds` in the result to space anything added later.
- A text box whose content starts with `<strong>` and ends with `</strong>` turns bold as a whole. End with plain text.
- To move or resize something inside a frame, send the frame's full form: `<g data-miro-id transform data-frame>` plus its `<rect data-type="frame">`. A bare group is ignored. Move children before shrinking a frame, in a separate call.
- Editing an existing area needs a baseline: read the area first and send its `data-scope` and `data-baseline-hash`. Read again after anyone edits the board by hand.
- "Board access denied" while other calls work means the board is gone or not shared, not a sign-in problem. Ask where the diagrams live now.
