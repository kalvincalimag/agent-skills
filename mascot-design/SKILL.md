---
name: mascot-design
description: Use when creating, redesigning, or reviewing a mascot or recurring character for a product, app, site, or brand, including when another design skill reaches its identity step and a mascot fits. Produces a character that can stand beside the best product mascots without looking weaker: a concept with a story, appealing shape design, acting poses tied to product moments, staging inside the product, and a side-by-side lineup against reference characters that the user judges. Also extends an approved character with new poses made from its master image. Not for icon sets, general illustration, or logos without a character.
argument-hint: "[product, and any reference characters to match]"
---

# Mascot design

A mascot earns its place when people remember it after one look and connect it to the product. The strongest product mascots share four things: the character is the brand, it has one unmistakable trait, it acts out what the product does, and it lives inside the product's pages instead of sitting beside them.

Legibility is the floor, not the goal. A mascot that passes every size and contrast check but is forgettable has failed. Judge the result by one question: placed beside the reference characters at the same size, does it look as finished, as specific, and as alive? The user answers that question by looking. Checks only find problems.

Read [references/appeal.md](references/appeal.md) before writing concepts, and [references/review.md](references/review.md) before presenting anything.

**Scope.** When the mascot is the task, develop all three candidates fully. When another design skill calls this one during a broader design pass, develop the strongest candidate fully and show the other two at concept-sheet level, so the mascot keeps its quality bar without crowding out the rest of the design.

**Approved character.** If the project's notes record an approved character, do not design a new one. Go to [Extending an approved character](#extending-an-approved-character).

## How mascots fail

These failures are what this skill exists to prevent. Check every candidate against them.

- **Generic subject.** A common animal or object chosen because it is cute, with no reason to belong to this product.
- **Template face.** Two dots with highlights, a small mouth, and blush circles, reused across candidates. That is a style, not a character.
- **Stiff body.** Front-facing, symmetrical, standing still. Poses that change only the face.
- **Floating props.** Props drawn beside the character instead of held, worn, or used.
- **Saturated body.** The whole body in one loud color, which fights the neutral canvas and hides the focal accents.
- **No world.** The character is shown only on a blank board, never inside the product, a scene, or a moment.
- **Primitive construction.** A body built from stacked circles, ellipses, and rounded rectangles in code, which reads as clip art however carefully it is colored.
- **Drift.** The face, signature trait, proportions, or colors change from pose to pose, so the poses read as different characters.
- **Checklist pass.** A board that records passed checks but would lose a side-by-side comparison with the references.

## Process

### 1. Brief

Write a short brief before any concept: the product's promise in one sentence, its audience, the place and culture it launches in, its name, the canvas and accent colors it uses, and the product moments where the mascot will appear. Typical moments are first use, an empty state, an error, a warning, a success, a streak or reward, and a landing-page hero.

### 2. Study the references

Reference characters set the quality bar. Find them in this order: characters the user names in the request; references, past rounds, and the user's verdicts recorded in the project's notes or knowledge base, if it keeps one; then ask the user for one or two characters they admire, what they like about each, and any color or style preferences for the mascot. Collect images of every reference, and record the answers in the project's notes, if it keeps them, so later sessions do not ask again. If the user gave a video, extract frames of the moments where the character appears, moves, or reacts. Use `ffmpeg`; if it is not on the PATH, look in the usual install locations before asking the user. Save the best frames as files, because the review lineup needs them. For each reference, write a breakdown using the qualities in [references/appeal.md](references/appeal.md): concept, signature trait, edge, name, shape language, color, acting, staging, voice, and world. These breakdowns are the brief's quality bar. Borrow qualities, never designs, names, or recognizable features.

If mascot candidates already exist, review them against the failure list above and the review in [references/review.md](references/review.md). Name where each falls short, and treat those failures as constraints on the new round.

### 3. Concepts in words

Write at least twelve one-line concepts before drawing. Each line names the subject, the signature trait, the personality edge, the name, and the tie to the product. Use the form of a pitch, for example: "a hedgehog with pencil spines who will not let homework slide; strict, never harsh."

Tie each concept to what the product is about first, such as food for a meal planner or money for a finance app. A tie to the launch place or culture is a bonus on top of that, not a substitute for it. Cut to three. Keep the three that are most specific to this product and most different from each other. Say in one line why each of the others was cut.

### 4. Character sheets

For each of the three, write:

- the pitch line;
- the subject and its story, meaning why it belongs to this product, place, or audience;
- the signature trait and what it says about the character's role;
- three personality words, including one edge, such as nosy, dramatic, or bossy, with its limit, such as "never mean";
- the name and how it meets the product's name;
- its world: where it lives, a reward object or sidekick tied to its nature, and the scenes it appears in;
- three lines it would say at real product moments.

### 5. Draw

Use the best image tool available. Check what the session offers before drawing.

