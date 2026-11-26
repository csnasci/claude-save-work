#!/usr/bin/env bash
# Install the save-work skill for Claude Code.
#   ./install.sh            English (default)
#   ./install.sh pt-BR      Português
# An existing ~/.claude/skills/save-work/SKILL.md is backed up first.
set -euo pipefail

LANG_DIR="${1:-en}"
SRC="$(cd "$(dirname "$0")" && pwd)/skills/$LANG_DIR/save-work"
DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills/save-work"

if [[ ! -f "$SRC/SKILL.md" ]]; then
  echo "unknown language '$LANG_DIR' (use: en, pt-BR)" >&2
  exit 1
fi

mkdir -p "$DEST"
if [[ -f "$DEST/SKILL.md" ]] && ! cmp -s "$SRC/SKILL.md" "$DEST/SKILL.md"; then
  backup="$DEST/SKILL.md.bak.$(date +%Y%m%d%H%M%S)"
  mv "$DEST/SKILL.md" "$backup"
  echo "backed up previous skill -> $backup"
fi
cp "$SRC/SKILL.md" "$DEST/SKILL.md"
echo "installed ($LANG_DIR) -> $DEST"
