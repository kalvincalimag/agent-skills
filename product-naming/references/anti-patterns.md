# What kills a name

Load this at step 4 to cut candidates. These patterns are what a language model produces by default, so check your own candidates against them before any survives.

## Generated-name slop

| Pattern | Examples | Why it fails |
| --- | --- | --- |
| Stock suffix | Glidely, Parsify, Chatible, Syncora, Buildly | Thousands of products already end in -ly, -ify, -able, -ora, or -ix. |
| Rootless blend | Brightrix, Nexagen, Vaultora, Intellicore | Unique on paper, indistinguishable in memory. No story, no image. |
| Thesaurus word | Apex, Pinnacle, Summit, Zenith, Catalyst | Every company that opened the same thesaurus page already took it. |
| Category plus modifier | CloudGuard, DataSync, SiteWatch, CodeForge | Says what it does and leaves nothing to remember. |
| Corporate padding | Anything Solutions, Labs, Platform, HQ, Group, Systems | Says only "we are a company". |
| Misspelling | dropped vowels, K for C | Reads as "the real spelling was taken". |
| Fake Latin or Greek | Cognivex, Synaptiq, Quantera, Luminex | Sounds impressive for two seconds, then means nothing. |
| Upbeat adjective pair | BrightPath, TrueNorth, ClearView, SwiftBase | Generic optimism that fits any product. |
| Intensity without reason | THUNDERFORGE for a calendar | The name's intensity should match the product's character. |

The swap test catches most slop. If the name would fit three products in three different categories equally well, it is slop.

## Compound traps

These first halves are almost always filler: Smart, Auto, Cloud, AI, Data, Cyber, Next, Digital, True, Pure, Open, Fast, Easy, Pro, Ultra, Hyper, Super, Meta, Omni, Core.

These second halves are almost always filler: Hub, Lab, Labs, Base, Flow, Sync, Link, Stack, Forge, Shift, Scape, Verse, Craft, Wise, Path, Nest, Box.

For any compound, ask three questions:

1. With the first word covered, does the second say something specific?
2. With the second word covered, does the first say something specific?
3. Could either word be swapped for a synonym and leave an equally good name?

A yes to the third question kills the name.

## Red flags

Ask each question of every candidate. Two or more yes answers disqualify it.

- Does a listener say "oh, like" and name other products?
- Is there no fifteen-second story for why it is called this?
- Does it need spelling out letter by letter after being heard?
- Does it work written but sound awkward spoken?
- Is it a cool word with no metaphor tying it to the product?
- Would it work just as well for a product in another category?
- Without its styling (capitals, symbols, swapped letters), is it generic?
- Does it match three or more patterns in the slop table?
- Would you wince introducing it in a work meeting?
- Is the free domain its main virtue?
- Does another common meaning of the word work against the product?

## Second meanings

A name can have a strong main metaphor and still carry a second meaning that undercuts the product. Check every dictionary sense, idiom, and slang use of the word, not only the one you mean. A backup tool named after something that famously breaks, or a calm wellness app named after a word that also means panic, confuses everyone who meets the other meaning first. [sound-and-language.md](sound-and-language.md) covers meanings in other languages.

## The "so what?" test

Tell someone the origin story and watch the reaction.

- "That's clever." The name works.
- "Oh, I see." Acceptable.
- "So what?" The story does not earn the name.
- "I don't get it." The reference is too obscure.
- "Isn't that already a thing?" The territory is occupied.

Aim for "that's clever". Never ship "so what?".

## Naming an AI product

Products built on AI models converged on a few patterns fast, and those patterns now signal "me too".

- **"AI" in the name.** It dates the product, distinguishes nothing, and reads as a thin wrapper around someone else's model. It can work only where the product is the model itself.
- **Pilot and copilot.** "Copilot" earned its cockpit metaphor. Every "[category]pilot" since reads as "Copilot, but for [category]", which is a positioning line, not a name. The cockpit and aviation territory is taken.
- **A human first name.** It works when the assistant is the whole product and people talk to it. It fails for a feature inside a larger product ("Meet Sarah, your CRM assistant") and when the name has no story. Test: would a user plausibly say "Sarah, do X" out loud? If they would only click a button labeled Sarah, skip it.
- **Magic.** Spell, wand, conjure, and enchant are saturated, and "magic" implies hiding how the product works, which hurts trust in serious tools. It can suit consumer entertainment, almost never business software.
- **Smart, Neural, Neuro.** Redundant for an AI product and tied to one hype cycle. Neuro fits only products about brains or neuroscience.

## Five fatal flaws

Any one of these kills a name.

1. **A boring description.** "Site Monitor" is a description and "Team Collaboration Platform" is a sentence. Use the description as the tagline.
2. **A blend with no meaning.** Founders pick these because the domain is free. It is free because nobody wanted it. Start from a real word or root instead.
3. **A thesaurus synonym of the main attribute.** Ask what else in the world does this job, not which words mean "fast".
4. **Empty corporate words.** If removing a word does not change the meaning, remove it.
5. **Extremeness for its own sake.** Intensity without relevance is noise.
