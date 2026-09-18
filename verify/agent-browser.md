# Browser Automation with agent-browser

When a dev server is running or the user asks to verify, test, or interact with a web page, use `agent-browser` to automate the browser.

## Availability gate

Run `command -v agent-browser` before the first browser action. If the CLI is unavailable, use an already available repository-approved browser or Playwright workflow when it can provide equivalent evidence. Otherwise report the missing runtime as a blocker; do not claim manual QA ran. Installing tools or dependencies requires the authorization required by the active repository.

## Core Workflow

Every browser automation follows this pattern:

1. **Navigate**: `agent-browser open <url>`
2. **Snapshot**: `agent-browser snapshot -i` (get element refs like `@e1`, `@e2`)
3. **Interact**: Use refs to click, fill, select
4. **Re-snapshot**: After navigation or DOM changes, get fresh refs

```bash
agent-browser open http://localhost:3000
agent-browser wait --load networkidle
agent-browser snapshot -i
```

## Dev Server Verification

When a dev server starts, use agent-browser to verify it's working:

```bash
# After starting a dev server (next dev, vite, etc.)
agent-browser open http://localhost:3000
agent-browser wait --load networkidle
agent-browser snapshot -i
# Check for errors, verify content is showing
```

If the page is blank or shows an error, check: `agent-browser console` and `agent-browser errors`.

## Commands

```bash
# Navigation
agent-browser open <url>
agent-browser back
agent-browser forward
agent-browser reload

# Snapshot (always use -i for interactive elements with refs)
agent-browser snapshot -i
agent-browser snapshot -i -c          # compact
agent-browser snapshot -i -s "#main"  # scoped

# Interactions (use refs from snapshot)
agent-browser click @e1
agent-browser fill @e2 "text"
agent-browser select @e3 "option"
agent-browser check @e4
agent-browser press Enter
agent-browser hover @e5

# Get information
agent-browser get text @e1
agent-browser get value @e2
agent-browser get url
agent-browser get title

# Wait
agent-browser wait @e1
agent-browser wait --load networkidle
agent-browser wait --url "**/dashboard"

# Diagnostics
agent-browser console
agent-browser errors
agent-browser screenshot /tmp/shot.png

# Network
agent-browser network requests
agent-browser network route "**/api/**"
```

## Semantic Locators

Prefer when the element has accessible names:

```bash
agent-browser find role button click --name "Submit"
agent-browser find text "Sign In" click
agent-browser find label "Email" fill "user@example.com"
```

## Parallel Sessions

Use `--session` for concurrent testing of multiple pages:

```bash
agent-browser --session page1 open localhost:3000
agent-browser --session page2 open localhost:3000/other
```

## Screenshots for Evidence

When verification claims visual state, save a screenshot:

```bash
agent-browser screenshot /tmp/verify-$(date +%s).png
```

Include the path in your verification report.
