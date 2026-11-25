#!/usr/bin/env bash
# Tests scripts/icon_sheet.py: the size sheet, the home-screen mock, the
# rounded mask, and the rejection of bad input.
# Usage: bash logo-design/tests/test-icon-sheet.sh
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
script="$here/scripts/icon_sheet.py"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
fail() { printf 'FAIL: %s\n' "$1" >&2; exit 1; }

python3 - "$work" <<'EOF'
import sys, pathlib
from PIL import Image
work = pathlib.Path(sys.argv[1])
(work / "neighbours").mkdir()
Image.new("RGB", (512, 512), (214, 59, 31)).save(work / "red.png")
Image.new("RGB", (600, 600), (28, 61, 47)).save(work / "green.png")
Image.new("RGB", (512, 400), (0, 0, 0)).save(work / "wide.png")
Image.new("RGB", (256, 256), (0, 0, 0)).save(work / "small.png")
for i in range(7):
    Image.new("RGB", (512, 512), (20 * i, 100, 200)).save(work / "neighbours" / f"n{i}.png")
EOF

python3 "$script" "$work/red.png" "$work/green.png" --out "$work/sheet.png" >/dev/null || fail "size sheet did not render"
python3 "$script" "$work/red.png" --home "$work/neighbours" --out "$work/home.png" >/dev/null || fail "home screen did not render"

python3 - "$work" <<'EOF' || exit 1
import sys, pathlib
from PIL import Image
work = pathlib.Path(sys.argv[1])
sheet = Image.open(work / "sheet.png").convert("RGB")
# two icons, a light and a dark row each, 330 px per row
assert sheet.size == (1040, 4 * 330), f"unexpected sheet size {sheet.size}"
# the 256 px rounded tile starts at (24, 48): its corner must show the ground, its centre the icon
assert sheet.getpixel((25, 49)) == (242, 242, 247), f"corner not masked: {sheet.getpixel((25, 49))}"
centre = sheet.getpixel((24 + 128, 48 + 128))
assert abs(centre[0] - 214) < 3 and abs(centre[1] - 59) < 3, f"icon colour lost: {centre}"
home = Image.open(work / "home.png").convert("RGB")
assert home.width == 24 * 2 + 4 * 60 + 3 * 27, f"unexpected home width {home.width}"
reds = sum(1 for x in range(home.width) for y in range(home.height) if home.getpixel((x, y)) == (214, 59, 31))
assert 3000 < reds < 3600, f"the option should appear once at 60 px, found {reds} red pixels"
EOF

if python3 "$script" "$work/wide.png" --out "$work/bad.png" 2>/dev/null; then fail "accepted a non-square icon"; fi
if python3 "$script" "$work/small.png" --out "$work/bad.png" 2>/dev/null; then fail "accepted an icon under 512 px"; fi

printf 'icon_sheet tests passed\n'
