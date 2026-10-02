---
name: ship
description: "Use when publishing finished work outward: getting a branch mergeable (failing checks, conflicts, review threads), opening and merging a pull request, verifying the deployed environment serves the merged commit, and deploying a site. Starts after the code is written and locally verified."
---

# Ship

## Purpose

Carry finished, locally verified work through the repository's own delivery path: mergeable branch, pull request, merge, post-merge verification, and deployment — with evidence at every gate and a stop before every outward action.

**This skill does not authorize anything.** Push, pull request, merge, deploy, promotion, DNS change, and repository creation are separate actions with separate authorization requirements. Confirm each one against the user's standing autonomy rule before taking it. Repository instructions and explicit user direction determine the base branch, merge method, environment, and stopping boundary.

Prerequisites: `implement` Part 4 has run against the diff, and `verify` has passed local gates with a recorded baseline.

---

# Part 1 — Get the Branch Mergeable

Fix one actionable failure at a time. Do not bundle a refactor into a CI fix.

## 1.1 Failing checks

1. Resolve the active pull request and list its checks with state, workflow, and link.
2. Open the failed jobs and extract the first actionable error. Use CI logs when available; otherwise follow the check link to identify the failing command or service.
3. Apply the smallest safe fix. Prefer a minimal low-risk change over a broader refactor.
4. Re-run the check set and repeat until green. **The check list is the source of truth for overall state, not a local run.**

Capture the baseline before claiming you fixed something: which checks were failing, by name, before you started. Report the delta, not an impression.

**Report:** the primary failing job and its root error, the fixes in the order applied, and the current status with the next action.

## 1.2 Merge conflicts

1. Detect every conflicting file from git status and from conflict markers in the tree.
2. Resolve each with minimal, correctness-first edits.
3. Prefer preserving both sides when that is safe. Otherwise choose the variant that compiles and keeps public behavior stable.
4. Regenerate lockfiles with the package manager rather than hand-editing them.
5. Run compile, lint, and the relevant tests.
6. Stage the resolved files and summarize the decisions that were not mechanical.

Leave no conflict markers in any file. Do not rewrite history while resolving. Never force push to a shared branch without explicit approval for that specific action. Do not push or tag during resolution.

**Report:** files resolved, the resolution choices a reviewer would question, and the build and test outcome.

## 1.3 Review comments

1. Resolve the active pull request for the current branch.
2. Fetch both review comments and discussion comments.
3. Group the feedback by severity and by whether it is actionable.
4. Return an action list ordered by priority, with open questions separated from work items.

Treat a review comment as a hypothesis, per `verify` 1.4. Automated review bots and security scanners catch real defects and also file non-issues. Assess each on its merits against the actual code, and dismiss noise with a concrete reason rather than churning the diff to satisfy it.

---

# Part 2 — Publish

## 2.1 Preflight

1. Read the repository instructions and identify the required base branch and promotion path. **Do not assume `develop` or `main`.**
2. Confirm the GitHub CLI is available and authenticated: `command -v gh` and `gh auth status`.
3. Inspect `git status --short --branch`, remotes, current branch, upstream, and the latest base tip.
4. Refuse to publish from a detached head or a protected base branch. Create an appropriately named feature branch first.
5. Identify unrelated dirty files and stage only the authorized paths. Never use broad staging when unrelated work exists.
6. Confirm all required local tests, builds, and diff checks have passed for the exact proposed commit.

## 2.2 Pull request

1. Fetch the documented base branch immediately before integration.
2. If the base moved or conflicts exist, integrate its latest tip locally, resolve per Part 1.2, and rerun affected tests plus the full required gate.
3. Review the complete branch diff and the staged diff. Confirm the file list matches the authorized scope.
4. Push the feature branch with an explicit upstream.
5. Reuse an existing open pull request for the same head and base pair, or create a new one with a concise summary, verification evidence, risks, and remaining manual checks. Write it through `writing-discipline`.
6. Wait for every required check. **Pending is not green.** Diagnose failures from evidence; do not retry a flaky check until it happens to pass.
7. Merge only if the user or repository workflow authorizes merging and the pull request is mergeable with required checks green. Follow the repository's merge-method convention.

