# Testing and reviewing marks

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

## Fresh adversarial review

Give a reviewer who did not design the options:
- the size sheets and home-screen grids, without your rationale or your favourite;
- the user's reference icons and anything they rejected;
- the platform rules in [platforms.md](platforms.md).

Ask them to:
- find any option that fails at 29 px or in the round crop;
- name anything that looks like a reference or a rival, comparing palette, composition and features side by side;
- name anything that reads as a generic symbol rather than this character;
- check contrast and colour blindness for the defining trait and the eyes;
- check every rule in "The character mark" in the main skill.

Fix what they find before presenting. If no fresh reviewer is available, say so.

## Presenting

- Put the options side by side at the same size, each with a label on its tile.
- Show each option three ways: large, as a profile-picture circle, and at real sizes. Add the home-screen grid for the finalists.
- Say which tiles are references or earlier versions and which are new.
- Give one recommendation, the reason in one line, and the single decision the user must make.
- Record the user's pick and their reasons in the project's notes. Record rejected options too, so later rounds do not repeat them.
