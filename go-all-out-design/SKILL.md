---
name: go-all-out-design
description: "Use only when the user explicitly invokes $go-all-out-design. Turn a product brief and existing design work into one deeply developed, intuitive, memorable design direction per invocation. Apply a concept-first, restrained, tactile house style with a neutral canvas, borrowed color, calm and clean resting screens, a native platform feel, purposeful motion, one crafted surprise per screen, and fun where it adds value, without making the product harder to use. Never select this skill implicitly."
disable-model-invocation: true
argument-hint: "[product, flow, screen, site, or app]"
---

# Go all out on design

Design for a smart person with no technical or product knowledge. They should understand the product and complete its main task without help from the designer.

Use this priority order:

1. The user understands what the product does.
2. The user knows what to do next.
3. The user completes the main task with little effort.
4. The user can understand, correct, and recover from mistakes.
5. The product has a clear, memorable identity.
6. The product feels polished and responsive, and fun where fun adds value.

A later quality cannot make up for an earlier failure. Visual polish cannot rescue a confusing journey. Novel interaction cannot replace a clear control. Personality cannot replace useful labels. Calm, familiar, conceptually coherent, and carefully finished can be the strongest direction. But polish alone can still feel like a chore: [references/fun.md](references/fun.md) finds those moments.

## Workflow

For a full product task, work in this order. Do not force the full process onto a small correction.

1. Establish the truth.
2. Make the plain journey work, then run the beginner check in [references/novice-usability.md](references/novice-usability.md).
3. Choose one direction under the art direction in [references/art-direction.md](references/art-direction.md).
4. Build the shared parts, then the screens, in the design file.
5. Keep resting screens calm with [references/clean.md](references/clean.md) and native to the platform with [references/native-feel.md](references/native-feel.md). Then add identity, then fun from [references/fun.md](references/fun.md), then motion and feedback from [references/aliveness.md](references/aliveness.md).
6. Cover states and worst-case content.
7. Verify with [references/polish-rubric.md](references/polish-rubric.md), then [references/adversarial-review.md](references/adversarial-review.md).
8. Report, and stop for approval.

To review a product that is already built, do not create a direction. Follow "Review an existing product" in [references/adversarial-review.md](references/adversarial-review.md), and stop for approval before changing anything.

Rules rank in this order when they conflict:

1. Product requirements, beginner usability, accessibility, and platform constraints.
2. Taste the user states, or the project's notes record.
3. The house style in [references/art-direction.md](references/art-direction.md), which fills every gap the taste leaves.
4. Any other aesthetic or expressive guidance in this skill.

## Establish the truth

Locate the product requirements, existing editable design, approved brand material, target platforms, technical limits, and accessibility needs. Read the requirements and inspect the current design before creating replacements.

If no brief exists, offer a short working brief for approval. It names the main user, promise, main task, important limits, and settled decisions. If no editable design exists, ask before creating one. A general design request does not authorize changing an external file.

Keep intake short. Ask no more than three grouped questions, recommend defaults, and defer details that do not block the first useful design.

Find the user's design taste before choosing a visual direction: products or designs they admire, palette or canvas preferences, type or style preferences, and reference mascots when a mascot fits. Take taste only from the project's notes or knowledge base, including any reference images stored there and the verdicts recorded with them. Do not search for or read reference folders outside the notes. If the user points to one, ask them to add it to the notes first. If nothing is recorded, make taste one of the grouped intake questions: one to three references, what they like about each, and any palette or style preferences. Offer the house style as the default if they have none. Record the answers in the project's notes, if it keeps them, so later sessions do not ask again.

Define the beginner's goal in their own words, the first useful result, the minimum information they must provide, and any unfamiliar ideas that need explanation. Do not make users learn the product team's vocabulary before they can act.

## Make the plain journey work first

Before exploring the visual direction, design the shortest understandable path from entry to useful result.