## 2.3 Post-merge verification

When a merge is authorized:

1. Fetch the base and confirm it contains the expected merge or squash commit.
2. Watch the base-branch workflow for that exact commit. A green pull request does not prove the base branch is healthy.
3. If the repository deploys the base, confirm the deployment serves **that commit** rather than merely returning HTTP 200.
4. Treat post-merge failures as new defects and fix them through `bugfix` and the same branch-and-PR workflow unless the user directs otherwise.

---

# Part 3 — Deployed-Environment QA

Only when deployed QA is in scope. "Done" requires runtime evidence when deployment is in scope, not only local tests.

1. **Confirm the deployed build is the merged commit** through deployment metadata or commit SHA. Poll with a bounded wait; if it has not landed after about 15 minutes, investigate the pipeline instead of assuming.
2. Get the environment URL from repository or deployment truth, not memory.
3. Run the QA pass from `verify` Part 3 and Part 4 at the relevant viewport or device class, plus any API or smoke checks the repository uses.
4. **Evidence required:** the exact workflow steps exercised, console and network errors observed or their absence, and screenshots for visual claims. "Page returned 200" is not QA.
5. If the flow can create real orders, payments, or other irreversible external actions, stop before final submit unless the user explicitly approves the live smoke.

**Fix and repeat.** Every deployed-QA failure is a new bug: capture it with a failing test first, fix it, rerun local gates, merge, wait for deploy, and re-QA. Small related bugs may share one fix branch; unrelated bugs get their own. Re-QA covers the fixed flow **and** the originally requested workflow.

**Cap: 3 full merge-to-deploy-to-QA cycles.** If the environment still fails after 3, stop and report the pattern, the evidence, and the last verified state.

---

# Part 4 — Deploying a Site

Use the project's actual hosting and DNS providers. Do not assume a provider the project does not use; derive the stack from repository and deployment truth. For a Vercel plus GoDaddy stack specifically, `deploy-vercel-godaddy.md` in this skill directory has the command-level detail.

Not every project deploys to a host. A browser extension ships as a packaged build uploaded to its store (the Chrome Web Store for Chrome), or is loaded unpacked for personal use. A mobile app ships through a test track such as TestFlight or Play internal testing before a store release. Each upload, store submission, and release is a separate outward action under 4.1, and the uploaded build must be the exact verified commit.

## 4.1 Hard boundaries

- Preview deployment, production deployment, domain attachment, DNS mutation, CI changes, and repository creation are separate actions with separate authorization.
- **Default to a preview deployment.** Production deployment or promotion requires explicit authority.
- Never place access tokens, API keys, or secret values in tracked files, shell command arguments, tool output, screenshots, session summaries, or pull-request text. Do not ask the user to paste credential values into chat or a repository file.
- Prefer authenticated provider CLIs, connectors, or secure secret-input mechanisms. If required credentials are unavailable, stop and ask the user to configure them through the provider's secure flow.
- **Read DNS before writing it.** Change only the exact approved record names and types. Never modify `NS`, `SOA`, `MX`, SPF, DKIM, DMARC, verification `TXT`, or unrelated records as a side effect.
- Do not create or replace hosting config files, CI workflows, branch settings, or production configuration unless the project actually requires it and the change is approved.
- Do not assume the production branch is `main`; derive it from repository and provider truth.
- Stop before any domain purchase, transfer, nameserver replacement, or destructive DNS action unless the user explicitly requests that exact action.

## 4.2 Confirm before mutation

Project root and repository; framework, package manager, build command, output directory; hosting account or team and target project; intended preview and production branches; apex domain and approved subdomains; the authoritative DNS provider; the exact actions authorized; and the rollback target plus a saved before-state for every record to be changed.

## 4.3 Sequence

