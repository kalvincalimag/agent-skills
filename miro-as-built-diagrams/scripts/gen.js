// Generates Canvas Composer SVG frames for Miro: sequence(spec) for a sequence diagram, sheet(spec) for an endpoint table or card grid.
const esc = (s) =>
  String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
// rich text for data-content attributes: <b>, <br>, <i> allowed, then escaped
const rich = (s) => esc(s);

const C = {
  blue: { fill: "#c6dcff", stroke: "#659df2" },
  purple: { fill: "#dedaff", stroke: "#8f7fee" },
  grey: { fill: "#f7f7f7", stroke: "#e7e7e7" },
  yellow: { fill: "#fff6b6", stroke: "#ffdc4a" },
  white: { fill: "#ffffff", stroke: "#8f7fee" },
  ink: "#1a1a1a",
  body: "#595959",
  line: "#313131",
  life: "#b0b0b0",
};

const plain = (s) => s.replace(/<[^>]+>/g, "");
const linesFor = (text, width, size) => {
  const cpl = Math.max(8, Math.floor(width / (size * 0.58)));
  return text
    .split(/<br\/?>/)
    .map((p) => Math.max(1, Math.ceil(plain(p).length / cpl)))
    .reduce((a, b) => a + b, 0);
};
const textH = (text, width, size) => Math.ceil(linesFor(text, width, size) * size * 1.42);

function header(W, title, subtitle) {
  const h1 = textH(title, W - 128, 67);
  const subY = 64 + h1 + 20;
  const h2 = textH(subtitle, W - 128, 33);
  return {
    bottom: subY + h2,
    svg: [
      `<textArea x="64" y="64" width="${W - 128}" font-family="noto_sans" font-size="67" font-weight="bold" fill="${C.ink}">${esc(title)}</textArea>`,
      `<textArea x="64" y="${subY}" width="${W - 128}" font-family="noto_sans" font-size="33" fill="${C.body}">${esc(subtitle)}</textArea>`,
    ],
  };
}

function cardRow({ cards, x, y, width, gap = 32, minH = 0, size = 26, fixedH }) {
  const w = (width - gap * (cards.length - 1)) / cards.length;
  const h = fixedH || Math.max(minH, ...cards.map((c) => textH(c.text, w - 48, size) + 56));
  const svg = cards.map((c, i) => {
    const col = C[c.color || "grey"];
    return `<rect x="${x + i * (w + gap)}" y="${y}" width="${w}" height="${h}" rx="12" fill="${col.fill}" stroke="${col.stroke}" data-text-color="${C.ink}" data-font-family="noto_sans" data-font-size="${size}" data-text-align="left" data-text-align-vertical="top" data-content="${rich(c.text)}" />`;
  });
  return { svg, bottom: y + h };
}