- Use familiar navigation and controls.
- Give each screen one purpose and one dominant next action.
- Use short, specific labels that say what will happen.
- Introduce information only when it becomes useful.
- Show progress, status, results, and consequences in plain language.
- Keep essential controls visible. Gestures may be shortcuts, never the only path.
- Use helpful defaults and support review, correction, undo, and retry.
- Do not use onboarding text to explain an interface that should explain itself.
- No tours, coach marks or step guides. If a screen needs one, fix the screen.
- First use opens the real product, with the navigation a returning user has, already filled with a clearly labelled sample to keep or clear.
- Ask for an account when saving first matters, with a way to decline, unless the requirements need it earlier. See "First use without help" in [references/novice-usability.md](references/novice-usability.md).

The interface must make sense without designer annotations. Run the beginner check in [references/novice-usability.md](references/novice-usability.md) before choosing a visual direction, and fix the journey if it fails.

## Choose one direction

For a new product, redesign, or unresolved direction, create exactly one deeply developed direction per invocation. Do not create a trio, a comparison matrix, or several partial alternatives. Spend the time on making one direction coherent and approval-ready. If the user wants another direction, they invoke the skill again, and that invocation is a fresh exploration, not a color variation.

Choose the direction from the product truth, user needs, constraints, and lessons from existing work. Keep the proven basic journey unless a change clearly reduces effort and passes the beginner check. Before building, state what the direction keeps from earlier work, such as the journey, recorded decisions, and the user's feedback, and what it changes.

Read and apply [references/art-direction.md](references/art-direction.md) before choosing the visual system. Commit to one metaphor and make it structural, as its first principle requires.

The direction must show:

- a first screen that makes the product's purpose and next action clear
- the main task from its visible start to a clear result
- navigation and progress that keep the user oriented
- a realistic mistake, empty state, or failure with recovery
- concise interface text that assumes no prior knowledge
- a distinct identity, content voice, and level of expression
- motion only where it passes the gate in [references/aliveness.md](references/aliveness.md)
- the main strengths, risks, and tradeoffs

Explain why the direction is the strongest fit, including its risks and hypotheses. Stop for approval before producing the full screen set unless the user requested the full set in the same invocation.

## Guardrails

These hold for every direction, alongside the art direction.

- **Scope.** Add no feature, screen, or control the approved requirements do not include, such as an AI chat bar, streaks, badges, or scores. Propose it separately and flag it as added scope.
- **One imagery style.** Use one imagery style for content across the product, and one icon style for controls. Do not mix photographs with drawn characters or illustrations on the same screen, or put 3D pictures and line icons side by side in one row.
- **Quiet numbers.** Show the one number that drives the user's next decision and move the rest into a detail view. On a resting screen, prefer one number to a chart. When a trend is the point, draw the chart as [references/charts.md](references/charts.md) describes. Every chart says what it measures and in what units. Avoid stacked or multi-ring gauges.
- **Real content.** Use real day names and dates and everyday content for the audience and place, not aspirational stock imagery or slogans. Spell-check every visible string before taking review screenshots.
- **References inform, never copied.** Take principles from references. Never copy a reference's layout, assets, images, text, palette, or signature components. Before building from a reference's qualities, write down how each quality translates into the product's own world. For example, the reference's black tiles become a material from the product's metaphor, and its accent pill tags become the product's own kind of label. Build the translation, not the original. Before presenting, run the replica check in [references/adversarial-review.md](references/adversarial-review.md).
- **Ask before spending.** Ask before using paid credits, a paid model, or a paid plan.

## Build in the design file

Put the direction on its own new page or file. Do not edit, move, or delete existing pages, frames, components, or variables unless the user asked for that.

