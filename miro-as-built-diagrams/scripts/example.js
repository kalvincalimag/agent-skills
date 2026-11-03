// A worked example: a two-phase sign-up flow plus its endpoint sheet. Copy this file, replace the spec with facts
// read from the code, then run `node example.js` from this folder. It writes example.svg next to it.
const fs = require("fs");
const { sequence, sheet } = require("./gen.js");

const X = 0;
const Y = 0;
const WIDTH = 3000;

const flow = sequence({
  key: "e",
  frame: "Account Sign-up (as built)",
  x: X,
  y: Y,
  width: WIDTH,
  gutter: 560,
  labelMask: true,
  title: "How a customer signs up",
  subtitle: "The Sign up page. Plain English first; the route sits in italics under each arrow.",
  lanes: [
    { name: "Customer", sub: "Person in the browser", color: "blue" },
    { name: "Web app", sub: "Our website", color: "purple" },
    { name: "API", sub: "Our server", color: "purple" },
    { name: "Database", sub: "Where we save things", color: "purple" },
    { name: "Email provider", sub: "Sends the email", color: "blue" },
  ],
  phases: [
    {
      title: "Create the account",
      desc: "Anyone can do this. One account per email address.",
      steps: [
        { from: 0, to: 1, text: "Enters an email and a password" },
        { from: 1, to: 2, text: "Create the account", tech: "POST /accounts" },
        { note: "Checks the email isn't taken", lane: 2 },
        { from: 2, to: 3, text: "Saves the account, unconfirmed" },
        { from: 2, to: 4, text: "Sends the confirmation email" },
        { from: 2, to: 1, text: "Account made", reply: true },
      ],
    },
    {
      title: "Confirm the email",
      desc: "The link works once, for 24 hours.",
      steps: [
        { from: 0, to: 1, text: "Opens the link in the email" },
        { from: 1, to: 2, text: "Confirm", tech: "POST /accounts/confirm" },
        { from: 2, to: 3, text: "Marks the account confirmed" },
        { from: 1, to: 0, text: "Shows the dashboard", reply: true },
        { note: "An unconfirmed account is deleted after 7 days.", span: [0, 4], color: "yellow" },
      ],
    },
  ],
});

const endpoints = sheet({
  key: "f",
  frame: "API Endpoints: Sign-up (as built)",
  x: X + WIDTH + 155,
  y: Y,
  width: 2400,
  title: "What sign-up calls",
  subtitle: "Every path starts with /api. Sections follow the page.",
  columns: [
    { title: "Method", w: 160 },
    { title: "Path", w: 760 },
    { title: "What it does", w: 980 },
    { title: "Who can call", w: 372 },
  ],
  sections: [
    { title: "1. Create the account", rows: [["POST", "/accounts", "Makes an unconfirmed account and sends the email.", "Anyone"]] },
    { title: "2. Confirm the email", rows: [["POST", "/accounts/confirm", "Confirms the account with the emailed code.", "Anyone with the code"]] },
  ],
});

const wrap = (...mods) => `<svg xmlns="http://www.w3.org/2000/svg">\n${mods.map((m) => m.svg).join("\n")}\n</svg>`;
fs.writeFileSync("example.svg", wrap(flow, endpoints));
console.log({ flow: [X, Y, flow.W, flow.H], endpoints: [X + WIDTH + 155, Y, endpoints.W, endpoints.H] });
