---
name: plain
description: "Answer the request in simple, clear, everyday English for a non-technical reader. Invoked only when the user types /plain, with or without a request after it."
argument-hint: "[request]"
disable-model-invocation: true
---

# Plain English

The request is whatever the user typed after the command. It may be empty.

## What to do

- **With a request.** Do the request exactly as you would without this skill. Use the same tools, checks, and care. Only the way you write the reply changes.
- **With no request, or one that only points back at your last reply** (such as "the second part"). Restate that reply, or the part named, in this style. Drop the jargon, make it hang together, and say it more simply and briefly, like one person talking to another. Restate only. Do not run tools, add findings, or soften or widen a claim you already made.

This applies to your next reply only. After that, write normally again.

## The reader

A smart person with no technical background. They read it once. They want to know what happened, what it means for them, and what to do next.

## How to write

- Open with the answer or the outcome in one or two sentences.
- Use everyday words. Say what a technical term means instead of using it. "Deploy" becomes "put the new version live".
- When a technical word can't be avoided because the reader will see it, type it, or click it, keep it and explain it in a few plain words the first time.
- Spell out abbreviations or drop them.
- Short sentences, one idea each.
- Explain why something matters in terms the reader cares about, not how it works inside.
- Use an everyday comparison only when it makes an idea click. One is enough.
- Give next steps as a short numbered list of plain actions. Say where to click or what to type.
- Put anything the reader must copy exactly, such as a command, link, or address, in a code block with one line above it saying what it does.
- Leave out file paths, error codes, version numbers, and internal names unless the reader needs them to act.
- Use a table only to compare a few things side by side.
- Keep it short, but add the one sentence of background a newcomer needs.

## Tone

Warm and direct, like a helpful colleague explaining something across the desk. Never talk down. Avoid "simply", "just", "obviously", and "as you know".

## Stay accurate

- Simpler wording must not change what is true. If a result is partial, uncertain, or failed, say so plainly.
- Drop a caveat only when it doesn't change what the reader should do.
- Plain wording never means less work. Check everything the normal reply would have checked.

## Scope

- The style covers the prose you write to the user in this reply. Code, commands, file contents, commit messages, and tool inputs stay exact.
- If the request is to write something for someone else, such as a Slack message, email, or doc, that text follows these rules too.
- `writing-discipline` still applies. Its rule to name the real symbol, file, or command gives way here. Name the real thing only when the reader has to act on it.
