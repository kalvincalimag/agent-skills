#!/usr/bin/env python3
"""Render app-icon options as a size sheet, or place them on a mock home screen.

Size sheet (default): each icon as a rounded square and a circle at 256 px,
then at 60, 40, 29 and 20 px, on a light and a dark ground.

Home screen (--home DIR): each icon in a 4-column grid of the PNG icons found
in DIR, placed in a middle slot, at real size (60 px icons).

Usage:
  python3 icon_sheet.py a.png b.png --out sheet.png
  python3 icon_sheet.py a.png --home neighbours/ --out home.png

Needs Python 3 and Pillow. Inputs must be square PNG or JPEG files of at
least 512 px.
"""
import argparse
import pathlib
import sys

from PIL import Image, ImageDraw, ImageFont

LIGHT, DARK = (242, 242, 247), (28, 28, 30)
REAL_SIZES = (60, 40, 29, 20)
CORNER = 0.2237  # share of the side used as the corner radius of an iOS-like tile


def load_icon(path):
    image = Image.open(path).convert("RGBA")
    width, height = image.size
    if width != height:
        raise ValueError(f"{path}: icon must be square, got {width}x{height}")
    if width < 512:
        raise ValueError(f"{path}: icon must be at least 512 px, got {width}")
    return image


def masked(icon, size, shape):
    """Return the icon at `size` px, cut to a rounded square or a circle."""
    scale = 4  # draw the mask large, then shrink it, for smooth edges
    big = icon.resize((size * scale, size * scale), Image.LANCZOS)
    mask = Image.new("L", big.size, 0)
    draw = ImageDraw.Draw(mask)
    box = (0, 0, big.width - 1, big.height - 1)
    if shape == "circle":
        draw.ellipse(box, fill=255)
    else:
        draw.rounded_rectangle(box, radius=round(big.width * CORNER), fill=255)
    big.putalpha(Image.composite(big.getchannel("A"), mask, mask))
    return big.resize((size, size), Image.LANCZOS)


def font(size):
    try:
        return ImageFont.truetype("DejaVuSans.ttf", size)
    except OSError:
        return ImageFont.load_default()


def size_row(icon, label, ground):
    width, height = 1040, 330
    row = Image.new("RGB", (width, height), ground)
    ink = (17, 17, 17) if ground == LIGHT else (240, 240, 240)
    ImageDraw.Draw(row).text((24, 12), label, fill=ink, font=font(18))
    row.paste(t := masked(icon, 256, "rounded"), (24, 48), t)
    row.paste(t := masked(icon, 256, "circle"), (304, 48), t)
    x = 600
    for size in REAL_SIZES:
        tile = masked(icon, size, "rounded")
        row.paste(tile, (x, 48 + 256 - size), tile)
        ImageDraw.Draw(row).text((x, 312), str(size), fill=ink, font=font(12))
        x += max(size, 40) + 36
    return row


def size_sheet(paths):
    rows = []
    for path in paths:
        icon = load_icon(path)
        label = pathlib.Path(path).stem
        rows.append(size_row(icon, label, LIGHT))
        rows.append(size_row(icon, label, DARK))
    sheet = Image.new("RGB", (rows[0].width, sum(r.height for r in rows)), LIGHT)
    y = 0
    for row in rows:
        sheet.paste(row, (0, y))
        y += row.height
    return sheet


def home_screen(path, neighbour_dir, wallpaper=(58, 72, 102)):
    icon = load_icon(path)
    neighbours = sorted(
        p for p in pathlib.Path(neighbour_dir).iterdir() if p.suffix.lower() in (".png", ".jpg", ".jpeg")
    )
    if not neighbours:
        raise ValueError(f"{neighbour_dir}: no PNG or JPEG icons found")
    columns, size, gap, margin = 4, 60, 27, 24
    slots = min(len(neighbours) + 1, 24)
    rows = -(-slots // columns)
    width = margin * 2 + columns * size + (columns - 1) * gap
    height = margin * 2 + rows * (size + gap)
    screen = Image.new("RGB", (width, height), wallpaper)
    middle = min(slots - 1, columns * (rows // 2) + 1)
    others = iter(neighbours)
    for slot in range(slots):
        if slot == middle:
            tile = masked(icon, size, "rounded")
        else:
            other = Image.open(next(others)).convert("RGBA")
            side = min(other.size)
            tile = masked(other.crop((0, 0, side, side)).resize((512, 512), Image.LANCZOS), size, "rounded")
        x = margin + (slot % columns) * (size + gap)
        y = margin + (slot // columns) * (size + gap)
        screen.paste(tile, (x, y), tile)
    return screen


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("icons", nargs="+", help="square icon images, 512 px or more")
    parser.add_argument("--out", required=True, help="output PNG path")
    parser.add_argument("--home", metavar="DIR", help="folder of neighbour icons for a home-screen mock")
    args = parser.parse_args(argv)
    try:
        if args.home:
            screens = [home_screen(path, args.home) for path in args.icons]
            out = Image.new("RGB", (sum(s.width for s in screens) + 20 * (len(screens) - 1), screens[0].height), LIGHT)
            x = 0
            for screen in screens:
                out.paste(screen, (x, 0))
                x += screen.width + 20
        else:
            out = size_sheet(args.icons)
    except (OSError, ValueError) as error:
        print(f"icon_sheet: {error}", file=sys.stderr)
        return 1
    out.save(args.out)
    print(f"icon_sheet: wrote {args.out} ({out.width}x{out.height})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
