# save-work — a Claude Code skill

[Português](README.pt-BR.md)

Pick up a project in a fresh Claude Code conversation without losing context.

At the end of a task, run `/save-work`. Claude updates a small set of control files at the project root:

| File | Role | How it is updated |
|---|---|---|
| `CLAUDE.md` | Overview, how to run, structure, conventions | Only when something structural changed; obsolete info is removed |
| `TODO.md` | Checklist by priority (P0/P1/P2 + recently done) | Items checked off, added, reprioritized |
| `HANDOFF.md` | Where the session stopped, next step, pitfalls | Overwritten every time |
| `docs/DECISIONS.md` | Decision log (decision, why, discarded alternatives) | Append only |

Then run `/clear`, and in the next conversation say "let's work on project <name>".

The skill records only what actually happened (it checks `git status`/`git log` in repos), makes minimal edits instead of rewriting files, and asks before committing.

## Install

```bash
git clone https://github.com/csnasci/claude-save-work.git
cd claude-save-work
./install.sh          # English
./install.sh pt-BR    # Português
```

Or copy `skills/en/save-work/` (or `skills/pt-BR/save-work/`) to `~/.claude/skills/save-work/` by hand. Re-run the script to update; a previous `SKILL.md` that differs is backed up.

## Optional: resume a project by name

The skill saves the state. To have Claude *read* it back automatically when you mention a project, put your projects under one folder (e.g. `~/Work`) and add the workspace instructions to a `CLAUDE.md` in that folder:

- English: [`workspace/CLAUDE.en.md`](workspace/CLAUDE.en.md)
- Português: [`workspace/CLAUDE.pt-BR.md`](workspace/CLAUDE.pt-BR.md)

Adjust `~/Work` to your folder. Start Claude Code from that folder and say "let's work on project foo": Claude finds `~/Work/foo`, reads `CLAUDE.md`, `HANDOFF.md` and `TODO.md`, tells you where things stand, and treats it as the folder `/save-work` writes to.

Without this, `/save-work` still works; just start Claude Code inside the project and ask it to read `HANDOFF.md` and `TODO.md` (the generated `CLAUDE.md` already tells it to).

## License

[MIT](LICENSE)
