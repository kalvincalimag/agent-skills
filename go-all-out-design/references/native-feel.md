# Native feel

Read this before building or reviewing any phone screen. Apply it in full when the user asks for a product to feel at home on a platform, such as "make it feel like an iPhone app" or "it still feels like Android".

People trust what looks like the rest of their phone. A screen built from the platform's own patterns is understood faster and reads as finished. Keep identity in a few signature elements, and let everything else follow the platform.

## Follow the platform's patterns

1. **Titles.** Large, bold page titles that shrink into the navigation bar on scroll. Sheet titles are smaller, with a close control beside them.
2. **Grouped lists.** Settings, options and actions sit in inset groups: rounded groups on the canvas, rows about 44 px tall, thin dividers inset from the row's text, a value in secondary text on the right, and a › only on rows that open something. Small section headers sit above each group, outside it.
3. **Navigation buttons.** Back, next and share are plain glyphs with a 44 × 44 px tap target, never glyphs inside white circles.
4. **Sheets.** Menus, options and short tasks open as sheets attached to the bottom edge, full width, with rounded top corners, a grab handle and a round close control. Do not float a card in the middle of the screen for these.
5. **Switches, checkboxes and pickers.** Use the platform's own switch, the round checkbox of a to-do list, and its date and time pickers, styled with the product's accent only where the platform allows.
6. **System tones.** Use the platform's system greys as named tokens for the canvas, control fills, dividers and secondary text, rather than custom near-greys. On iOS these are about `#F2F2F7` for the grouped canvas, `#E5E5EA` and `#D1D1D6` for fills on the canvas, `#C6C6C8` for dividers, `#C7C7CC` for grab handles and chevrons, `#6C6C70` for accessible secondary text, and `#34C759` for a switch that is on. On Android, use the Material equivalents.
7. **Date strips and calendars.**
   - A week strip shows the day letter over the date. The chosen day is a filled circle, today is the date in the accent colour, and small dots mark days with content.
   - Views of several weeks show the weekday letters once, above all the rows.
   - A month view is a plain grid of numbers. Days outside the range are light grey.
   - Do not draw rings, pictures or connecting lines inside calendar cells.

## Match the control to the choice

| The choice | The control |
| --- | --- |
| One of two or three short options | Segmented control |
| One of several options that need a description | List with a check mark on the chosen row |
| Several at once | Chips that toggle |
| On or off | Switch |
| A number with a small range | Stepper, with typing as a fallback |

## Keep the signature

Some custom elements carry the product's identity, such as a distinctive tab bar, a material tile or a mascot. Keep the ones the user likes. Before replacing a signature element with the stock platform version, show both and ask. Users often call the stock version generic.

A custom element must still be finished to system quality. For example, a custom main action button gets layered soft shadows, a crisp glyph and a tap target of at least 44 px. Never use a flat disc inside a ring.

## One codebase, two platforms

When one codebase serves both platforms, ask the user which feel to follow, then apply it consistently. Do not mix iOS and Android patterns on one screen.

## Check

- Every list, sheet, switch, segmented control and navigation button follows the patterns above, or the record names the reason.
- No menu or option list floats mid-screen.
- Each choice uses the control from the table.
- Signature elements were kept or replaced only with the user's approval.