1. **Baseline.** Read repository instructions; inspect branch, status, remotes, deployment config, and existing CI. Preserve unrelated dirty work; do not initialize Git or rename a branch in an existing repository. Run the required tests and build, recording existing failures first. Confirm CLIs are installed and authenticated without printing tokens. Confirm provider metadata directories and env files are ignored by Git.
2. **Link the project.** Prefer the existing link. Determine whether the target project already exists before linking, because linking can create external state. Obtain authorization before creating a project. Do not accept CLI defaults that can select or create an unintended project, and do not pass a long-lived token on the command line.
3. **Deploy and verify a preview.** Capture the immutable deployment URL and identifier. Verify the expected commit, build completion and logs, HTTP response across important routes, browser rendering at relevant viewports, console and network errors, protected-route behavior where safe, and server or function errors in the logs. An HTTP 200 alone is not sufficient.
4. **Attach the domain.** Inspect existing domains, add only the approved hostname, and read the provider's *current* required records rather than remembered values. If both apex and `www` are required, decide which is canonical before configuring redirects.
5. **Change DNS safely.** Read the full record set, save a redacted before-state with record IDs, compare against the provider's current requirements, present the record-level delta and rollback values, and get approval. Prefer record-specific APIs using stable record IDs; never replace a whole zone. Read each record back after writing and compare every field. On a conflict, duplicate, unexpected record, or authorization failure, stop rather than broadening the operation.
6. **Verify DNS and HTTPS.** Distinguish provider state, authoritative DNS, public resolver propagation, and application behavior. Use bounded polling and report propagation as pending when it has not converged. Confirm the certificate is valid for every approved hostname, the canonical hostname and redirects are correct, and key routes work over the custom domain.
7. **Promote to production.** Requires explicit authorization and a verified rollback target. Prefer staging a production build without moving the domain when a final gate is needed, then promote that exact deployment. Verify production serves the intended deployment identifier or commit, and record the previous production deployment for rollback.
8. **CI is conditional.** Do not automatically add a workflow. First determine whether the project already uses a Git integration, an existing deployment workflow, protected environments, or branch-scoped settings. If CI changes are required, plan and review them as configuration changes, use encrypted secrets or workload identity, and test preview delivery before enabling production.

## 4.4 Failure and retry

Retry a read after transient failure with bounded backoff. **Before retrying a write, re-read provider state to determine whether the first attempt succeeded.** Never retry repository creation, domain attachment, DNS mutation, or production promotion blindly. A partial deployment is not completion: report the exact last confirmed state and the safest rollback or continuation step.

---

## Stop Boundaries

- Stop at the repository-defined promotion boundary. Do not infer permission for the next environment or branch.
- Do not close, cancel, merge, or replace unrelated pull requests or workflows.
- Stop before destructive, production, financial, or irreversible actions without explicit authorization.

## Handoff

Report the pull-request URL, base and head branches, local and remote checks, conflict resolutions, merge and deploy status if authorized, deployment identifiers, exact DNS records changed with their rollback location, remaining risk, and the actions intentionally left unperformed. Claim only what was directly verified.

## Red Flags — STOP, you are rationalizing

| Excuse | Reality |
|--------|---------|
| "It passes locally" | The check list is the source of truth. |
| "I will fix all the failures at once" | One at a time. Bundled fixes hide which change did what. |
| "The bot flagged it so I will change it" | Assess it. A wrong finding acted on is a real defect introduced. |
| "I will rebase to clean this up" | Not during conflict resolution, and not without authorization. |
| "The lockfile conflict is easy to hand-edit" | Regenerate it. Hand-edited lockfiles fail in ways nobody can read. |
| "The PR is green, the base will be fine" | Verify the base-branch workflow for the merge commit. |
| "The deploy is probably live by now" | Verify the deployed commit SHA. Stale builds pass QA falsely. |
| "Local tests pass, deployed QA is a formality" | Deployed environments catch configuration failures local checks cannot. |
| "I will just update the DNS records" | Read first, save the before-state, show the delta, get approval. |
| "One more fix cycle will do it" (after 3) | A persistent failure pattern is information the user needs. Escalate. |
