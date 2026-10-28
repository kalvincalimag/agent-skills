---
name: go-all-out-design
description: "Use only when the user explicitly invokes $go-all-out-design. Turn a product brief and existing design work into one deeply developed, intuitive, memorable design direction per invocation. Apply a concept-first, restrained, tactile house style with a neutral canvas, borrowed color, and one crafted surprise per section without making the product harder to use. Never select this skill implicitly."
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
6. The product feels polished, responsive, or playful where useful.

A later quality cannot make up for an earlier failure. Visual polish cannot rescue a confusing journey. Novel interaction cannot replace a clear control. Personality cannot replace useful labels. The result does not need to be flashy. Calm, familiar, conceptually coherent, and carefully finished can be the strongest direction.

## Establish the truth

Locate the product requirements, existing editable design, approved brand material, target platforms, technical limits, and accessibility needs. Read the requirements and inspect the current design before creating replacements.

If no brief exists, offer a short working brief for approval. It must name the main user, promise, main task, important limits, and settled decisions. If no editable design exists, ask before creating one. A general design request does not authorize changing an external file.

Keep intake short. Ask no more than three grouped questions, recommend defaults, and defer details that do not block the first useful design.

Find the user's design taste before choosing a visual direction: products or designs they admire, palette or canvas preferences, type or style preferences, and reference mascots when a mascot fits. Take taste only from the project's notes or knowledge base, including any reference images stored there and the verdicts recorded with them. Do not search for or read reference folders outside the notes; if the user points to one, ask them to add it to the notes first. If nothing is recorded, make taste one of the grouped intake questions. Ask for one to three references and what they like about each, plus any palette or style preferences, and offer the house style as the default if they have none. Record the answers in the project's notes, if it keeps them, so later sessions do not ask again.

Define the beginner's goal in their own words, the first useful result, the minimum information they must provide, and any unfamiliar ideas that need explanation. Do not make users learn the product team's vocabulary before they can act.

## Make the plain journey work first

Before exploring the visual direction, design the shortest understandable path from entry to useful result.

- Use familiar navigation and controls.
- Give each screen one purpose and one dominant next action.
- Use short, specific labels that say what will happen.
- Introduce information only when it becomes useful.
- Show progress, status, results, and consequences in plain language.
- Keep essential controls visible. Gestures may be shortcuts, not the only path.
- Use helpful defaults and support review, correction, undo, and retry.
- Do not use onboarding text to explain an interface that should explain itself.

The interface must make sense without designer annotations. A reviewer should identify the product, current task, next action, and result by looking at the screens.

Read and apply [references/novice-usability.md](references/novice-usability.md) before creating or approving the direction. Fix the plain journey if it fails.

For a full product task, work in this order: truth, plain journey, beginner check, one direction, identity and system, state coverage, realistic testing, and final polish. Do not force the full process onto a small correction.

## Apply the mandatory art direction

Before choosing the visual system, read and apply [references/art-direction.md](references/art-direction.md). Its concept, composition, token, material, voice, and interaction rules override any conflicting aesthetic or expressive guidance elsewhere in this skill. Taste the user states, or the project's notes record, wins over the house style where the two conflict, and the house style fills every gap. Product requirements, beginner usability, accessibility, and platform constraints remain non-negotiable.

Choose one concrete metaphor and make it structural: it must affect layout, components, illustration or objects, and motion. A concept that appears only in the name, headline, or annotations does not count.

## Guardrails

These hold for every direction, alongside the art direction.

- **Scope.** Add no feature, screen, or control the approved requirements do not include, such as an AI chat bar, streaks, badges, or scores. Propose it separately and flag it as added scope.
- **One imagery style.** Use one imagery style for content across the product. Do not mix photographs with drawn characters or illustrations on the same screen.
- **Quiet numbers.** Show the one number that drives the user's next decision and move the rest into a detail view. Prefer a plain sentence to a chart. Every chart says what it measures and in what units; avoid stacked or multi-ring gauges.
- **Real content.** Use real day names and dates and everyday content for the audience and place, not aspirational stock imagery or slogans. Spell-check every visible string before taking review screenshots.
- **References inform, never copied.** Take principles from references. Never copy a reference's layout, assets, images, or text into the design.
- **Ask before spending.** Ask before using paid credits, a paid model, or a paid plan.

## Create one design direction per invocation

For a new product, redesign, or unresolved direction, create exactly one deeply developed design direction. Do not create a trio, comparison matrix, or several partially developed alternatives in the same invocation. Concentrate the available time, reasoning, and craft on making one direction coherent and approval-ready.

Choose the direction from the product truth, user needs, constraints, and lessons from existing work. Keep the proven basic journey unless a change clearly reduces effort and passes the beginner check. Before building, state what the new direction keeps from earlier directions, such as the journey, recorded decisions, and the user's feedback on them, and what it changes. If the user wants another direction, they can invoke the skill again; treat that later invocation as a fresh exploration, not a color variation of the previous result.

The direction must show:

- a first screen that makes the product's purpose and next action clear;
- the main task from its visible start to a clear result;
- navigation and progress that keep the user oriented;
- a realistic mistake, empty state, or failure with recovery;
- concise interface text that assumes no prior knowledge;
- a distinct identity, content voice, and level of expression;
- interaction and motion only where they improve understanding, speed, confidence, or enjoyment;
- the main strengths, risks, and tradeoffs.

Commit to one metaphor and one coherent point of view. Keep the composition calm and let each screen or section contain at most one crafted surprise. Carry the concept consistently through hierarchy, components, material cues, voice, and interaction without sacrificing the clear core journey.

