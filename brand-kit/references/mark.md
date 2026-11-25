# The mark: logo and app icon

For an app, the logo is the square mark. People see it every day at 20 to 60 points on a crowded home screen, beside their friends' apps, and that is where they learn it. Judge every option by one question: on a real home screen, among the most popular apps of the target market, can someone find it in a glance and say what it is a minute later?

## What people remember

- **A character beats a colour.** In an Ipsos and JKR study of over 26,000 people (2023), 16% of mascots tested were "truly distinctive", against 4% of brand colours. Logos scored 19% and products 31% ([source](https://www.ipsos.com/en-uk/be-distinctive-everywhere)). A colour becomes memorable only through a huge brand's fame, or when it is fixed to a shape.
- **The name still matters.** Most app-store downloads follow a search, and people recommend apps by name. When the character and the product share a name, every sighting teaches both.
- **A mascot's 3D render or full body is not a logo.** It turns into a blob below 40 px. The mark is a flat simplification of the character's face.

## The character mark

The best small-app character icons share one method. Borrow the method, never a reference's composition, palette or feature set.

1. **A symbol built from the character, not a crop of it.** The admired character icons are designed shapes taken from the character's defining traits, such as ring eyes inside an ear outline, or a comb, beak and wattle as three pills. They are not a zoomed crop of the character's illustration. A user rejected cropped portraits of a mascot as "forcing a mascot to be a logo". The mark must work as a badge: a profile picture, a favicon, a pin. Leave out the body and props, unless a prop is the defining trait.
2. **One defining trait, exaggerated.** Ask what a child would draw to show it is this character, such as huge eyes, a comb and wattle, ears, or a hood. Make that the largest shape after the face.
3. **About five big flat shapes.** Near-perfect circles, pills and a few clean curves. No gradients, textures, 3D shading, inner lines, or details that vanish at 29 px.
4. **Three or four colours.** Either the field is the character's own body colour, so the tile becomes the character, or the field is the brand colour and the character sits on it in one light colour.
5. **The interface accent inside the mark.** Repeat the app's own accent colour, so the icon and the app read as one product.
6. **Life, not an ID photo.** A face that is centred, front-facing and symmetric, head and shoulders, reads like a passport photo, and a user rejected exactly that as uncreative. Give it life: an off-centre crop that runs off an edge, a tilt, a wink or a gaze. Eyes with one highlight each.
7. **No text.** No letters, initials or name in the mark.
8. **Check the outline alone.** Fill the mark's silhouette in one colour and look at it small and upside down. A tall rounded dome over a round base can read as a phallus; a user saw exactly that. Widen the top, tilt it, or break the outline with the crop.
9. **Stay close to the character.** Put the mark beside the master at the same size. The defining traits must match its real shapes, such as a hood that drapes wide rather than a pointed cap.
10. **Keep the character, not a stand-in.** A user rejected a lettermark built from the character's signature trait, and an everyday object given the character's face. Both lose who the character is.
11. **Expressions as designed shapes, not emoji.** A wink drawn as a ">" chevron, or a ":)" smile, reads as a stock emoji and owns nothing. Use a shape the character owns, such as a curved closed-eye arc in the same weight as the open eye.
12. **Simple is not the same as plain.** A user rejected flat geometric reductions that kept only a hood and two eye marks as "plain and ugly and uncreatively boring", and rejected a monoline version as a logo style. Keep the character's personality: its expression, its signature trait drawn with character, and at least one surprising detail.
13. **Zoom in like the references, but keep the face whole.** Admired character icons are framed tight, so the tile edges cut the head. Crop so the defining trait and the expression stay in view: a crop that cut off half the mouth was rejected.
14. **Stay in the character's palette.** Greens brighter or more saturated than the master's read as a different character to a user. Sample the master's colours and give them to the generator as exact values.

Without a mascot, the same rules apply to the product's one most specific object: one bold flat shape, cropped large, in three or four colours.

## Colour

- Choose the field colour against the market, not in isolation:
  - Count how many of the target market's top 100 apps, overall and in the category, use a close colour.
  - Check every direct rival's icon, and keep a clear distance from it. Measure ΔE00 (a standard colour difference; about 10 or less reads as the same colour apart).
  - Check the colour's cultural and political meaning in each launch country.
- **Keep the field clean and bright.** A muted beige, cream or parchment field made otherwise good marks feel less clean, premium and enticing to a user. Prefer white or a near-white neutral, or one confident brand colour, and judge the field on the home-screen test, not on its own.
- Check contrast between each key shape and the field. Aim for 3:1 or more for the defining trait and the eyes. Check that red and green shapes survive red-green colour blindness.
- When the character's own colours sit close to the field, add a thin light outline or change the field.

## Making it

1. **Name the reference qualities.** Measure the admired icons: the number of shapes, the colours and their share, the crop, the symmetry, and what the field represents. Write them down as the brief.
2. **Find the defining trait.** List the character's features and pick one or two that alone say "this character".
3. **Test compositions quickly.** Code sketches (SVG) are fine for testing crop, size and colour, but never present them as the mark: shapes placed by coordinates look amateur beside professional icons.
4. **Make the art from the master,** with an image-editing model and the master image as its source, one composition per run, or with a human illustrator.
   - **Ask for reduction, not fidelity.** A prompt that lists every feature and says "keep the character identical" keeps every feature. Ask for the reference qualities instead: the face, tilted or turned three-quarter with an expression (rule 6), filling the square and running off one edge; about five big flat shapes; three or four colours; no inner lines, veins, brows, blush or extra props unless one is the defining trait.
   - **Write a construction spec when the tool drifts toward illustration.** Character tools add the mascot's reference to every run, and their style presets often ask for a portrait crop, organic curves or soft shading. Describe the composition as numbered shapes, each with its size as a share of the canvas, its position and its colour. Replace the preset's style text with a custom one: flat geometric shapes, an opaque background filling the canvas, no outlines, shading or texture. Tell it to take only the defining traits from the reference and ignore its rendering, proportions and clothing. This turned cropped illustrations into a designed mark after single-box prompts had failed for several rounds.
   - **Ask for an opaque background explicitly.** Some presets default to transparency, and a result can come back with no field, or with a checkerboard drawn into the pixels.
   - **Run each prompt on two models and compare.** Models differ in how well they follow a crop: one may keep wide margins while another fills the tile.
   - Offer two or three variants of a single choice the user cares about, such as a wink or open eyes, or one field colour or another.
5. **Vectorize the chosen image,** for example with Figma's Vectorize. Snap its colours to the brand's exact values, merge stray tones into flat fills, name the layers, and make the mark a component.
6. **Build the set from the component:** the iOS 1024 px icon (opaque, square corners), the Android adaptive foreground with its bleed, a solid background layer, the store icon, the one-colour silhouette, and dark and tinted versions.
7. **Test and present** as [review.md](review.md) describes: the size sheet, the market check, the home-screen test, a fresh review and labelled options.
