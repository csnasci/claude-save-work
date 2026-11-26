# Workspace ~/Work

Each subfolder of `~/Work` is an independent project. This folder is not a project: never write control files (CLAUDE.md, TODO.md, HANDOFF.md, docs/DECISIONS.md) directly here.

## Active project

When the user mentions a project (by name, even if approximate or spelled differently):

1. Find the matching folder in `~/Work` (also look one level down, e.g. `~/Work/tries/<project>`). If there is more than one candidate or none, ask.
2. BEFORE anything else, read the control files that exist at its root:
   - `CLAUDE.md` (overview, how to run, structure, conventions)
   - `HANDOFF.md` (where the last session stopped and the next step)
   - `TODO.md` (pending items by priority)
   - `docs/DECISIONS.md` (check it when the task touches something already decided)
3. Say in one or two lines where the project stands (last point of HANDOFF + P0 items of TODO) and carry on.
4. Treat that folder as the session's active project: it is where `/save-work` writes.

If the folder has no control files, carry on normally; the first `/save-work` creates them.
