---
name: logo-design
description: Use when designing, redesigning, or judging a product's logo, especially an app's: the app icon, a social profile picture, a favicon, the launch screen, and the wordmark and lockups that go with them. Strongest when the product has a mascot, whose face becomes a flat mark that people recognise at 20 px. Covers what a logo must do, the character-mark method, colour choice against the target market and rivals, platform rules for icons and launch screens, a real-size sheet, a home-screen test, and how to present options. Not for designing the mascot character itself, which is `mascot-design`, or for whole screens.
---

# Logo design

For an app, the logo is the square mark. People see it every day at 20 to 60 points on a crowded home screen, beside their friends' apps, and that is where they learn it. A wide lockup, a wordmark and a launch screen are other pieces of the same set, and each is built from the mark.

Judge every option by one question: on a real home screen, among the most popular apps of the target market, can someone find it in a glance and say what it is a minute later? Legibility checks only find problems. The user decides by looking.

Read [references/platforms.md](references/platforms.md) before drawing anything that ships, and [references/review.md](references/review.md) before presenting.

## What people remember

- **A character beats a colour.** In an Ipsos and JKR study of over 26,000 people (2023), 16% of mascots tested were "truly distinctive", against 4% of brand colours. Logos scored 19% and products 31% ([source](https://www.ipsos.com/en-uk/be-distinctive-everywhere)). A colour becomes memorable only through a huge brand's fame, or when it is fixed to a shape.
- **The name still matters.** Most app-store downloads follow a search, and people recommend apps by name. Keep the name beside the mark everywhere outside the home screen: store listing, store art, website, social posts. When the character and the product share a name, every sighting teaches both.
- **A mascot's 3D render or full body is not a logo.** It turns into a blob below 40 px. The mark is a flat simplification of the character's face.

## The set

| Piece | Shape | Used for |
| --- | --- | --- |
| Mark | Square, survives a round crop | App icon, profile pictures, favicon |
| Silhouette | One colour, from the mark | Tinted and themed icons, notifications |
| Wordmark | The name in one typeface | Store art, website, documents |
| Lockup | Mark beside the name | Only where there is width: site header, banners |
| Launch screen | The mark on its field, no text | Every app start |
| Welcome | An optional animation with the name | Once, on first open, and in store art |

Never call a wide lockup "the logo". If an option is too wide for a profile picture, it is not the mark.

## The character mark

The best small-app character icons share one method. Borrow the method, never a reference's composition, palette or feature set.

1. **Face, not body.** Crop so the face fills the tile and bleeds off at least one edge. A face rising from the bottom edge, or filling the tile edge to edge, reads at any size. Leave out props, unless the prop is the defining trait.
2. **One defining trait, exaggerated.** Ask what a child would draw to show it is this character, such as huge eyes, a comb and wattle, ears, or a hood. Make that the largest shape after the face.
3. **Flat primitives.** Build it from circles, pills, rounded rectangles and one or two custom curves: about 5 to 9 shapes in all. No gradients, textures, 3D shading, thin lines or outlines that vanish at 29 px.
4. **Two to four colours.** Either the field is the character's own body colour, so the tile becomes the character, or the field is the brand colour and the character sits on it in one light colour.
5. **The interface accent inside the mark.** Repeat the app's own accent colour in the mark, so the icon and the app read as one product.
6. **Life with almost nothing.** Give the eyes a gaze direction and one highlight notch, tilt the face a few degrees, or make it slightly asymmetric. A dead-centre symmetric face reads as a symbol, not a character.
7. **No text.** No letters, initials or name in the mark. A letter in a square is the most generic mark there is.

Without a mascot, the same rules apply to the product's one most specific object: one bold flat shape, cropped large, in two to four colours.

## Colour

- Choose the field colour against the market, not in isolation:
  - Count how many of the target market's top 100 apps, overall and in the category, use a close colour.
  - Check every direct rival's icon, and keep a clear distance from it. Measure ΔE00 (a standard colour difference; about 10 or less reads as the same colour apart).
  - Check the colour's cultural and political meaning in each launch country.
- Check contrast between each key shape and the field. Aim for 3:1 or more for the defining trait and the eyes. Check that red and green shapes survive red-green colour blindness.
- When the character's own colours sit close to the field, add a thin light outline or change the field. Do not let the defining trait melt into the background.

## Process

1. **Gather.** The character's master image, the product's colours and type, two or more reference icons the user likes (store screenshots are fine), the target market's top charts, and the direct rivals' icons. Check the project's notes for past choices and rejections first.
2. **Name the reference qualities.** Measure them: the number of shapes, the colours and their share, the crop, the tilt, and what the field represents. Write them down as the brief.
3. **Find the defining trait.** List the character's features and pick one or two that alone say "this character".
4. **Sketch four to six compositions,** varying composition, not only colour: peek from an edge, the tile as the face, the defining trait alone, a tilted close-up. Keep the mascot's own colours. Quick code sketches (SVG) are fine for testing crop, size and colour, but never present them as the mark: shapes an agent places by coordinates look amateur beside professional icons.
5. **Make the real art from the character's master,** with an image-editing model and the master image as its source, one composition per run, or with a human illustrator. Never generate the character from a text prompt alone, which drifts off-model.
   - **Ask for reduction, not fidelity.** A prompt that says "keep the character identical" and lists every feature keeps every feature, and the result reads as a clip-art sticker. Ask for the reference qualities instead: the face only, front-facing and symmetric, filling the square and running off one edge; about five big flat shapes; three or four colours; no inner lines, veins, brows, blush or extra props unless one is the defining trait.
   - **Run each prompt on two models and compare.** Models differ in how well they follow a crop: one kept wide margins while another filled the tile.
   - **Vectorize the chosen image,** for example with Figma's Vectorize. Then snap its colours to the brand's exact values, merge stray tones into flat fills, name the layers, and make the mark a component. Build the app icon, the silhouette and the launch screen from that component.
6. **Size sheet.** Render each option at 1024, 180, 60, 40, 29 and 20 px, in a rounded square and a circle. Use [scripts/icon_sheet.py](scripts/icon_sheet.py). Drop any option that fails at 29 px.
7. **Market check.** Run the colour counts and the rival check above on the survivors.
8. **Home-screen test.** Place each survivor in a grid of the market's most popular real icons ([review.md](references/review.md)).
9. **Fresh review.** A reviewer who did not design the options tries to break them ([review.md](references/review.md)).
10. **Present.** Show the options side by side with a label on every tile, and say which tiles are new and which are references. Give one recommendation and the single decision the user must make.

## Lessons that cost a round each

- Settle what the logo must do before drawing variations. Many rounds of name-first splash screens were wasted on a premise the user then rejected: the logo had to be a square mark that leads with the mascot.
- A launch screen is not a branding stage. Apple asks for no text on it, and Android 12+ shows its own icon splash first. A text splash after it is a duplicate the user sits through on every start.
- A recommendation that splits "logo" and "launch screen" into unrelated designs looks inconsistent. Derive both from one mark.
- When a message is unclear, for example a voice message with misheard words, treat it as a question. Never apply a choice the user did not clearly make.
- Agent-drawn vector sketches were judged "drawn by an 8th grader on MS Paint". Make the art from the master with an image model or an illustrator, and keep code drawings for layout tests.
- Edits of a detailed 3D master that asked to keep the character identical came back as stickers with brows, mouths and veins. A second round on the master that asked for the references' qualities (face only, about five shapes, three or four colours, no inner lines) gave the approved mark, and vectorizing it and snapping it to the brand colours finished it.
- A comparison image needs a label on every tile. Unlabelled "before" tiles confused the user about what was new.

## Done when

- The mark is square, survives a round crop, and reads at 20 px.
- It shows the character's face with its defining trait, in flat shapes and two to four colours, with no text.
- It passes the market colour check and the rival check, and it was seen on a realistic home screen.
- The silhouette, launch screen and lockup are derived from it, and the platform rules in [platforms.md](references/platforms.md) are met.
- A fresh reviewer tried to break it, and the user chose it from labelled options.
