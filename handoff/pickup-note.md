# Pickup: <name of the work>

- Status: partial
- Cold read: not run
- Updated: <YYYY-MM-DD HH:MM and time zone>, by <agent and model>
- Started: <YYYY-MM-DD>. Replaces: <link to the previous pickup note, or "none">
- Sessions: <links to this work's session files>

<!-- Status is "partial" until the handoff is checked and delivered, then "ready". Cold read is "not run" with the reason, "passed after N rounds", or "open findings after N rounds". -->

## How to pick this up

1. Read this note in full, then the "Read first" files under "Map".
2. If "Status" above is `partial`, the handoff stopped before it finished. The brain sync, the checks, or the delivery may not have run. Check each "Done" item against its evidence before you rely on it, and treat anything this note does not cover as unknown.
3. Run the checks under "As of". If your machine has no repository at a row's "Location", clone its "Remote", check out its "Branch", and run the checks in the clone. If anything differs, do not reset, pull, or rewrite anything. Read what changed since the recorded commit with `git log` and `git diff`. Update "State" if the change explains itself. Otherwise ask the user, and hold only the steps the difference affects.
4. If the "Cold read" line above does not start with "passed", write each point where you have to guess under "Open questions". Ask the user about them once, and continue with the steps that do not depend on a guess.
5. Work through "Next steps". Before each step, check it against "End goal" and "Fences". Do not reopen anything under "Fixed decisions" without asking the user.
6. Hand each lane under "Parallel lanes" to a subagent with its brief. If you cannot start subagents, run the lanes in order yourself.
7. At every exit check, update "State" with the result and its evidence. Write durable knowledge back as the brain's `AGENTS.md` says, or into this note when there is no brain. This note then stays at most one step behind if your session ends suddenly.
8. Approvals listed under "Fences" were given to an earlier session. Ask again before any action they covered, unless a standing rule of the user's covers it.
9. When the end goal is met, archive this note as the brain's rules say and remove its line from the memory index's active context. Without a brain, ask the user whether to delete this note. To hand off before then, update this note in place.

## End goal

<!-- The goal in the user's words, quoted. If the user never stated it in one place, write your summary and mark it as yours. Then what done means, as checks anyone can observe: a command and its passing result, a screen and what it shows, a number with its unit. Then what is out of scope. -->

> <the user's words>

Done means:

- <observable check>

Out of scope:

- <item>

## As of

<!-- One row per repository the work touches, and one for the brain if there is one. "Location" is the path on the machine that wrote this note. "Remote" is the URL to clone it from, or "none". Write locations, remotes, branches, and commits in code font so the checker can verify them. A dirty tree lists its changed files. For the brain, write `-` under "Commit" and "Working tree", because the brain changes as this handoff is saved. -->

| Repository | Location | Remote | Branch | Commit | Working tree |
| --- | --- | --- | --- | --- | --- |
| <name> | `<path>` | `<clone URL, or none>` | `<branch>` | `<short hash>` | <clean, or the changed files> |

Check each row with `git -C <location> rev-parse --short HEAD` and `git -C <location> status --porcelain`. In the repository that holds this note, leave the note itself out of both checks. Its last commit may be one that changed only this note.

### Commands

<!-- For each repository, the exact commands to set up, build, test, and run it, and what each gives today. -->

- <repository>: `<command>` gives <result today>.

## State

### Done

- [x] <item>. Evidence: <commit, command and result, or file>.

### In progress

- <item>. <What exists, what is half-written, in which files, and in what condition. Mark it unverified if nothing proves it.>

### Not started

- [ ] <item>

## Next steps

<!-- Ordered. Each step names its exact action or command and ends in an exit check that can fail. The first step runs as written. -->

1. <action>. Exit check: <what passes>.

## Fixed decisions

<!-- Every decision a fresh agent might reopen, including the user's corrections and stated preferences. One line each, linked to its record. The record wins if the two disagree. -->

- <decision>, not <the rejected alternative>. Why: <reason>. Record: <link>. Reopen only if <condition>.

## Fences

<!-- What the next agent must not touch, change, or do, and the user's standing rules for this work. List approvals the user gave an earlier session, marked as such. -->

- <fence>

## Parallel lanes

<!-- Only lanes that pass the parallel test in the plan skill: inputs ready, no file shared with another running lane, briefing cheaper than doing, merging cheaper than the time saved. Otherwise write "None" and the reason. -->

| Lane | Depends on | Writes only | Exit check |
| --- | --- | --- | --- |
| <name> | <lane or step> | <files> | <check> |

Brief for <lane name>:

> <A brief that stands alone: the goal, the files to read, the files it may write, what it must not touch, how to verify, and what to return.>

The main thread keeps <integration, files more than one lane writes, and questions for the user>.

## Open questions for the user

- <question>. Recommended: <answer>. It changes <what>. Waiting on it: <steps>.

## Map

<!-- Where things live for this work, so the next agent opens a file instead of searching. "Read first" is the smallest set the first step needs, in reading order. -->

Read first:

1. `<path>`. <What it gives.>

Look up when needed:

- `<path>`. <The topic it covers.>

## Traps

<!-- What looks right but is wrong: terms coined in this work, stale files and superseded decisions, and approaches already tried that failed. Link each to its record. Keep only what a fresh agent would plausibly fall into. -->

- "<term>" means <meaning>.
- Do not use `<path or decision>`. <Why it is stale.>
- <Approach> was tried and failed because <reason>. Evidence: <link or command>.

## What does not travel

<!-- Running processes, local-only files, seeded data, signed-in tools, environment variables, and the user's skills or connected tools this work relies on. For each, what the next session cannot do without it, and how to restore it or where it lives. Say where a secret lives, never its value. -->

- <item>. Consequence: <what the next session cannot do>. Restore: <how>.

## Review

<!-- Cold-read findings still open, with their grade, and the deferred P2 items. -->

- <finding, or "None">