- **Reference image required.** A mascot is one character in many poses. A tool that works from words alone redraws the character in every image, so it drifts and falls back on a stock face. Before drawing, check that the image tool accepts a reference image, for example by editing an existing image. If no tool in the session does, stop the mascot work and tell the user: name a tool that does and what it costs, and draw nothing until they choose. A design pass that called this skill keeps any current placeholder meanwhile.
- **Style by eye.** Before developing candidates, draw the leading concept in three or four styles the tool renders well, such as a 3D toy render, flat stickers, and a painted look, at the same size. The user picks the style by looking. Image tools rarely make flat vector art look finished, so do not choose it by default.
- **One pose per image.** Draw each candidate's hero pose alone and large, in three-quarter view. Then make every expression and acting pose as its own image, with the hero attached as the reference. Packing a whole sheet into one image leaves each figure too few pixels, and the faces turn generic. Assemble the character sheet from the separate images. Describe the qualities in the prompt, never "in the style of" a named character or artist.
- **Spend.** Image generation usually costs credits. Spend one hero image per candidate first. Keep the rest of the budget for the poses and redraws of the leading candidates, and add scenes only for the candidate you will recommend. If the budget cannot cover the heroes plus a full pose set for one candidate, say so when you ask. Before the first call, tell the user the tool, the model, and the planned count, and get approval, unless the user already approved a budget. Stay inside the approved count.
- **In-product art.** Use the chosen style in the product. For a rendered style, such as 3D, ship transparent cut-outs at twice the largest display size. For a flat style, the vector version comes from a vectorizing tool or a designer. Do not hand-draw character paths in code, because they read as clip art. Either way, add a simplified version, such as the head alone, for the smallest sizes.

Follow the craft rules in [references/appeal.md](references/appeal.md) at every step.

### 6. Develop each candidate

Each of the three candidates gets:

- a hero pose in three-quarter view with a clear line of action;
- an expression sheet of at least five moods, carried by brows, lids, and posture as well as the mouth;
- three acting poses, each one acting out a real product feature with a held or used prop;
- the in-product art at 24, 48, and 120 px, plus the simplified version at 16 px, on every surface the product uses, including brand-colored tiles and dark mode;
- two in-context mockups: one product screen at a real moment, and one hero or marketing moment where the character interacts with the layout, such as peeking from a card edge or breaking out of a frame;
- a short motion note for one signature interaction, with its reduced-motion version.

### 7. Check, then present

First look at your own lineup beside the references at the same size, and fix any gap you can already see. Then run the checks in [references/review.md](references/review.md). Reviewers find measurable problems, such as a face that blurs at 48 px or a prop that floats, and you fix them. They do not rank candidates or decide whether one is ready. The user judges appeal by looking at the lineup.

Present the three candidates on one board, marked as placeholders, beside the references at the same size. Each round gets its own new board labeled with its round number. Leave earlier boards unchanged so the user can compare rounds. Each shows its character sheet, art, check results, and one-line downside. Recommend one and say why, but the user picks. If the product already shows a mascot, leave it in place until the user picks.

### Revising after a pick

Every revision, whether the user asks for it or a review prompts it, follows these rules.

- **Locked traits.** When the user approves a trait, such as the signature feature, the face, the palette, or the body, add it to a locked list on the board. A review never changes a locked trait. Only the user can unlock one.
- **Scope.** Change only the area the request names. A face pass changes the face. A silhouette request changes the outline and the parts that form it, and if that means replacing limbs or other approved parts, ask first. Record other findings as open items and leave them alone.
- **Options before big changes.** When a change would replace a part, change a locked trait, or alter the character's construction, build two or three options and let the user pick.
- **One change at a time.** Apply one revision, review it, then move to the next. Do not stack several redesigns into one round.

### 8. Character bible

After the user picks, produce the character bible: a construction guide with base shapes and proportions, a turnaround of front, three-quarter, side, and back views, the expression and action sheets, the color specification, the size rules, do and don't examples, voice rules with sample lines, and the component built as a system as described in [references/appeal.md](references/appeal.md). For vector art, build the rig here, then check it: every pose on the sheets must be reachable by moving parts, without redrawing the body. For rendered art, the component holds the approved pose images, and new poses come from [Extending an approved character](#extending-an-approved-character).

## Extending an approved character

When the project's notes record an approved character, do not design a new one. Make each new pose or expression by editing the approved master image with a tool that accepts it as a reference, one pose per image. Attach the master to every edit, never an earlier edit, so changes do not pile up. Run the drift check in [references/review.md](references/review.md) on each result, and redo any pose that drifted. The user approves each new pose before it goes into the product. Record approved poses in the project's notes.

## Working with other design skills

When another design skill, such as `go-all-out-design`, needs a mascot, it hands off to this skill for the character and keeps ownership of where the mascot appears in the product and what job it does there. This skill's output replaces any mascot rules in the other skill.

## Record what was learned

If the project keeps notes or a knowledge base, record there what the next round needs: the reference characters and their breakdowns, each round's candidates with images, the user's verdict and reasons, and the chosen character once approved. User preferences about mascots belong in those notes, not in this skill. Follow the project's own rules for where and how it stores knowledge.

## Report

Open with a short summary of a few bullets. Then report the brief, the reference breakdowns, the concept list with cuts, the three candidates with check results, the recommendation, what was not produced, and any spend. End with any rule in this skill that was unclear, conflicted, or could not be followed.
