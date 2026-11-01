---
name: standup
description: Draft the user's spoken standup update, short Updates and Blockers bullets they read aloud, from the current session's work and their recent git commits, then write it into their standup block, such as a Notion page, after they approve, or hand it over to paste when no destination is connected. Use whenever the user asks for a standup, standup update, daily update, "what did I do today", or to fill in or refresh their standup block, even if they don't name the skill.
---

# Standup

The user reads this update aloud at standup to people with mixed technical backgrounds. Listeners hear it once and can't scroll back. Every choice below serves one test: someone who wasn't in the session understands each bullet the first time they hear it.

## 1. Find where it goes

The user's personal instructions may name their standup destination, such as a page and the block on it. If they don't, ask once. If the user has no destination, draft in chat and stop after step 4, so they can paste it wherever they read from.

If the destination's platform isn't connected, ask the user to connect it or to paste the block's current text. If they do neither, draft without it.

Read the block's current text before you draft, for two reasons:

- Its layout is the template. Match its section labels, bullet style and length.
- Its bullets may be old updates already reported, or new work the user added themselves and hasn't read out yet. You can't tell which from the text. Before drafting, list them and ask the user which to keep, which to drop, and which have moved forward. Keep the ones they choose word for word, and don't repeat anything they mark as already reported. If a kept bullet and a new update describe the same work, merge them into one bullet rather than listing both, and point out the merge when you show the draft.

## 2. Gather what happened

Use these sources, in this order:

1. **This session.** What was done, decided, found out, sent, or planned. Count something as done only when the conversation shows it happened. A message that was drafted but never confirmed as sent is "drafted". Ask if it matters.
2. **The user's git commits since the last standup**, if the session is in a Git repository. Ask whether other repositories count. Take the author from `git config user.email`, and use the previous working day as the start unless the user says otherwise. Merge commits add nothing new.
3. **Blockers.** Anything waiting on someone else, with who can unblock it.

If the sources are thin, say so and ask what else to include. Don't pad.

## 3. Choose

Pick three to five updates the team cares about: outcomes, decisions, estimates, and anything someone else must act on. Write one update per domain, such as one partner, one product area or one piece of infrastructure, and fold everything about that domain into it, kept bullets included. Two bullets about the same partner or the same system is one bullet split in two. Put the most important first. Leave out how the work was done, dead ends, and side findings, unless one changes what the team should do.

## 4. Write for the ear

- **One breath per bullet.** One sentence, past tense, starting with a verb, under about twenty words.
- **Say what changed for the team or product, not how.** "Made the site faster by moving the server closer to the database", not "moved the functions region to iad1".
- **Everyday words.** If a technical word is unavoidable, say what the thing does instead: "the part that keeps track of the money", not "the ledger service".
- **Nothing that can't be said aloud.** No file names, branch or pull-request numbers, code identifiers, or acronyms listeners wouldn't say. No symbols such as slashes, arrows, ampersands, tildes or parentheses. Write numbers the way you'd say them.
- **Names people already use.** People by first name, and products by the name the team already uses.
- **Don't report listeners' own actions back to them.** Ask who hears the standup. If someone in the room made a decision or owns a task, state the outcome without crediting them: "moved the new partner ahead of the other one", not "Sam made them the priority".
- **Plain confidence.** No filler or hedging. An estimate is "a rough estimate", once.
- **Blockers say who.** One line each: what's stuck and who can unblock it. If there are none, keep the block's empty bullet.

| Hard to follow aloud | Easy to follow aloud |
| --- | --- |
| Migrated the API to the new region (PR 58), p95 down 40% | Made the site faster by moving the server closer to the database |
| Scoped the vendor's webhook integration: six endpoints plus a retry queue on the shared worker | Looked into the new vendor's docs and scoped what we need to build on our side |
| Waiting on creds plus IP whitelist | Waiting on test logins from the vendor, which come once we send them our server addresses |

## 5. Show, then write

Show the draft in chat exactly as it will appear, with the bullets the user kept from step 1 in place, and ask whether to write it. Writing replaces the block's current bullets, so say which current bullets the draft drops when you ask. Never drop one the user didn't agree to drop.

If the destination isn't connected, give the user the final text to paste and stop.

Once the user approves, replace only the bullets inside the standup block. Keep its heading, section labels and everything else on the page as they are, then re-read the block to confirm the change landed. For a Notion page, follow `references/notion.md`.
