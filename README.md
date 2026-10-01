# Claude Skills

Reusable [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skills pack for cross-project use.

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

## Use in a project

Copy (or symlink) the skill folders you need into that project's `.claude/skills/`, and keep `NOTICE.md` with them — these are MIT-derived works and the notice must travel along.

Example:

```powershell
$pack = 'C:\path\to\claude-skills'
$proj = 'C:\path\to\your-project\.claude\skills'
New-Item -ItemType Directory -Force -Path $proj | Out-Null
foreach ($s in 'investigate','plan','implement','test-design','bugfix','verify','ship','writing-discipline','slack-reply','plain','handoff') {
  Copy-Item -Recurse -Force (Join-Path $pack $s) (Join-Path $proj $s)
}
Copy-Item -Force (Join-Path $pack 'NOTICE.md') (Join-Path $proj 'NOTICE.md')
```

## License

See `NOTICE.md` and `LICENSE` (MIT). Upstream attributions are required.