function sequence(spec) {
  const W = spec.width;
  const GUT = spec.gutter;
  const laneW = (W - GUT - 64) / spec.lanes.length;
  const laneX = spec.lanes.map((_, i) => Math.round(GUT + laneW * i + laneW / 2));
  const late = [];
  let n = 0;
  const id = (p) => `${spec.key}${p}${n++}`;

  const head = header(W, spec.title, spec.subtitle);
  const headY = head.bottom + 64;
  const headH = 130;
  const cardW = Math.round(Math.min(340, laneW - 40));
  spec.lanes.forEach((l, i) => {
    const c = C[l.color];
    late.push(
      `<rect x="${laneX[i] - cardW / 2}" y="${headY}" width="${cardW}" height="${headH}" rx="12" fill="${c.fill}" stroke="${c.stroke}" data-text-color="${C.ink}" data-font-family="noto_sans" data-font-size="26" data-content="${rich(`<b>${l.name}</b><br>${l.sub}`)}" />`,
    );
  });

  let y = headY + headH + 48;
  const bands = [];
  spec.phases.forEach((ph, pi) => {
    const top = y;
    const titleText = `${pi + 1}. ${ph.title}`;
    const gw = GUT - 112;
    const tH = textH(titleText, gw, 33);
    const dH = textH(ph.desc, gw, 22);
    const gutterBottom = top + 32 + tH + 16 + dH + 32;
    y += 48;
    ph.steps.forEach((s) => {
      if (s.note) {
        const [a, b] = s.span || [s.lane, s.lane];
        const x0 = Math.min(laneX[a], laneX[b]) - laneW / 2 + 24;
        const w = Math.abs(laneX[b] - laneX[a]) + laneW - 48;
        const h = textH(s.note, w - 40, 22) + 40;
        const col = C[s.color || "white"];
        late.push(
          `<rect x="${Math.round(x0)}" y="${y}" width="${Math.round(w)}" height="${h}" rx="12" fill="${col.fill}" stroke="${col.stroke}" data-text-color="${C.ink}" data-font-family="noto_sans" data-font-size="22" data-content="${rich(s.note)}" />`,
        );
        y += h + 36;
        return;
      }
      const ax = laneX[s.from];
      const bx = laneX[s.to];
      const left = Math.min(ax, bx);
      const span = Math.abs(bx - ax);
      const tw = Math.round(Math.max(span - 32, laneW - 32));
      const tx = Math.round(left + span / 2 - tw / 2);
      const label = s.tech ? `${s.text}<br/>${s.tech}` : s.text;
      const brk = (t) => t.split("\n").join("<br>");
      const lH = textH(brk(s.text), tw, 22) + (s.tech ? textH(brk(s.tech), tw, 22) : 0);
      const lineY = y + lH + 12;
      if (spec.labelMask) {
        const cpl = Math.max(8, Math.floor(tw / (22 * 0.58)));
        const longest = Math.max(...[s.text, s.tech || ""].flatMap((t) => t.split("\n")).map((t) => plain(t).length));
        const mw = longest > cpl ? tw : Math.min(tw, Math.ceil(longest * 22 * 0.58) + 40);
        late.push(
          `<rect x="${Math.round(left + span / 2 - mw / 2)}" y="${y - 4}" width="${mw}" height="${lH + 8}" fill="${pi % 2 ? "#ffffff" : C.grey.fill}" stroke="#ffffffff" />`,
        );
      }
      const sa = id("a");
      const sb = id("b");
      late.push(
        `<ellipse id="${sa}" cx="${ax}" cy="${lineY}" rx="4" ry="4" fill="#ffffffff" stroke="#ffffffff" />`,
        `<ellipse id="${sb}" cx="${bx}" cy="${lineY}" rx="4" ry="4" fill="#ffffffff" stroke="#ffffffff" />`,
        `<line x1="${ax}" y1="${lineY}" x2="${bx}" y2="${lineY}" data-start="${sa}" data-end="${sb}" stroke="${C.line}" stroke-width="2" data-arrow="end" data-shape="straight" data-start-side="${bx > ax ? "right" : "left"}" data-end-side="${bx > ax ? "left" : "right"}"${s.reply ? ' stroke-dasharray="5,5"' : ""} />`,
        `<textArea x="${tx}" y="${y}" width="${tw}" font-family="noto_sans" font-size="22" text-align="center" fill="${s.reply ? C.body : C.ink}">${(s.tech ? `${esc(s.text)}<br/><i>${esc(s.tech)}</i>` : esc(s.text)).split("\n").join("<br/>")}</textArea>`,
      );
      y = lineY + 36;
    });
    y = Math.max(y + 12, gutterBottom);
    bands.push({ top, bottom: y, titleText, tH, desc: ph.desc, pi });
    y += 24;
  });
  const lifeEnd = y;

  let footer = [];
  if (spec.footer) {
    y += 40;
    footer.push(
      `<textArea x="64" y="${y}" width="${W - 128}" font-family="noto_sans" font-size="33" font-weight="bold" fill="${C.ink}">${esc(spec.footer.title)}</textArea>`,
    );
    y += 47 + 24;
    const row = cardRow({ cards: spec.footer.cards, x: 64, y, width: W - 128 });
    footer = footer.concat(row.svg);
    y = row.bottom;
  }
  const H = y + 64;

  const back = bands.flatMap(({ top, bottom, titleText, tH, desc, pi }) => [
    `<rect x="32" y="${top}" width="${W - 64}" height="${bottom - top}" rx="12" fill="${pi % 2 ? "#ffffff" : C.grey.fill}" stroke="${C.grey.stroke}" />`,
    `<textArea x="64" y="${top + 32}" width="${GUT - 112}" font-family="noto_sans" font-size="33" font-weight="bold" fill="${C.ink}">${esc(titleText)}</textArea>`,
    `<textArea x="64" y="${top + 32 + tH + 16}" width="${GUT - 112}" font-family="noto_sans" font-size="22" fill="${C.body}">${esc(desc)}</textArea>`,
  ]);
  const lifelines = laneX.map(
    (x) =>
      `<line data-type="divider" x1="${x}" y1="${headY + headH}" x2="${x}" y2="${lifeEnd}" stroke="${C.life}" stroke-width="2" data-line-style="dashed" />`,
  );

  return {
    W,
    H,
    svg: [
      `<g id="${spec.key}F" transform="translate(${spec.x},${spec.y})" data-frame="${esc(spec.frame)}">`,
      `<rect data-type="frame" x="0" y="0" width="${W}" height="${H}" fill="#ffffff" />`,
      ...head.svg,
      ...back,
      ...lifelines,
      ...late,
      ...footer,
      `</g>`,
    ].join("\n"),
  };
}