- **Own parts.** Build the direction's own components and variables, named for the direction. Reuse parts from earlier work only when the user asks, or for a placeholder the project's notes say to keep.
- **Shared parts first.** Before drawing screens, build the shared parts as components in a separate Components section: controls, navigation, cards, rows, messages, content illustrations, and mascot poses. Build every screen from instances of them, so a later change reaches every screen.
- **Colors as variables.** Save the canvas, text, and accent colors from [references/art-direction.md](references/art-direction.md) as named variables with light and dark modes. Give each variable a short description of its use and limit it to the properties it belongs on. Bind every fill, stroke, and text color to a variable, and save shadows as effect styles.
- **Notes outside the screens.** Add an About panel with the idea, why it fits, risks, what is covered and what is not yet, and a draft status label. Add an Identity board with the wordmark, app icon, color swatches with values, type, mascot poses, motion values, and sample wording. Add a short caption above each screen linking it to the requirements. Keep every note outside the screen frames and mark it as an annotation, so all notes can be hidden for review.
- **One story.** All screens follow one continuous scenario with realistic content for the product's audience and place. A detail that appears on one screen must be explained by an earlier screen.
- **Prototype the motion.** Set every prototype transition's curve and duration from [references/aliveness.md](references/aliveness.md). Never leave the tool's default.
- **Small batches.** Build at most three screens at a time. After each batch, screenshot the screens at their target size and fix clipping, overlap, contrast, and missing elements before continuing. If a build step fails partway, remove what it left behind before retrying.
- **Review page, review material only.** Samples, explorations, prototype-only copies and scratch layers stay off the page the user reviews; move them to an archive page. Before moving a frame, repoint every prototype link into it to the matching review screen. Delete empty layers that scripts leave behind.
- **Captions describe, annotations record.** A caption says what the screen shows. Change notes and build notes go in the frame's annotation, never in the caption.
- **Look-alikes change together.** Screens that show the same thing in two states, such as a tab and its first-use version, change in the same pass. So do a component and any detached copies of it.
- **Close gaps, leave overlays alone.** When hiding or resizing a node in a frame without auto layout, move the content below it to close the gap. Never move sheets, menus, scrims, toasts or floating bars while doing so.

Once the shared parts exist, building or restyling many screens is parallel work. When subagents or separate sessions are available, use them:

1. Build the shared parts, variables, and one or two pilot screens yourself, and screenshot them. The pilot is the pattern every worker copies.
2. Split the remaining screens into groups that share no screens, such as by flow. Give each worker its screens, the pilot's node IDs, the rules from this skill and the project's taste notes, and the checks it must run: screenshots in every mode and a spacing measurement.
3. Give each shared component and variable one owner. Workers edit only their own screens and assigned components, and report a needed change to a shared part instead of making it.
4. Do independent work, such as notes and briefs, while the workers run.
5. Integrate the results yourself. Sweep for consistency: the same element is built the same way on every screen, whichever worker built it. Then update the About and Identity boards and the captions.

Do not split a small correction or a single screen across workers. Without a parallel tool, work in the same order sequentially.

## Build identity after clarity

For a new consumer or lifestyle product without approved assets, give the direction a placeholder identity. Keep the name and logo understated so the work stays the loud part. Include a wordmark or logo idea, an app icon or product mark when relevant, the color and type approach, a concept-specific object or illustration style, a concise writing voice, and examples inside real screens. Mark placeholder identity work as a hypothesis until approved.

Consider a mascot or recurring character unless that would be inappropriate. Give it useful jobs, such as guiding first use, explaining an unfamiliar idea, improving an empty state, helping with an error, or marking meaningful progress. Never use it as a random sticker or a substitute for clear design. Design the character itself with the `mascot-design` skill. If that skill cannot be invoked, read `../mascot-design/SKILL.md` from this skill's folder and follow it. This skill still decides where the mascot appears and what job it does there.

- If the screens have no mascot yet, place the recommended candidate on them until the user picks.
- If they already show one, keep it until the user picks.
- If the project's notes put identity work on hold, such as the mascot, use the current placeholder as it is. Do not redesign it or start the `mascot-design` skill.
- If the project's notes record an approved character, place only its approved poses. When a screen needs a pose that does not exist yet, get it through the `mascot-design` skill's extension step. Never generate the character from text alone.

## Keep resting screens calm and clean

Read and apply [references/clean.md](references/clean.md) before identity and fun, and again before presenting. Resting screens get one hero, a neutral canvas, one accent, one level of cards, almost no outlines, and pictures only where the content is the subject. Keep one signature identity element per screen. Check every action for contrast against its own background, and every picture for cropping.

## Feel native on the platform

Read and apply [references/native-feel.md](references/native-feel.md) for every phone screen. Use the platform's titles, grouped lists, sheets, switches, date strips and system greys. Match each choice to its control. Keep the signature elements the user likes, and ask before replacing one with a stock component.

