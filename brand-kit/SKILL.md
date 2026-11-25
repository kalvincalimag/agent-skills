---
name: brand-kit
description: Use when making or judging a product's first impression from its mascot or signature object - the logo and app icon, the launch screen, the first-open welcome scene, and the short onboarding story with the mascot's first greeting. Asks for the mascot's master art and the apps the user admires, then produces a square mark people recognise at 20 px, launch and welcome screens that meet Apple and Android rules, and a wordless mascot moment that leads into the real product without a tour. Covers colour choice against the market and rivals, making art from the master instead of drawing it in code, a size sheet and home-screen test, and labelled options for the user to pick. Not for designing the mascot character itself, which is `mascot-design`, or for the product's everyday screens.
---

# Brand kit

A new app is remembered by its character, its icon and its first minute. This skill makes those pieces as one set, from one source: the mascot. The mark comes first, and every other piece is built from it.

Judge every piece by what a stranger keeps after one look: can they find the icon on a crowded home screen, name the app a minute later, and say what the character is like? Checks only find problems. The user decides by looking.

Read the reference for each piece before making it:
- [references/mark.md](references/mark.md): the logo, app icon and its colour.
- [references/launch.md](references/launch.md): the launch screen and the first-open welcome scene.
- [references/onboarding.md](references/onboarding.md): the mascot story and the first greeting.
- [references/platforms.md](references/platforms.md): Apple and Android rules, before anything ships.
- [references/review.md](references/review.md): tests and presenting, before showing anything.

## Ask first

Before drawing, gather these. Check the project's notes first and ask only for what is missing.

1. **The source.** The mascot's master image and its approved poses. With no mascot, offer `mascot-design` to make one, or use the product's single most specific object.
2. **The name**, and whether the mascot shares it.
3. **Colours and type** the product already uses, especially its accent.
4. **Two or more apps the user admires,** with store screenshots of their icon, launch screen and onboarding. Ask what they like in each.
5. **Target markets and direct rivals,** for the colour and rival checks.
6. **Platforms:** iPhone, Android, web.
7. **Earlier decisions** that bind the work, such as "no tour", a fixed accent, or a rejected colour.

## The set

| Piece | What it is | Shown |
| --- | --- | --- |
| Mark | The mascot's face as a flat square symbol | App icon, profile pictures, favicon |
| Silhouette | The mark in one colour | Tinted and themed icons, notifications |
| Wordmark | The name in a chunky rounded display face, used only for the name | Welcome scene, store art, website |
| Lockup | Mark beside the wordmark | Only where there is width |
| Launch screen | The mark on its field, no text | Every app start |
| Welcome scene | The mascot in its world, the wordmark, one short line | First open only, and store art |
| Mascot story | Two to four wordless beats | First open only, skippable |
| Greeting | The mascot says hello once, by name | The first real screen |

## Order of work

1. **Mark.** Settle it before anything else ([mark.md](references/mark.md)). Every other piece reuses it.
2. **Launch screen,** derived from the mark ([launch.md](references/launch.md)).
3. **Welcome scene and wordmark** ([launch.md](references/launch.md)).
4. **Mascot story** ([onboarding.md](references/onboarding.md)).
5. **Greeting** on the first real screen ([onboarding.md](references/onboarding.md)).

Show the user each piece and get a pick before building the next one on top of it.

## Rules across the set

- **One source.** All art comes from the mascot's master or its approved poses, through an image-editing model or an illustrator. Never generate the character from a text prompt alone, and never present shapes an agent drew by coordinates as finished art.
- **Borrow methods, not looks.** Take what makes the admired apps work, such as the crop, the shape count, or a wordless story, and leave their composition, palette, habitat and story beats. Someone who knows the reference must not mistake the product for it.
- **The product's own world.** The welcome scene and story come from the product's own origin and subject, not a reference's setting.
- **The name stays visible** everywhere outside the home screen and the launch screen. Most downloads follow a search, and people recommend apps by name.
- **No pressure.** No sign-up, permission request or paywall inside the welcome or the story.
- **Label every tile** in a comparison, and say which are references, earlier versions and new options.

## Lessons that cost a round each

- Settle what each piece must do before drawing variations. Many rounds of name-first splash screens were wasted on a premise the user then rejected.
- A wide lockup is not the logo. If it cannot be a profile picture, it is not the mark.
- Code-drawn vector art was judged amateur next to professional icons. Make the art from the master.
- An image prompt that says "keep the character identical" keeps every detail, and the result reads as clip art. Ask for reduction: the face only, about five shapes, three or four colours, no inner lines.
- A launch screen with text breaks Apple's rule, and on Android it repeats the system splash. Put the name in the first-open welcome instead.
- When a message is unclear, for example a voice message with misheard words, treat it as a question. Never apply a choice the user did not clearly make.
- Before starting parallel work, check what other sessions have already done. A whole round of options was wasted because another session had already moved the work on.
- Record a piece as approved only from the user's own words in the current conversation. Another session's notes saying it was approved are not approval: a mark was recorded as approved that the user had never seen.
- Copying an admired app's onboarding beats makes the product look like its clone. Tell the product's own story.

## Done when

- The mark is square, survives a round crop, reads at 20 px, passes the market and rival checks, and was chosen from labelled options.
- The silhouette, launch screen, wordmark and lockup are built from the mark, and the platform rules are met.
- The welcome scene and the story show the mascot in the product's own world, can be skipped, and end on the real product.
- The mascot greets the user once, by name.
- A fresh reviewer tried to break each piece, and the user picked every one.