Explain why the direction is the strongest fit, including its main strengths, risks, and hypotheses. Stop for approval before producing the full screen set unless the user explicitly requested that full set in the same invocation.

## Lay out the design file

Put the direction on its own new page or file. Do not edit, move, or delete existing pages, frames, components, or variables unless the user asked for that.

- **Own parts.** Build the direction's own components and variables, named for the direction. Reuse components or variables from earlier work only when the user asks, or for a placeholder the project's notes say to keep.
- **Shared parts first.** Before drawing screens, build the shared parts as components in a separate Components section: controls, navigation, cards, rows, messages, content illustrations, and mascot poses. Build every screen from instances of them, so a later change to a part reaches every screen.
- **Colors as variables.** Save the canvas, text, and accent colors from [references/art-direction.md](references/art-direction.md) as named variables with light and dark modes. Give each variable a short description of its use and limit it to the properties it belongs on. Bind every fill, stroke, and text color to a variable, and save shadows as effect styles.
- **Notes outside the screens.** Add an About panel with the idea, why it fits, risks, what is covered and what is not yet, and a draft status label. Add an Identity board with the wordmark, app icon, color swatches with values, type, mascot poses, and sample wording. Add a short caption above each screen linking it to the requirements. Keep every note outside the screen frames and mark it as an annotation, so all notes can be hidden for review.
- **One story.** Make all screens follow one continuous scenario with realistic content for the product's audience and place. A detail that appears on one screen must be explained by an earlier screen.
- **Small batches.** Build at most three screens at a time. After each batch, screenshot the screens at their target size and fix clipping, overlap, contrast, and missing elements before continuing. If a build step fails partway, remove what it left behind before retrying.

## Build identity after clarity

For a new consumer or lifestyle product, give the direction a suitable placeholder identity when approved assets do not exist. Keep the name and logo understated so the work remains the loud part. Include a wordmark or logo idea, an app icon or product mark when relevant, the prescribed color and type approach, a concept-specific object or illustration style, a concise writing voice, and examples inside real screens.

Consider a mascot or recurring character unless that would be inappropriate. Reuse it as a system and give it one prop per idea. Give it useful jobs, such as guiding first use, explaining an unfamiliar idea, improving an empty state, helping with an error, or marking meaningful progress. Do not use a mascot as a random sticker or a substitute for clear design. Design the character itself with the `mascot-design` skill. If that skill cannot be invoked, read `../mascot-design/SKILL.md` from this skill's folder and follow it. This skill still decides where the mascot appears in the product and what job it does there. If the screens have no mascot yet, place the recommended candidate on them until the user picks. If they already show one, keep it until the user picks. If the project's notes put any identity work on hold, such as the mascot, use the current placeholder as it is: do not redesign it or start the `mascot-design` skill. Mark placeholder identity work as a hypothesis until approved.

After a direction passes the beginner check, read and apply [references/aliveness.md](references/aliveness.md). Add immediate feedback, continuity, warmth, and one purposeful surprise without hiding controls or delaying the task. Keep familiar alternatives for gestures and support reduced motion.

## Cover dependable states

Design the states needed for safe use, including first use, empty, loading, partial, success, error, offline, denied, retry, undo, and cancellation where relevant. Check realistic long content, larger text, localization, small screens, safe areas, contrast, focus order, target sizes, keyboard use, screen readers, reduced motion, slower devices, and interrupted work.

Use common platform patterns when they improve familiarity. Break a convention only when the benefit is clear and the new behavior remains easy to learn.

## Verify before presenting

Before calling a direction approval-ready or a product polished, read and apply [references/polish-rubric.md](references/polish-rubric.md), then run [references/adversarial-review.md](references/adversarial-review.md).

Inspect the real artifact at the target size with annotations hidden. Use a fresh reviewer when possible. Test first-glance understanding, the main task, correction, recovery, and realistic content. If no fresh reviewer is available, mark beginner usability as unverified. Do not claim that a design is intuitive based only on the designer's own review.

The adversarial reviewer must try to disprove the design's claims rather than confirm them. Give them the product requirements and artifact, but withhold the designer's rationale, recommendation, and prior scores. Fix supported approval-blocking findings and repeat the review with fresh context.

Do not present a direction for approval if it needs a spoken explanation, hides the next action, depends on a hidden gesture, assumes unexplained knowledge, leaves results unclear, uses polish to hide an unfinished journey, or has no recognizable identity beyond generic components.

A review covers only the screens and modes it saw. Any later change makes that review stale for what changed: a refinement round, a new or edited screen, a new state, or a new mode such as dark mode. Before reporting a change as done, run a fresh adversarial review on every new or changed screen, and screenshot every defined mode on the real screens. Do not reuse an earlier reviewer, because they have already seen the design. If a required review did not run, do not call the work done or approval-ready. Name each unreviewed screen and mode in the report and run the review before asking for approval.

Report what was produced, tested, changed, and left unverified. Open the report with a short summary of a few bullets. End it with any rule in this skill that was unclear, conflicted with another rule, or could not be followed, so the skill can be fixed.

## Refine a direction

When the user reviews a direction and raises concerns, answer each one with a recommendation, a short reason, and the design change it needs. Flag any recommendation that adds scope beyond the approved requirements. Wait for approval before changing the design. Reuse existing patterns and components before adding screens or controls.

After approval, apply the changes and update any requirement or brief documents the user asked to keep in sync. If the applied change differs from what was proposed, say what changed and why. Then rerun the review as the verification section requires.
