---
name: disk-cleanup
description: "Use when the user wants to free disk space on their own computer, or asks what is safe to delete: stale git worktrees, build caches, package stores, crash dumps, temp files, container data. Measures before deleting, removes only what can be regenerated or is already saved elsewhere, keeps anything a running session or unsaved work depends on, and hands the user the items that are theirs to decide. Not for the cleanup at the end of a task, where an agent removes only what that task created."
---

# Disk cleanup

## Purpose

Free real disk space on the user's computer without losing work or breaking a session that is still running. Folder sizes mislead: shared package stores, hard links and container disk images make some folders look far bigger than what deleting them frees, and others hide space that never comes back on its own. So measure, classify, delete in small steps, and report what the free space actually did.

## Boundaries

- Deleting cannot be undone. Without asking, delete only items in the two safe classes below, and only after their checks pass. List everything else for the user, with its size and the exact steps.
- Never delete uncommitted changes, commits that are not on a remote, user documents and media, browser profiles, installed apps or games, or anything a running session or process is using.
- Before deleting a folder, list the links inside it and where they point. Delete with a command that removes a link without following it.
- Never weaken a safety check to free more space.

## Steps

1. **Baseline.** Record the free space on each drive. Every later claim is measured against it.
2. **Measure, top down.** Size the home folder's children, then recurse into anything over about 1 GB, and check the system-wide locations the OS reference lists. Use a tool that does not follow links. Sizes counted per path overcount hard-linked files, so treat them as an upper bound.
3. **Find what is live.** List the running agent sessions, dev servers, test runners and containers. For each candidate folder, check whether a running session's recent log names it, or whether a process works inside it. Folders modified in the last few hours count as live until shown otherwise.
4. **Classify every large item.**
   - **Safe, can be regenerated:** build output and caches (`.next`, `dist`, `.turbo`, coverage and test reports), crash dumps, installer leftovers in the temp folder with no installer running, old app update installers, stray copies of a package store, container build cache older than a day, and unused anonymous container volumes.
   - **Safe after checks, git worktrees:** `git status --porcelain` is empty, `git branch -r --contains HEAD` lists a branch, no running session uses it, and no other folder links into it (for example, other worktrees whose `node_modules` point at this one).
   - **The user's call:** apps and games, app caches the user may want (offline music, notes, chat), browser data and on-device models, the hibernation file, SDKs and toolchains, personal projects, the recycle bin, and container disk compaction that needs the container engine stopped.
   - **Leave alone:** OS-managed folders, the page file, and anything with unsaved work. The OS's own cleanup tool handles system files.
5. **Delete one item at a time.** Measure free space before and after each item, and record the change as the amount freed. Run long deletions in the background; a folder with hundreds of thousands of small files can take minutes.
6. **Verify what was shared.** Check that whatever the deleted folders shared with others still works: a sample package in the `node_modules` of each remaining worktree, a sample file in the package store, the main checkout.
7. **Report.** Give a table of what was freed, a list of what was kept and why, and the user's choices with sizes and exact steps. State the final free space against the baseline.

## Gotchas

- **Hard links make worktrees look huge.** pnpm, and some other package managers, hard-link `node_modules` files to one shared store. A worktree that shows 2 GB may free 0.2 GB. The free-space change is the real number.
- **`git worktree remove` can stop halfway.** When it cannot delete `node_modules`, it has already unregistered the worktree and deleted part of the folder. Delete `node_modules` first with a command that does not follow links, then run `git worktree remove`.
- **Container disk images only grow.** Pruning frees space inside the image file, not on the host. Shrinking the file needs the engine stopped, so it is the user's call while any session uses containers.
- **Prune caches by age.** For example, `docker builder prune -f --filter until=24h` keeps the cache that running work just built. `docker volume prune -f` removes only unused anonymous volumes; named volumes need `-a`, so leave them unless the user asks.
- **Crash dumps recur.** A large crash-dump folder means something keeps crashing, often a memory-starved process in a container or VM. Tell the user, since the space will fill again.
- **Low memory can stop a background deletion halfway.** Some agent hosts stop background commands when the computer runs short of memory, which can leave a folder half deleted. When free memory is low, delete one item per foreground command, and check the item that was being deleted when a run stopped.
- **The container disk image can outweigh everything else.** On one laptop, 26 finished worktrees freed about 3 GB, while compacting Docker's disk image freed 53 GB. Measure the disk image early, and offer compaction even when the worktree list looks bigger.

## References

- [Windows](references/windows.md): measuring without following junctions, deleting safely, the usual large folders, and compacting Docker Desktop's disk image.
