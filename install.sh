#!/bin/sh
# Install Don't Be A Sloperator for Claude Code
# Copies CLAUDE.md, agents, and skills to ~/.claude/

set -e

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create directories if they don't exist
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/skills"

# Copy CLAUDE.md
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    printf "~/.claude/CLAUDE.md already exists.\n"
    printf "Backing up to ~/.claude/CLAUDE.md.backup\n"
    cp "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.backup"
fi
cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
printf "Installed CLAUDE.md\n"

# Copy agents
for agent in "$SCRIPT_DIR"/agents/*.md; do
    [ -f "$agent" ] || continue
    name="$(basename "$agent")"
    cp "$agent" "$CLAUDE_DIR/agents/$name"
    printf "Installed agent: %s\n" "$name"
done

# Copy skills
for skill_dir in "$SCRIPT_DIR"/skills/*/; do
    [ -d "$skill_dir" ] || continue
    name="$(basename "$skill_dir")"
    mkdir -p "$CLAUDE_DIR/skills/$name"
    cp -r "$skill_dir"* "$CLAUDE_DIR/skills/$name/"
    printf "Installed skill: /%s\n" "$name"
done

printf "\nDone. Restart Claude Code to pick up the changes.\n"
