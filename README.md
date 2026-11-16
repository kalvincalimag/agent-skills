# Agent skills

Reusable skills in the open [Agent Skills](https://agentskills.io) format. They work with Claude Code, OpenAI Codex, and any other agent that reads `SKILL.md`. This repository is the source of truth. Clone it into the folder your agent loads skills from, edit skills there, and sync with the `sync-skills` skill.

## Skills

| Folder | Purpose |
| --- | --- |
| `investigate` | Structured investigation |
| `plan` | Planning and design exploration |
| `implement` | Implementation discipline |
| `overhaul` | Repo-wide quality, architecture, and modularity overhauls |
| `test-design` | Test design |
| `bugfix` | Debugging and bug fixes |
| `verify` | Verification and blast radius |
| `ship` | Shipping and pull-request mechanics |
| `writing-discipline` | Writing quality |
| `slack-reply` | Slack reply helper |
| `plain` | Plain-English responses |
| `go-all-out-design` | Explicit-only product design and polish workflow |
| `mascot-design` | Product mascots held to a reference-character quality bar |
| `handoff` | Hand in-progress work to a fresh session or another provider through a brain sync and an opening prompt |
| `standup` | Spoken standup updates, written to the user's standup block |
| `new-brain` | Create a local knowledge brain from brain-template, improving the template first |
| `sync-skills` | Sync the skills folder with this repository, and check every skill |

## Install

Clone the repository straight into your agent's skills folder:

| Agent | Skills folder |
| --- | --- |
| Claude Code | `~/.claude/skills` |
| OpenAI Codex | `~/.agents/skills` |

On macOS or Linux, or in Git Bash on Windows:

```bash
git clone https://github.com/kalvincalimag/agent-skills.git ~/.claude/skills    # Claude Code
git clone https://github.com/kalvincalimag/agent-skills.git ~/.agents/skills    # Codex
```

In PowerShell on Windows:

```powershell
git clone https://github.com/kalvincalimag/agent-skills.git "$HOME\.claude\skills"    # Claude Code
git clone https://github.com/kalvincalimag/agent-skills.git "$HOME\.agents\skills"    # Codex
```

If the skills folder already exists and has skills in it, `git clone` refuses. Turn the folder into a clone in place instead. These commands change no files:

```bash
cd ~/.claude/skills
git init -b main
git remote add origin https://github.com/kalvincalimag/agent-skills.git
git fetch origin
git reset origin/main
git branch -u origin/main
git status
```

`git status` shows how your folder differs from the repository. Run `sync-skills` to settle those differences.

### Use both Claude Code and Codex

Keep one clone and link the other agent's folder to it. Both agents follow linked folders.

On macOS or Linux:

```bash
mkdir -p ~/.agents && ln -s ~/.claude/skills ~/.agents/skills
```

In PowerShell on Windows, a directory junction needs no administrator rights:

```powershell
New-Item -ItemType Directory -Force "$HOME\.agents" | Out-Null
New-Item -ItemType Junction -Path "$HOME\.agents\skills" -Target "$HOME\.claude\skills"
```

### What else lands in the skills folder

The clone also brings this README, the license files, `AGENTS.md`, and Git's own `.git` folder. That is safe. An agent loads a folder as a skill only when it contains a `SKILL.md`, so it ignores top-level files and `.git`. Extra files inside a skill's folder, such as `sync-skills/check.sh`, are allowed by the Agent Skills format.

### Keep the clone somewhere else

Clone the repository wherever you like, then link your agent's skills folder to it with the same commands, swapping in your clone's path as the target.

## Keep in sync

Edit skills in your skills folder, then ask your agent to run `sync-skills`. In Claude Code, type `/sync-skills`. It checks every skill with `bash sync-skills/check.sh`, shows what changed on each side, commits and pushes your edits once you approve, and pulls edits made elsewhere.

## Write a skill

- Put it in `<name>/SKILL.md`, where `name` in the frontmatter matches the folder, and add a `description` that says what the skill does and when to use it.
- Keep it general: no project, client, or person names, no machine paths, and no credentials.
- Some skills use frontmatter fields only Claude Code understands, such as `argument-hint` and `disable-model-invocation`. Other agents may ignore them. `check.sh` lists them as warnings.
- Run `bash sync-skills/check.sh` before syncing.

## Brains

A brain is a local folder that holds curated knowledge for one purpose, such as life admin or a software project. Starting an AI agent in that folder loads the brain's rules and memory index, and the session writes durable knowledge back before it answers. `new-brain` builds brains from [brain-template](https://github.com/kalvincalimag/brain-template). Brains hold knowledge only. Skills stay in your skills folder, which your agent loads in every session, including sessions in a brain.

## License

See `NOTICE.md` and `LICENSE` (MIT). Upstream attributions are required.
