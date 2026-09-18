---
name: writing-discipline
description: "Use for any prose you produce: documentation, readmes, RFCs, pull-request descriptions, commit messages, and your own replies. Cuts machine-written tells and applies a layered standard for structure, sentences, and unambiguous syntax. Always applies."
---

# Writing Discipline

## Purpose

The delivery skills say nothing about prose, and prose is most of what a reviewer actually reads. The goal is writing a tired engineer understands on the first read.

Two halves. Part one removes the tells that mark text as machine-written. Part two is the positive standard: what kind of document this is, how sentences address the reader, how much each carries, and whether any can be read two ways.

Three rules sit above everything:

- **Cut every word that does no work.** If the sentence survives without it, it goes. "In order to" is "to". "It is important to note that" is nothing.
- **Use the short everyday word.** "Use", not "utilize". "Help", not "facilitate". A long word buys its length with precision or it goes.
- **When a rule makes a sentence worse, fix it another way or leave it alone.** A sentence that follows every rule and still sounds machine-written has failed.

The codebase is the word list. Write the real symbol, file, flag, or command name, never a synonym or a description of it.

## Part One: Cut the Tells

### Content

- **Superficial participles.** "highlighting", "ensuring", "reflecting", "showcasing", "fostering". Delete, or replace with the real fact.
- **Vague attribution.** "Experts believe", "Industry reports suggest", "Some argue". Name the source or cut the claim.
- **Generic conclusions.** "The future looks bright." State a specific plan or fact.

### Vocabulary

- **Machine vocabulary.** Additionally, crucial, delve, enhance, fostering, garner, interplay, intricate, landscape, pivotal, showcase, tapestry, testament, underscore, vibrant. Use plain words.
- **Fancy ways to say "is".** "serves as", "stands as", "boasts", "features". Say "is" or "has".
- **Abstract metaphor nouns.** Substrate, wedge, vector, locus, nexus, primitive as a noun, harness as metaphor, bedrock, scaffolding as metaphor, paradigm, north star, flywheel. Each has a plainer concrete word. "Substrate" is "base". "Vector" is "way". Pick the concrete one.
- **Mannered prose.** Aphorisms, rhetorical fragments, personified code, figurative verbs like "rides along" or "stands on". Say what you mean.

### Structure

- **"Not just X, but Y."** State the point directly.
- **Forced groups of three.** Use the natural number.
- **Synonym cycling.** Pick one name for a thing and repeat it.
- **False ranges.** "from X to Y" where X and Y are not on a scale. List the items.
- **Inline-header lists.** A bold label and colon that restates the line is a tell. A bold lead-in that ends in a period, names the item, and is followed by genuinely new detail is fine.

### Formatting

- **No em dashes anywhere.** Use a period or a comma. If a thought needs separation, end the sentence.
- **No colons as mid-sentence connectors.** Before a list or an example is fine.
- **No decorative bold.** Do not bold every proper noun.
- **Sentence case headings.** No title case, no emoji.
- **Straight quotes**, not curly.

### Voice

- **No chatbot phrases.** "I hope this helps", "Let me know if", "Of course", "Certainly".
- **No sycophancy.** "Great question", "You're absolutely right". Respond directly.
- **Cut filler.** "In order to" becomes "to". "Due to the fact that" becomes "because".
- **Cut hedge stacks.** "could potentially possibly be argued that it might" becomes "may".
- **Active voice.** Name the actor. "Queries are validated" becomes "the compiler validates queries".
- **Cut adverbs or use a stronger verb.** "runs quickly" becomes "is fast", or give the number.
- **Say what it does, not how it feels.** "types that follow your schema" names a feeling. "A column rename fails the build" names the mechanism. If a sentence could appear unchanged in another project's docs, it says nothing about this one. Cut it.
- **Split dense sentences.** One idea per sentence. If the reader backtracks to parse it, break it in two.
- **Do not over-compress.** Dropped articles, verbless fragments, and arrow notation make the reader decode instead of read. Write whole sentences.

## Part Two: The Positive Standard

### Pick the mode first

One document, one mode. Two questions choose it: does the content serve doing or understanding, and does it serve learning or work?

- **Tutorial** (doing, learning). The learner's success is your job. Say what they will build. Every step produces a visible result and you say what they should see. Explanation is one clause and a link.
- **How-to** (doing, work). Solve a problem a person has. Assume competence, skip teaching, no background. Allow forks: "If you want x, do y." Name it by the task.
- **Reference** (understanding, work). Describe only. No instruction, no opinion, no hedging. Mirror the structure of the thing described. Generate from code where possible so it stays true.
- **Explanation** (understanding, learning). One bounded topic, readable away from the product. Design decisions, history, constraints, alternatives. Opinion is allowed here and nowhere else.

Do not mix modes. Split and link instead.

### Write sentences to the reader

- Address the reader as "you", in the present tense. "Will" only for things that genuinely happen later.
- Write instructions as commands. "Click Submit", never "should be done".
- Put the condition before the instruction. "To delete the document, click Delete." The reader skips what does not apply.
- Put the common case first, exceptions after.
- Never "simply", "easy", or "quickly" in a procedure. If it were simple the reader would not be here.
- Headings carry the point, not the topic. Sentence case, one h1, no skipped levels.
- Numbered lists for sequences, bullets for everything else. Introduce a list with a complete sentence. Keep items parallel.
- Link with words that say where the link goes, never "click here".
- Code in code font, UI elements in bold, serial commas.

### Make statements load one at a time

- One instruction per sentence. One thought per sentence everywhere else.
- Split instructions over about twenty words, and other sentences over about twenty-five.
- Put the warning before the step it guards.
- Keep articles. "Remove backup file" reads two ways. "Remove the backup file" reads one.
- Give each word one meaning and one job. Pick one verb per action and keep it.
- Avoid participles where a plain verb works.

### Leave no sentence open to two readings

- Keep "only" and "not" next to the word they change.
- Break up long noun strings. "the proto import budget check script" becomes "the script that checks the proto-import budget".
- Make every "it", "they", and "this" point at one obvious thinc. Never point "this" at a whole clause.
- Do not drop verbs from a parallel clause.
- Periods, not semicolons.
- Parenthetical text is a full grammatical unit or its own sentence. Never "(s)" plurals.
- No slashes. Write "a, b, or both".
- Call each thing by one name everywhere.
- Skip idioms, Latin abbreviations, and metaphors. A non-native reader, a translator, and an agent all parse plain constructions best.

### Vary the rhythm

A document can obey every rule above and still read machine-written: every sentence clipped, no view anywhere, nothing specific.

- Mix sentence lengths deliberately. Short sentences land a point. Longer ones carry a fact with its condition.
- One thought per sentence does not mean one length per sentence.
- Have a view where the mode allows it. Explanation weighs tradeoffs, so say what you make of them.
- Be specific over sterile. Not "schema changes can cause issues" but "a column rename fails the build".

## Pull Requests and Commits

Every layer except mode selection applies. A pull-request body is a briefing a reviewer reads in under a minute. Do not paste logs, commit lists, or metric tables. Link them.

Make every count, path, and symbol true at the commit that lands it, and include the command that regenerates any count.

## Review Checklist

1. Is each document one mode, with links where modes meet?
2. Is every instruction a command with its condition in front?
3. Does any sentence carry two thoughts? Split it.
4. Can any word be cut without losing meaning?
5. Is "only" beside the word it changes? Does every "it" point at one thing? Does every clause keep its verb?
6. Does each thing have exactly one name throughout?
7. Would a developer say these words out loud?
8. Are all symbols, paths, and counts real at this commit?