## Make it fun where it adds value

After the identity is in place, read and apply [references/fun.md](references/fun.md). Run its chore test on every screen. Give each input, decision, empty state, wait, finish, repeated chore and mistake a fun move that adds value, or record why none fits. Fun changes how a required task feels; it never adds scope, pressure or delay.

## Add motion and feedback

After the direction passes the beginner check, read and apply [references/aliveness.md](references/aliveness.md). It decides what moves, how fast, and with which curve, and it covers gestures, haptics, and reduced motion.

## Cover states and worst-case content

Design the states needed for safe use: first use, empty, loading, partial, success, error, offline, denied, retry, undo, and cancellation where relevant. Check safe areas, contrast, focus order, target sizes, keyboard use, screen readers, reduced motion, slower devices, and interrupted work.

The one story uses typical content. Then test every screen against the hardest content a real user could produce, because demo content is chosen to make a design look good.

1. List every value each screen shows: names, labels, counts, amounts, dates, images, and the length of each list. Note the real limit when the requirements give one.
2. Pick plausible worst cases, never nonsense strings: a long real name, a one-letter name, a missing image or optional field, a count of exactly 0 and 1, the largest realistic count, a long translated label, and an old date.
3. Spread them across the rows on screen, as real data mixes them. Also check an empty list, a list of one, and the realistic maximum.
4. View each screen at the smallest supported width, the largest text size, dark mode, and right-to-left where supported.
5. Look for squeezed avatars or icons, overflowing text, trailing actions pushed off the edge, badges that wrap, rows misaligned once text wraps, wrong initials, and plurals such as "1 items".

Use tabular figures for numbers that change in place. Switch relative dates such as "340 days ago" to absolute dates after a week. Record the fix for each break. Where the fix is a design decision, such as truncating or wrapping, flag it for the user.

Use common platform patterns when they improve familiarity. Break a convention only when the benefit is clear and the new behavior stays easy to learn.

## Verify before presenting

Before calling a direction approval-ready or a product polished, read and apply [references/polish-rubric.md](references/polish-rubric.md), then run [references/adversarial-review.md](references/adversarial-review.md). The adversarial review holds the rules for fresh reviewers and for reviewing again after changes.

Inspect the real artifact at the target size with annotations hidden. Judge layout from a full-size screenshot, because a downscaled render can hide a problem or invent one. Do not claim a design is intuitive from the designer's own review.

Do not present a direction for approval if it needs a spoken explanation, hides the next action, depends on a hidden gesture, assumes unexplained knowledge, leaves results unclear, uses polish to hide an unfinished journey, makes a required input or decision feel like a chore when a move from [references/fun.md](references/fun.md) fits, misses the clean targets in [references/clean.md](references/clean.md) without a reason, camouflages an action against its background, crops content by accident, or has no recognizable identity beyond generic components.

## Report

Open with a short summary of a few bullets. Then say what was produced, tested, changed, and left unverified, and name each screen and mode that did not get a fresh review. End with any rule in this skill that was unclear, conflicted with another rule, or could not be followed, so the skill can be fixed.

Ask each open decision on its own, so it can be answered without earlier context:
- name the screen and what it does;
- give a concrete example of the situation;
- list the options, with their tradeoffs;
- recommend one.

## Refine a direction

When the user reviews a direction and raises concerns, answer each one with a recommendation, a short reason, and the design change it needs. Flag any recommendation that adds scope beyond the approved requirements. When the user asks to remove something that may not be in the requirements, check the requirements first and answer with the source before removing anything. Wait for approval before changing the design. Reuse existing patterns and components before adding screens or controls.

When the user asks to revamp the identity of an existing direction, such as when it looks plain, white, or repetitive, keep its journey, labels, and approved decisions. Change the identity layer described in [references/art-direction.md](references/art-direction.md), in place on the direction's page, and record what changed.

After approval, apply the changes and update any requirement or brief documents the user asked to keep in sync. If the applied change differs from what was proposed, say what changed and why. Then review again as [references/adversarial-review.md](references/adversarial-review.md) requires.
