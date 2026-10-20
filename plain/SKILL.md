---
name: plain
description: "Answer the request in simple, concise, plain English with as little technical jargon as possible, assuming the reader knows nothing about the subject, so a non-technical person understands it on the first read without asking a follow-up question. Use only when the user explicitly invokes this skill by name, such as /plain, with or without a request after it."
argument-hint: "[request]"
disable-model-invocation: true
---

# Plain English

The reply must be simple, concise, and in plain human English, with as little technical jargon as possible. It assumes the reader knows nothing about the subject. Every choice below serves one test: a non-technical person understands it on the first read and has no need to ask "what do you mean by that?"

The request is whatever the user typed after the command. It may be empty.

## What to do

- **With a request.** Do the request exactly as you would without this skill. Use the same tools, checks, and care. Only the way you write the reply changes.
- **With no request, or one that only points back at your last reply** (such as "the second part"). Restate that reply, or the part named, in this style. Rewrite it from scratch for the reader below, like one person talking to another. Do not keep the old reply's structure and swap in easier words. Keep every conclusion, warning, and choice the reader is asked to make, and drop side details that change none of them. Keeping every conclusion does not mean keeping every section, and the result is usually shorter than the original. Restate only. Do not run tools, add findings, or soften or widen a claim you already made. Explaining something the old reply mentioned is part of restating it, not a new finding.

This applies to your next reply only. After that, write normally again.

## The reader

A smart person with no technical background who is new to the subject. Assume they know only what they said themselves in this conversation. They did not see your tool output, the files you read, the steps you took, or the names you picked up along the way. They may have skimmed your earlier replies. They read this one once. They want to know what happened, what it means for them, and what to do next.

## Assume nothing

Everyday words can still assume knowledge. This is where plain replies most often fail.

- **Introduce everything you mention.** Every thing the reply names, such as a file, folder, page, list, setting, service, company, or step you took, is either something the reader named first, or you say in a few words what it is and why it is in the story. "The shared folder" is still a mystery if nobody told the reader which folder.
- **Don't invent friendly names.** A label you made up, like "the shared base", matches nothing the reader can see. Describe the thing instead, or use the name the reader will see on screen and explain it once. Then keep calling it that.
- **Say where things are.** If the reader might want to look at something, say where to find it, such as "in your Downloads folder" or "on the Settings page".
- **Mention fewer things.** A newcomer can take in about three new ideas in one reply. Choose the ones that answer the question, plus anything the reader must decide. Leave out the rest, however true: how the thing is built inside, how you found out, exact names and codes, and side findings. Every extra thing is one more thing to explain.
- **Explain what it does, not how it works.** Say what something means for the reader. "The menu only shows items someone has switched on" beats an account of where the menu gets its data.

This sentence assumes knowledge:

> To free 13 GB, turn off the hibernation file.

This one assumes nothing:

> Windows keeps a 13 GB file on your drive so it can save everything you had open when the computer goes into its deepest sleep. If you never use that kind of sleep, you can switch it off and get the space back.

## How to write

- Open with the answer or the outcome in one or two sentences.
- Use everyday words. Say what a technical term means instead of using it. "Deploy" becomes "put the new version live".
- When a technical word can't be avoided because the reader will see it, type it, or click it, keep it and explain it in a few plain words the first time.
- Spell out abbreviations or drop them.
- Short sentences, one idea each.
- Explain why something matters in terms the reader cares about.
- Use an everyday comparison only when it makes an idea click. One is enough.
- Give next steps as a short numbered list of plain actions. Say where to click or what to type.
- Put anything the reader must copy exactly, such as a command, link, or address, in a code block with one line above it saying what it does.
- Leave out file paths, error codes, version numbers, and internal names unless the reader needs them to act.
- Use a table only to compare a few things side by side.

## Length

Concise means no wasted words, not the fewest words. Cut what the reader doesn't need, then add what they need to follow the rest. Explaining terms adds words, so make room by cutting details. If the plain version is longer than the technical one, cut again. A reply that leaves the reader asking "what is that?" was too short in the wrong place. When this skill and another instruction to keep replies short disagree, the reader's understanding wins.

## Check before sending

Reread the reply as the reader above.

1. Find every thing it names, including labels carried over from earlier replies, such as the name of a step, a site, or a part of the work. For each one, ask whether the reader would know what it is and where it is. If not, explain it in a few words or cut it.
2. Ask what the reader would ask first after reading it. Answer that in the reply, or remove what prompts the question.
3. Check that the reply makes sense without the earlier messages.

## Tone

Warm and direct, like a helpful colleague explaining something across the desk. Never talk down. Avoid "simply", "just", "obviously", and "as you know".

## Stay accurate

- Simpler wording must not change what is true. If a result is partial, uncertain, or failed, say so plainly.
- Drop a caveat only when it doesn't change what the reader should do.
- Explain a thing only from what you know. If an explanation is your guess, say so.
- Plain wording never means less work. Check everything the normal reply would have checked.

## Scope

- The style covers the prose you write to the user in this reply. Code, commands, file contents, commit messages, and tool inputs stay exact.
- If the request is to write something for someone else, such as a Slack message, email, or doc, that text follows these rules too.
- `writing-discipline` still applies. Its rule to name the real symbol, file, or command gives way here. Name the real thing only when the reader has to act on it.
