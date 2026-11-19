# Adversarial review of finalists

Load this at step 7, after scoring and before the user sees any name. The reviewer's job is to find evidence that a finalist fails, not to confirm the ranking. Names that pass the skill's own filters still fail users in ways the filters miss: a fun word that sounds wrong as a character, or a clever local word nobody abroad can place. A reviewer reading the names cold catches what the person who generated them cannot.

## Keep the reviewer independent

Use a fresh reviewer that did not generate the candidates. A subagent with fresh context counts. A different model is better when one is available. Never reuse a reviewer, because it has already seen the names.

Give the reviewer:

- the brief: what the product does, who it is for, the markets and their main languages, and the feel;
- the user's tests, word for word, with where each came from;
- the list under "How names fail" in the skill;
- for a name shared with a mascot or character, a one-paragraph description of the character's look and story;
- each finalist's name and a one-line origin;
- the availability results with the date checked.

Withhold the scores, the ranking, your preferred pick, and any reasoning beyond the one-line origin. Several reviewers can run at the same time, for example one per batch of names or one per market language.

## Checks

Each check passes or fails, with one line of evidence. Every user test gets its own check.

1. **Cold hearing.** Before reading the origin, say the name once. Write how a listener would spell it and what they would picture. Fail if the spelling drifts or the picture has nothing to do with the product.
2. **Each user test.** Apply each one as written. When a test is vague, apply its plainest reading and say which reading you used.
3. **Outside reader.** For each market, say what the name means to someone who never heard the origin story. Fail a test such as "understood abroad" when the answer is nothing, even if the word is fun to say.
4. **Character name**, when the name is shared with a mascot. Say "I'm ___" and "Have you met ___?" aloud. Fail when the name sounds like a verb, a dish, a place, a category, or a command rather than something you would call a character.
5. **Fit with the character.** Fail when the name contradicts the character's look or story, or would need the art changed.
6. **Second meanings and sound-alikes.** Check slang and swear words in each market language. Check famous brands one sound away, and words in the home language that sound close and mean something bad.
7. **Occupied.** Spot-check one search for a same-name app in the category. Report a hit as evidence, not a verdict, because step 5 owns availability.

The reviewer reports failures and evidence. It does not rank, rewrite, or propose new names. When it suggests one anyway, treat it as a note.

## Act on the results

- Cut every finalist that fails a user's test. Record the failure with the cut name.
- Add every other failure to that finalist's risks, in plain words.
- When several reviewers ran, act on a failure at least two raise. Record a failure only one raises as a note.
- If fewer than three finalists pass, return to step 3 of the skill and use the failures to steer the next candidates. Review the new finalists with a fresh reviewer.
- Show each finalist's review result in the presentation: "passed every test", or the risks it carries.
- If no fresh reviewer could run, run the checks yourself, and say plainly that the review is unverified.
