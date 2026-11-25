# Testing and reviewing the set

## Size sheet

Render every option before showing it to anyone:

```bash
python3 scripts/icon_sheet.py option-a.png option-b.png --out sheet.png
```

The script takes square PNGs of 512 px or more, and draws each one as a rounded square and a circle at 256 px, then at 60, 40, 29 and 20 px, on light and dark grounds, with the file name as its label. It needs Python 3 with Pillow.

At 29 and 20 px, ask two things. Can you still see the defining trait? Can you still tell it is a face? Drop any option where either answer is no.

## Home-screen test

1. Collect the icons of the 20 to 23 most popular apps in the target market, from its top charts. Include the category leaders and every direct rival.
2. Lay them out in a 4-column grid with the option in a middle slot, on a typical wallpaper:

   ```bash
   python3 scripts/icon_sheet.py option-a.png --home neighbours/ --out home-a.png
   ```

3. Look at it at real phone size, not zoomed. The option must be findable in about a second, and it must not read as a sibling of any neighbour.
4. For proof, show 8 to 10 people the grid for 5 seconds. Ask "which app is for <the product's job>?", then a minute later "what was it called?". Run once per finalist.

## Launch and welcome test

- Put the launch screen next to the Android system splash with the same colour and icon. They must look the same, with no text, and the mark must not read as a head cut off at the neck.
- Open the welcome scene cold, with no explanation, and ask a fresh viewer for their first look in their own words: what is this app, and what is the character like? Both answers must be right without help.
- Count the words on the welcome scene. The name and one short line are enough.

## Onboarding test

- Count the taps from opening the app to the real product: four or fewer through the story, and one through Skip.
- Check that Skip is visible on every beat and reachable first with a screen reader.
- Count the words in the story. The beats are wordless; only the hint and Skip have text.
- Check that the story ends on real or sample content, and that the greeting appears once, by the mascot's name.
- Compare the beats side by side with every admired app's onboarding. No beat may repeat a reference's beat.

## Fresh adversarial review

Run one per piece: the mark, the launch and welcome screens, and the story. Give a reviewer who did not design the options:
- the size sheets, home-screen grids and screen exports, without your rationale or your favourite;
- the user's reference apps (icon, launch and onboarding screenshots) and anything they rejected;
- the platform rules in [platforms.md](platforms.md).

Ask them to:
- find any option that fails at 29 px or in the round crop;
- name anything that looks like a reference or a rival, comparing palette, composition and features side by side;
- name anything that reads as a generic symbol rather than this character;
- check contrast and colour blindness for the defining trait and the eyes;
- check every rule in "The character mark" in [mark.md](mark.md).

Fix what they find before presenting. If no fresh reviewer is available, say so.

## Presenting

- Put the options side by side at the same size, each with a label on its tile.
- Show each option three ways: large, as a profile-picture circle, and at real sizes. Add the home-screen grid for the finalists.
- Say which tiles are references or earlier versions and which are new.
- Give one recommendation, the reason in one line, and the single decision the user must make.
- Record the user's pick and their reasons in the project's notes. Record rejected options too, so later rounds do not repeat them.