// A reference sheet: header, then sections of rows (table-like) or card grids.
function sheet(spec) {
  const W = spec.width;
  const head = header(W, spec.title, spec.subtitle);
  let y = head.bottom + 48;
  const out = [...head.svg];
  spec.sections.forEach((sec) => {
    out.push(
      `<textArea x="64" y="${y}" width="${W - 128}" font-family="noto_sans" font-size="33" font-weight="bold" fill="${C.ink}">${esc(sec.title)}</textArea>`,
    );
    y += 47 + 20;
    if (sec.cards) {
      const per = sec.perRow || 3;
      for (let i = 0; i < sec.cards.length; i += per) {
        const chunk = sec.cards.slice(i, i + per);
        while (chunk.length < per) chunk.push(null);
        const real = chunk.filter(Boolean);
        const gap = 32;
        const w = (W - 128 - gap * (per - 1)) / per;
        const row = cardRow({ cards: real, x: 64, y, width: real.length * w + gap * (real.length - 1), size: sec.size || 24, fixedH: spec.cardH });
        out.push(...row.svg);
        y = row.bottom + 24;
      }
      y += 24;
      return;
    }
    // table-like rows: column labels, then rows with a method pill in the first column
    {
      let x = 64;
      spec.columns.forEach((c) => {
        out.push(
          `<textArea x="${x + 16}" y="${y}" width="${c.w - 32}" font-family="noto_sans" font-size="22" font-weight="bold" fill="${C.body}">${esc(c.title)}</textArea>`,
        );
        x += c.w;
      });
      y += 56;
    }
    sec.rows.forEach((r, ri) => {
      const cols = spec.columns;
      let x = 64;
      const hs = cols.map((c, ci) => (ci === 0 ? 48 : textH(r[ci], c.w - 32, 22)));
      const h = Math.max(...hs) + 36;
      out.push(
        `<rect x="64" y="${y}" width="${W - 128}" height="${h}" rx="12" fill="${ri % 2 ? "#ffffff" : C.grey.fill}" stroke="${C.grey.stroke}" />`,
      );
      cols.forEach((c, ci) => {
        if (ci === 0) {
          const col = r[0] === "GET" ? C.blue : C.purple;
          out.push(
            `<rect x="${x + 16}" y="${y + 18}" width="${c.w - 32}" height="48" rx="24" fill="${col.fill}" stroke="${col.stroke}" data-text-color="${C.ink}" data-font-family="noto_sans" data-font-size="22" data-font-weight="bold" data-content="${esc(r[0])}" />`,
          );
        } else {
          out.push(
            `<textArea x="${x + 16}" y="${y + 18}" width="${c.w - 32}" font-family="noto_sans" font-size="22" fill="${ci === 1 ? C.ink : C.body}"${ci === 1 ? ' font-weight="bold"' : ""}>${esc(r[ci])}</textArea>`,
          );
        }
        x += c.w;
      });
      y += h + 12;
    });
    y += 36;
  });
  if (spec.notes) {
    const row = cardRow({ cards: spec.notes, x: 64, y, width: W - 128, size: 24 });
    out.push(...row.svg);
    y = row.bottom;
  }
  const H = y + 64;
  return {
    W,
    H,
    svg: [
      `<g id="${spec.key}F" transform="translate(${spec.x},${spec.y})" data-frame="${esc(spec.frame)}">`,
      `<rect data-type="frame" x="0" y="0" width="${W}" height="${H}" fill="#ffffff" />`,
      ...out,
      `</g>`,
    ].join("\n"),
  };
}

module.exports = { sequence, sheet, esc, C };
