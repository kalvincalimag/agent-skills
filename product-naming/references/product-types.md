# Families and product types

Load this at step 1 when the thing being named is a feature, belongs to a family of existing names, shares its name with a mascot or character, is open source or a developer tool, or is an internal tool.

## Name or label?

Not everything deserves a name. Give something a name when it could exist on its own, has its own audience, is marketed on its own, or is used without the parent product. Give it a plain label when it lives only inside the parent, is part of a shared workflow, and is found through the parent. A name there confuses more than it explains.

Test: would someone say "I use [name]" without mentioning the parent? If yes, it deserves a name. GitHub Copilot deserves one. GitHub's pull requests need only a label.

When the answer is a label, say so and propose plain labels instead of running the full process.

## Families

Decide how much of the parent each name carries.

| Model | Pattern | Examples | Fits when |
| --- | --- | --- | --- |
| Branded house | [Parent] [descriptor] | Google Maps, Apple Watch | The parent name is the main asset and the products share a platform. |
| Endorsed | [Name] by [Parent] | Courtyard by Marriott | Products serve other audiences but gain from the parent's trust. |
| House of brands | independent names | Atlassian's Jira and Trello | Products serve different audiences, and one failing must not hurt the others. |
| Hybrid | a mix | Google Maps beside YouTube | Some products gain from the parent and others do not. |

What each model means for naming:

- **Branded house.** The descriptor does all the work, so make it concrete. "Apple Watch" works. "Apple Experience Platform" does not.
- **Endorsed.** The product name must stand without the parent.
- **House of brands.** Each name needs its own metaphor, story, and character.
- **Hybrid.** Each new product needs a stated reason for its tier.

Conventions keep a family coherent without making it formulaic:

- **A shared territory.** HashiCorp's Terraform, Consul, Vault, and Nomad are independent words with a shared feel.
- **A shared structure.** JetBrains' PyCharm and WebStorm join a technology hint to an evocative word.
- **Matching handles and repositories.** Use `[org]/[name]` on GitHub, `[name]-cli` for a command-line tool, and `@[name]_bot` for a Telegram bot.

When the project already has a mascot, a company name, or sibling products, read their names first. Prefer territories that sit well beside them, and check that the new name cannot be confused with a sibling.

Family checklist:

- It feels like it belongs beside the existing names.
- The architecture model is clear.
- It follows the convention without being formulaic.
- It cannot be confused with a sibling.
- It keeps the family's tone.
- It is pitched at the right level: a name or a label.

## Shared with a mascot or character

When a product and its mascot share one name, people remember them as one. The name then has two jobs: it heads the store listing, and it is what people call the character. Many names that pass every other rule fail the second job. Add these four tests to the brief unless the user sets others:

1. **Character name.** It sounds like something you would call a character: short, warm, and shaped like a pet name, often ending in a vowel or in a -y, -ie, -i, -o, or -oo sound. Verbs, dish names, places, and category words sound like labels, even when they are fun to say.
2. **Recognized root.** People in every target market can tell what it comes from: a word in the language they share, or a thing known everywhere. A word that only one market knows fails everywhere else.
3. **Home nod**, when the brief wants one. People in the home market catch a reference to their own culture.
4. **Fits the character.** It matches the character's existing look and story, so the art needs no change.

A word can be fun and still fail tests 1 or 2. Say every candidate aloud as "I'm ___" before keeping it.

### Plays on a favourite

When the user loves one word and wants versions of it, generate variants with each of these patterns. Keep any limit the user set, such as keeping the word's sound whole.

- **Pet-name ending.** Add -y, -ie, -o, or -oo, the way cuddle becomes cuddly.
- **Truncation.** Cut the word and end it on a vowel, the way many animal mascots are named.
- **The audience's own affixes.** Use the nickname endings and prefixes of the audience's language. They give a home nod for free.
- **Diminutives.** -let, -kin, -kins, the way a booklet is a little book.
- **Compounds.** Add a short, concrete word: an object from the character's design, or a food.
- **Blends into known words or phrases.** Fold the word into an idiom or a word people already know, keeping it audible.

Say each variant in a sentence and as a character's name. Drop variants that blur the favourite's sound or meaning.

## By product type

- **Consumer.** Memorability and warmth matter most. The name must work for people who do not care about the technology. The phone test is critical, because consumer products spread by word of mouth.
- **Business software.** It should feel established, not trendy, and nothing in it should make a buyer hesitate. Simple and serious, but not corporate padding.
- **Developer tools.** Clever references are welcome, because developers enjoy finding them. The name gets typed thousands of times, so it must be short, easy to type, and free of special characters.
- **Internal tools.** Clarity beats cleverness. Descriptive compounds such as LogViewer are fine. An in-joke can work for a small, stable team.

## Open source and command-line tools

The name is the marketing, because there is no ad budget. It spreads only by developers telling each other.

Hard constraints:

- **Lowercase.** Registries normalize to lowercase.
- **No special characters.** Hyphens are allowed in package names but cost something in imports.
- **Short.** Under eight characters is ideal. People type `import [name]` and `[name] --help` constantly.
- **No clash with common commands.** Avoid names such as `test`, `run`, `check`, `build`, and `make`.

Check the primary registry for the language, then the GitHub organization, then the registries the project might be ported to. A GitHub organization name carries more weight than a repository under a personal account, but popular ones are taken. If the project is big enough, secure the organization. Otherwise, match the repository name to the package name exactly.

Three more tests for open source names:

- **Typing.** Type the name ten times fast in a terminal. If your fingers stumble, it has a problem.
- **The conference talk.** Say it fifty times in a thirty-minute talk. It should flow in sentences, sound distinct from similar tools, and work as a noun or adjective: "a Rust project", "Deno-powered".
- **Forks.** Forks add prefixes and suffixes such as `[name]-ng`. A long base name turns those into a mess.

Rust, Deno, Vite, Bun, Zig, and Svelte all pass: one or two syllables, easy to say worldwide, and each either carries a metaphor or states the tool's idea in the word itself. Vite is French for "fast". Svelte means "slender". Deno is "Node" rearranged.
