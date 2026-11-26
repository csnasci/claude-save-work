---
name: save-work
description: Saves the active project's state at the end of a task (CLAUDE.md, TODO.md, HANDOFF.md, docs/DECISIONS.md) so a fresh conversation can pick up without losing context. Use when the user runs /save-work or asks to save the project's progress/state before clearing the conversation.
---

# /save-work

Goal: leave the project ready for a fresh conversation (`/clear`) to continue the work without losing context. Write in English, unless the existing files are in another language.

## 1. Identify the active project

- If the session already set an active project (e.g. the user said "let's work on project X"), use that folder.
- Otherwise, infer it from the files read/edited in the conversation and walk up to the repository root (`git rev-parse --show-toplevel`) or, without git, to the project folder.
- If the working directory is already a project root, use it.
- If it is ambiguous (several projects touched, none clear), ask before writing.
- Never write to an "umbrella" folder that groups projects (e.g. `~/Work`).

If the skill argument names a project (`/save-work my-project`), it takes priority.

## 2. Gather what happened (facts, not assumptions)

- The conversation: what was asked, done, decided, discarded and what is still pending.
- If it is a git repository: `git status`, `git diff --stat` and recent `git log`, to confirm what actually changed.
- The current control files, read in full before editing.

Record only what actually happened. Do not invent pending items or decisions.

## 3. Update the files (minimal edits)

Edit only what changed; do not rewrite the files from scratch or "summarize" existing content that is still valid. Create a file only if it does not exist.

### CLAUDE.md (stable, loaded every session: keep it lean)
Sections: **Goal** (what it is for), **How to run** (setup, run, test, build), **Structure** (main folders in a few lines), **Conventions**, and at the end:

```markdown
## Control files
Before starting, read HANDOFF.md and TODO.md. Decisions live in docs/DECISIONS.md.
```

Only change it when something structural changed (new command, new folder, new convention). No history, pending items or session log here.

When updating, fix or remove what the session's work made obsolete (a command that changed, a renamed/removed folder, an abandoned convention), do not just append. Outdated information here is worse than missing information, because every session treats it as truth.

### TODO.md (checklist by priority)
```markdown
# TODO

## P0 — Blocking / urgent
- [ ] Item — short context (file:line if it helps)

## P1 — Important

## P2 — Improvements / tech debt

## Recently done
- [x] Item (YYYY-MM-DD)
```
- Mark as `[x]` and move to "Recently done" what was finished this session, with the date.
- Add new pending items at the right priority; reorder if priorities changed.
- Keep at most ~10 items in "Recently done"; drop the oldest.

### HANDOFF.md (overwritten every time)
```markdown
# Handoff — YYYY-MM-DD

## Where I stopped
## Next step
(concrete action, where to start)
## Watch out
(pitfalls, half-done things, uncommitted state, commands that failed)
```

### docs/DECISIONS.md (append only)
Only if a relevant decision was made this session (architecture, library, approach, trade-off). Do not rewrite old entries. If a decision is reverted or superseded, add a new entry referencing the previous one and mark the old one's title, without touching its body: `## ~~YYYY-MM-DD — Title~~ (superseded on YYYY-MM-DD)`.
```markdown
## YYYY-MM-DD — Short title
**Decision:** ...
**Why:** ...
**Discarded alternatives:** ...
```

Use today's real date in every date.

## 4. Wrap up

- Show a short summary: which files were created/changed and the gist of each change (or the `git diff` of those files, if it is a repo).
- If it is a git repository, ask whether to commit the control files (do not commit without confirmation).
- End by reminding the user they can now run `/clear` and, in the next conversation, say "let's work on project <name>".
