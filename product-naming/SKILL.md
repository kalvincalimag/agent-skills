---
name: product-naming
description: Use when naming or renaming a product, app, service, feature, company, open source project, library, command-line tool, or bot, or when judging names already on a shortlist. Builds the brief from what the project already records, explores metaphor territories before words, cuts generic and machine-made names, checks real availability on domains, package registries, GitHub, and app stores, and presents three to five scored finalists with origin stories and taglines. Not for naming code symbols such as variables, functions, or files, and not for creating a mascot character.
argument-hint: "[what needs a name, and any names already in play]"
---

# Product naming

A good product name is a compressed story: a concrete image that unfolds into what the product does. People repeat it after hearing it once, spell it, and remember it the next day. Most names made in a hurry fail the same few ways, and a language model's first ideas fail them most often. This skill exists to get past those first ideas to names that could belong to no other product.

Read each reference at the step that needs it, not up front. A quick round reads three of them.

## How names fail

Check every candidate against these. They are what this skill exists to prevent.

- **Category label.** CloudSync and SiteWatch describe the category and leave nothing to remember.
- **Stock suffix or blend.** Parsify, Syncora, and Nexagen are unique on paper and interchangeable in memory.
- **Thesaurus word.** Apex and Summit were taken by thousands of companies first.
- **No story.** Nobody can say in fifteen seconds why it is called that.
- **Fails out loud.** A listener cannot spell it after hearing it once.
- **Second meaning.** Another sense of the word, in English or the audience's language, works against the product.
- **Occupied.** A direct competitor already uses it.
- **Unchecked.** Availability came from memory instead of a check run that day.

## Process

### 1. Build the brief from the project

Before asking anything, read what the project already says about itself: the readme, product docs, landing page copy, store listing, package manifest, and the project's notes or knowledge base, if it keeps one. If an earlier naming round is recorded, read its brief, its finalists, and the names the user rejected with their reasons. A new round never proposes a rejected name again.

Fill in this brief from what you found:

1. What it does, in one sentence.
2. Who it is for, and which languages and markets they are in.
3. How the name should feel, such as technical, warm, playful, or serious.
4. What is being named: a product, a feature, a company, an open source library, or an internal tool.
5. The names around it: the company, sibling products, a mascot, codenames, and the users' own jargon.
6. Off-limits words, sounds, and styles, and names the user already likes or dislikes.
7. Where the name must be free: domains, registries, GitHub, app stores, handles.

Then ask the user, in one message, only for what is still missing or unclear. If the user already gave a full brief or said to go ahead, skip the questions and state the assumptions you made.

Read [references/product-types.md](references/product-types.md) when the thing is a feature, belongs to a family of names, is open source or a developer tool, or is internal. If it is a feature, decide first whether it needs a name at all. Most features need a plain label.

### 2. Explore territories, not words

Read [references/territories.md](references/territories.md). Reduce the product to its core job in one plain sentence, answer the six metaphor questions against it, and group the answers into territories. Keep the two or three richest.

When the brief is clear, choose the territories yourself and explain them in step 7. Ask the user to choose only when the brief points two ways equally.

Steps 3 to 6 are internal. Do not show candidates, cut lists, or interim scores. The user's next view is the finalists in step 7.

### 3. Generate

Read [references/principles.md](references/principles.md) first. Write thirty to fifty candidates across the chosen territories, including imperfect ones, because they show patterns. Use several methods:

- single words from a territory;
- compounds that cross two territories;
- modified words: truncated, blended, or respelled only where the result still reads naturally;
- borrowed words from other languages;
- sound first: say syllables aloud and look for combinations that mean something.

Read [references/sound-and-language.md](references/sound-and-language.md) when choosing between sounds or borrowing a foreign word, and [references/examples.md](references/examples.md) when a technique needs a model.

### 4. Filter

Read [references/anti-patterns.md](references/anti-patterns.md). Run the red flags on every candidate, check every meaning of each word, and cut to about ten semifinalists. Be hardest on your own fluent first ideas, because the slop patterns are what a language model writes by default.

### 5. Check availability

This step blocks. Read [references/availability.md](references/availability.md).

1. Search the web for competitors first: `"[name]" [category]` and `"[name]" app`. A direct competitor in the same space kills the name. Skip its other checks.
2. For survivors, run `scripts/check-availability.sh` from this skill's folder with the platforms the brief named. Run several names in parallel.
3. Use web search for what the script cannot check: Google Play, social handles, and trademarks.

Report UNCLEAR results as unconfirmed, never as free. If the session has no network or web search, say which checks could not run, and mark those names unchecked. Drop names that fail a must-have platform with no acceptable workaround. If fewer than three survive, return to step 3. Do not lower the bar.

### 6. Score

Read [references/evaluation.md](references/evaluation.md). Score the survivors, say each in the sentence tests, and compare them side by side.

### 7. Present

This is the user's first view of any names. Present three to five finalists, best first, in the format in [references/evaluation.md](references/evaluation.md): the name, its fifteen-second story, its territory, why it works, its score, availability with the date checked, risks, and one or two taglines from [references/taglines.md](references/taglines.md).

End with a recommendation and its reason. Suggest the user say the top names aloud over a day before deciding. Share the cut list only if the user asks.

### 8. Record the round

If the project keeps notes or a knowledge base, write the round there, following that store's own rules: the brief, the territories, the finalists with availability and the date checked, the user's verdict, and every rejected name with the reason. The next round in any session starts from this record. If the project keeps no notes, offer to save a short naming record in it, and write it only if the user agrees.

## When to loop back

- **Every candidate fails the filter.** Return to step 2. The territories are exhausted, not the word lists.
- **Fewer than three survive availability.** Return to step 3 in the surviving territories.
- **No candidate scores 65.** Return to step 2. The metaphors are too weak.
- **The user rejects every finalist.** Ask what was wrong with them, record the answer, and return to step 1. The brief was wrong somewhere.

## Rules

- No names before the brief.
- Metaphors, not synonyms. Never brainstorm from a thesaurus of the product's category.
- Show finalists only, and three to five of them.
- Every finalist has an origin story.
- Every availability status comes from a check run in this session, with its date.
- When the user rejects a direction, drop it and explore another territory.
