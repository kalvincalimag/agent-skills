# Skills repository agent instructions

This repository is a set of agent skills in the Agent Skills format (agentskills.io). Its clone is the folder an agent loads skills from, such as `~/.claude/skills` for Claude Code or `~/.agents/skills` for OpenAI Codex.

- Each skill is `<name>/SKILL.md`, with `name` matching the folder and a `description` that says what the skill does and when to use it.
- Keep every skill general across projects and agents. No project, client, or person names, no machine paths, and no credentials. Detail for one agent or one provider goes in a reference file beside the skill.
- Run `bash sync-skills/check.sh` after changing a skill, and run any tests in the skill's `tests/` folder.
- Sync with the repository through the `sync-skills` skill. Commit and push only when the user authorizes it.
