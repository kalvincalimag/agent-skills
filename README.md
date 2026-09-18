# Claude Skills

Reusable **Claude Code / agent skills** pack for cross-project use.

## Install

Copy into a project's `.claude/skills` directory, or symlink this repo there:

```bash
# copy
cp -R /path/to/claude-skills/* /path/to/project/.claude/skills/

# or symlink (Unix)
ln -s /path/to/claude-skills /path/to/project/.claude/skills
```

On Windows, copy the skill folders into `%USERPROFILE%\.claude\skills` or the project's `.claude\skills`.

## Keep NOTICE.md

`NOTICE.md` documents MIT attribution for upstream skill sources. Keep it when you copy or redistribute this pack.

## Skill folders

| Folder | Role |
|--------|------|
| `bro/` | Sibling / pairing workflows |
| `bugfix/` | Systematic debugging |
| `implement/` | Implementation execution |
| `investigate/` | Investigation / root-cause |
| `plan/` | Planning |
| `ship/` | Shipping / finishing |
| `slack-reply/` | Slack reply drafting |
| `test-design/` | Test design |
| `verify/` | Verification before done |
| `writing-discipline/` | Writing discipline |

## License

MIT (see `LICENSE`). Upstream attributions live in `NOTICE.md`.
