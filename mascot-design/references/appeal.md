# Mascot appeal: craft rules

These rules turn a concept into a character people remember. They describe what strong product mascots share. The examples are invented to show each rule; they are not characters to copy.

## Concept

- **A subject with a reason.** The subject belongs first to what the product is about, then optionally to its place or name. A tortoise suits a savings app that rewards patience. An animal native to the launch market can carry local pride. A cute subject with no reason is generic.
- **One signature trait.** One feature beyond the face that you could describe in five words and that says what the character does, such as a hedgehog whose spines are pencils for a homework app. The trait often doubles as the silhouette. Test: describe the character in one sentence after a five-second look. "A hedgehog with pencil spines" passes. "A cute orange squirrel" fails.
- **An edge.** Friendly alone is forgettable. Give the personality one edge with a limit, such as "bossy, never rude" or "nosy, never creepy." The edge comes from the product's job.
- **The name is the brand.** The character shares the product's name or is an obvious play on the product or its subject. If the product name cannot change, the mascot's name still plays on it, and the mascot can become the app icon.
- **A world.** The character has a place and a reward object or sidekick that comes from its nature, such as a bee whose streaks fill a honeycomb. Hero scenes put it in places its audience recognizes.
- **Objects can work.** A personified object, such as a fruit, a dish, or a tool, passes when it meets every point above and has a body and costume of its own. It fails when it is the object with a cute face added.

## Shape

- **One dominant base shape.** Match it to the personality: rounds for warm and soft, squares for steady and dependable, triangles and diagonals for energy and mischief.
- **Big, medium, small.** Give every design one large mass, one medium feature, and small details, never several shapes of the same size. A body is large, the signature accessory is medium, and the beak, feet, or buttons are small.
- **Exaggeration can live in an accessory.** The focal point does not have to be huge eyes. Small dot pupils behind giant goggles, or a scarf longer than the body, can carry the exaggeration. Choose the one feature that makes the character, then push its size well past realistic.
- **Few features.** Every extra feature weakens the signature trait. Remove anything that does not serve the silhouette, the trait, or the acting.
- **Proportion for appeal.** Use a large head-to-body ratio for warmth, roughly 1:1 to 1:2. Keep limbs small but long enough to hold and point.
- **Own face.** Design the eyes, brows or lids, and mouth for this character. Every candidate gets a different face construction. Eyes that never change shape cannot act; give them lids or brows that can.

## Color

- **Contrast lives in the accents.** Keep the body neutral or one quiet hue, and put two or three small saturated accents at the focal points, such as a cream body with a red crest and yellow feet. Black pupils give the strongest contrast at small sizes.
- **Belong to the canvas.** A body close to the canvas color makes the character feel native to the product, and a fully saturated body competes with the interface. A white or near-white body needs a frame on a light canvas: a mid-gray accessory, skin, or edge drawn as part of the character, such as glasses, a wrap, or a scarf. A faint outline alone disappears.
- **Brand color as costume.** Tie the character to the brand through clothing or an accessory in the brand color, such as a cap, scarf, or apron.
- **Stay on the character.** The mascot's accent colors stay on the mascot. They do not become extra accent colors for buttons, labels, or other interface parts. Paper grain, tape, and similar surface textures belong to the surfaces around the in-product mascot, not to the character.
- **Every surface.** Check it on each surface the product uses, including brand-colored tiles and dark mode. Use a defined edge or accessory, not a halo or backing plate, to keep it visible. When a signature part shares a color with a surface, give it an edge or keep the character off that surface.

## Rendering tiers

- **Style.** The user picks it by eye from a few rendered samples. Image tools render 3D toy and painted styles well and rarely make flat vector art look finished.
- **In-product art.** The chosen style, kept simple: few small details and a soft ground shadow. A flat style uses flat fills and an optional consistent mid-gray edge, and its vector version comes from a vectorizing tool or a designer, never from paths drawn in code. A rendered style ships as transparent cut-outs. Either way the full body must read at 24 px, and a simplified version, such as the head alone, at 16 px.
- **Hero rendering.** For a landing page, onboarding, or a celebration, a richer image with a full scene is allowed. Make it from the approved character as the reference, so it stays the same character.

## Acting

- **Line of action.** Every non-neutral pose has one clear curve or diagonal through the body. Avoid straight, symmetrical, front-facing poses except for the neutral idle pose.
- **Three-quarter view.** Use it for the hero pose and most acting poses. Front view is for icons and idle states.
- **Weight and timing.** Show weight through squash, stretch, lean, and overlapping parts such as a tail or ears that trail the motion.
- **Props in use.** The character holds, wears, rides, or uses the prop: it swings a lantern, waters a plant, or hugs its reward. A prop beside the character does not count.
- **Poses act out features.** Each acting pose shows a real product feature or promise. "Works offline" could be the character reading a paper map. Write the feature line first, then the pose.
- **Expression through the whole face.** Lowered lids and angled brows carry glare, doubt, and smugness. A strong glare can use the lids alone, with no mouth change.

## Staging and motion

- **Live in the layout.** The character interacts with the interface: it peeks from the edge of a card, flies across a section, breaks out of a phone frame, or watches the cursor. A short handwritten invitation beside it can invite a tap.
- **Scenes with meaning.** Hero scenes place the character somewhere that matters to the audience.
- **One signature interaction.** Choose one interaction the character is known for, tie it to user input or real progress, and give it a reduced-motion version that swaps to the end pose.

## Voice

Write interface lines, feature headlines, and empty states in the character's voice with its edge. Keep labels on essential actions plain, and let the voice live in headlines, helper text, and the character's own lines.

## Build it as a system

- Make the in-product mascot a component with a `Pose` variant property covering the expression and acting sheets.
- For vector art, draw each movable part as its own layer with its pivot at the joint: eyes, lids or brows, mouth, head, body, limbs, and tail or ears.
- For vector art, keep props as separate layers, positioned in the hand or on the body for each pose. Record which prop means which product job in the component description.
- For rendered art, each pose is its own approved image in the component, and motion comes from short animations made from those images. Record which pose and prop mean which product job in the component description.
- Keep micro-animations short, roughly 150–300 ms, and tie them to an action or real progress.
