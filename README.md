# Claude Skills

Reusable [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills pack for cross-project use. This repository is the source of truth. Skills are edited in the local install and published here with `sync-skills`.

## Skills

| Folder | Purpose |
| --- | --- |
| `investigate` | Structured investigation |
| `plan` | Planning / design exploration |
| `implement` | Implementation discipline |
| `test-design` | Test design |
| `bugfix` | Debugging / bugfix |
| `verify` | Verification / blast radius |
| `ship` | Shipping / PR mechanics |
| `writing-discipline` | Writing quality |
| `slack-reply` | Slack reply helper |
| `plain` | Plain-English responses |
| `handoff` | In-progress session handoffs |
| `new-brain` | Create a local knowledge brain from brain-template, improving the template first |
| `sync-skills` | Sync the local skills install with this repository |

## Brains

A brain is a local folder that holds curated knowledge for one purpose, such as personal taxes or a software project. Starting Claude in that folder loads the brain's rules and memory index, and the session writes durable knowledge back before it answers. `new-brain` builds brains from [brain-template](https://github.com/kalvincalimag/brain-template), which holds the shared layout, the optional profiles, and the rules for improving the template. Brains hold knowledge only. Skills are out of scope for them: Claude Code loads the skills installed in `~/.claude/skills` in every session, including sessions in a brain.

## Install

Install the skills user-wide so every project and every brain uses the same copies:

```powershell
git clone https://github.com/kalvincalimag/claude-skills.git "$HOME\Desktop\Master\Code\Personal\claude-skills"
Copy-Item -Recurse -Force "$HOME\Desktop\Master\Code\Personal\claude-skills\*" "$HOME\.claude\skills\" -Exclude README.md,LICENSE
```

Do not copy these skills into a project's `.claude/skills/`. A second copy goes stale and clashes with the installed one by name. A procedure that only one project needs belongs in that project.

## Keep in sync

Edit skills in `~/.claude/skills`, then run the `sync-skills` skill. It pushes local edits, pulls edits made here, stops on conflicts, and checks that every pushed skill stays general across projects. Its script and tests are in `sync-skills/`.

## License

See `NOTICE.md` and `LICENSE` (MIT). Upstream attributions are required.
