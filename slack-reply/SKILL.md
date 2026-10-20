---
name: slack-reply
description: Draft a casual, short Slack reply when the user pastes a Slack message/thread, invokes this skill by name, or asks how to respond on Slack.
---

# Slack reply

## Hard boundary

Slack is **read-only** for this skill.

- A connected Slack tool may only read messages and thread context.
- Never send, post, reply, react, edit, delete, or call any Slack write/mutation action.
- If the user says "reply", "send", or similar, draft it in chat only.
- The only output is suggested reply text for the user to copy/paste.

## Voice

- Casual, human, concise.
- Default to 1–3 sentences; one if enough.
- Match their tone and answer the actual ask directly.
- No corporate filler, mini-essays, or unnecessary explanation.

## Process

1. Get the message. If the user pasted it, use that. If they gave a link and Slack is connected, read the latest message, then only enough thread context to understand it. If Slack isn't connected, ask them to paste the thread or connect Slack.
2. Answer the actual question, blocker, or ping — not every side comment.
3. If something is open, state the next step plainly.
4. If resolved, acknowledge it briefly without reopening it.

## Output

Lead with one copy-pasteable Slack reply in chat. No preamble.

Add a second option only when there are genuinely two useful tones. If context is insufficient, ask one short question instead of guessing.

**Never deliver the message to Slack.**
