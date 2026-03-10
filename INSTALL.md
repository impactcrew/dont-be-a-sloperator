# Agents, Skills, and Customization

This guide covers what gets installed, how agents and skills work, and how to write your own.

## Quick install

```bash
./install.sh
```

Or manually:

```bash
cp CLAUDE.md ~/.claude/CLAUDE.md
cp agents/*.md ~/.claude/agents/
cp -r skills/* ~/.claude/skills/
```

You can also install at the project level instead of globally:

```bash
# Project-level (lives in .claude/, can be checked into version control)
cp agents/*.md .claude/agents/
cp -r skills/* .claude/skills/
```

Project-level configs only apply when you're working in that project. User-level (`~/.claude/`) configs apply everywhere.

## What gets installed

### Agents

Agents are specialist personas that Claude Code can delegate work to. Each one runs as a sub-agent with its own context and instructions.

| Agent | File | What it does |
|-------|------|-------------|
| Code Reviewer | `code-reviewer.md` | Finds bugs, performance issues, code smells, and quality problems |
| Security Auditor | `security-auditor.md` | OWASP scanning, dependency vulnerabilities, auth review, compliance |
| Architect Reviewer | `architect-review.md` | Design patterns, coupling, boundaries, scalability |

### Skills

Skills are slash commands you type in Claude Code. They expand into structured prompts that tell Claude what to do step by step. Each skill lives in its own directory with a `SKILL.md` file inside.

| Skill | Directory | What it does |
|-------|-----------|-------------|
| /review | `skills/review/` | Launches all three review agents in parallel against your current branch |

## How agents work

An agent is a markdown file with YAML frontmatter. The frontmatter tells Claude Code when and how to use it. The body is the agent's system prompt.

Here's the minimum:

```markdown
---
name: my-agent
description: When Claude should use this agent. Be specific.
---

You are an expert in [whatever this agent does].

## What you check for
- Thing one
- Thing two

## How you respond
Structured findings, prioritized by severity.
```

Put it in `~/.claude/agents/my-agent.md` and Claude Code will use it whenever the description matches what's needed.

### Key frontmatter fields

| Field | Required | What it does |
|-------|----------|-------------|
| `name` | Yes | Identifier for the agent |
| `description` | Yes | Tells Claude when to use this agent. The more specific, the better the routing. |
| `model` | No | Which model to use: `sonnet`, `opus`, `haiku`. Defaults to inheriting from parent. |
| `tools` | No | Allowlist of tools the agent can use (e.g., `Read, Grep, Glob, Bash`). Inherits all if omitted. |
| `disallowedTools` | No | Denylist. Remove specific tools from the inherited set. |
| `maxTurns` | No | Maximum agentic turns before the agent must return a result. |
| `isolation` | No | Set to `worktree` to run in an isolated git worktree. Good for agents that write code. |

### Where agents live

Claude Code checks multiple locations, in priority order:

1. **CLI flag** (`--agents path/`) - session only
2. **Project level** (`.claude/agents/`) - shared via version control
3. **User level** (`~/.claude/agents/`) - personal, applies to all projects

If the same agent name exists at multiple levels, the higher-priority location wins.

## How skills work

A skill is a directory containing a `SKILL.md` file. The directory name becomes the `/slash-command`. A directory called `review/` with a `SKILL.md` inside becomes `/review`.

Skills can have YAML frontmatter for configuration, and the body contains the instructions Claude follows when the skill is invoked.

```markdown
---
name: my-skill
description: What this skill does and when to use it.
argument-hint: [target]
---

# /my-skill - Short description

Instructions for what Claude should do when the user types /my-skill.

You can use $ARGUMENTS to reference whatever the user typed after the command name.

## Step 1: Do the first thing
...

## Step 2: Do the next thing
...
```

### Key frontmatter fields

| Field | Required | What it does |
|-------|----------|-------------|
| `name` | No | Identifier for the skill. Defaults to the directory name. |
| `description` | No | Tells Claude what this skill does. Helps with automatic invocation. |
| `argument-hint` | No | Shows in autocomplete to hint what argument the skill expects. |
| `disable-model-invocation` | No | Set to `true` if only the user should be able to invoke this skill (not Claude automatically). |
| `allowed-tools` | No | Restrict which tools are available when this skill runs. |
| `model` | No | Which model to use: `sonnet`, `opus`, `haiku`. |

### String substitutions

Inside a skill's markdown, you can use:

- `$ARGUMENTS` - everything the user typed after the command name
- `$ARGUMENTS[0]`, `$ARGUMENTS[1]` - specific arguments by index
- `${CLAUDE_SESSION_ID}` - current session ID
- `${CLAUDE_SKILL_DIR}` - directory containing the SKILL.md file

### Where skills live

Same priority as agents:

1. **Project level** (`.claude/skills/`) - shared via version control
2. **User level** (`~/.claude/skills/`) - personal, applies to all projects

Skills also support monorepo discovery. If you're editing a file in `packages/frontend/`, Claude Code automatically finds skills in `packages/frontend/.claude/skills/`.

### Skills can include supporting files

A skill directory can contain more than just SKILL.md:

```
my-skill/
  SKILL.md        (required)
  reference.md    (optional, extra context)
  examples.md     (optional, examples)
  scripts/        (optional, helper scripts)
```

## Writing your own agent

Start with a real problem. "I keep having to remind Claude to check X" is a good sign you need an agent for X.

### Tips

**Be specific in the description.** "Use PROACTIVELY for security audits" is better than "Helps with security." The description is how Claude Code decides whether to use the agent.

**Don't over-constrain tools.** Only restrict the `tools` field if the agent genuinely shouldn't have access to something. Most agents work best with full tool access.

**Use `model: sonnet` for review agents.** Review work is high-volume, moderate-complexity. Sonnet is fast enough to run three agents in parallel without the user waiting forever. Use `opus` for agents that need deep reasoning.

**Test by asking Claude to use it.** Say "use the code-reviewer agent to review this file" and see what happens. Iterate on the system prompt based on the results.

### Example: a documentation reviewer

```markdown
---
name: docs-reviewer
description: Reviews documentation for accuracy, completeness, and clarity. Use PROACTIVELY when docs are modified.
model: sonnet
---

You are a documentation reviewer. Check docs for:

## Accuracy
- Do code examples actually work?
- Do descriptions match current behavior?
- Are version numbers and dates current?

## Completeness
- Are all parameters documented?
- Are edge cases covered?
- Are prerequisites listed?

## Clarity
- Can a new user follow the instructions without guessing?
- Are steps in logical order?
- Is jargon defined or avoided?

## Response format
List findings by severity: errors (wrong information), gaps (missing information), suggestions (could be clearer).
```

## Writing your own skill

Skills are good for repeatable workflows. If you find yourself giving Claude the same multi-step instructions across projects, that's a skill.

### Example: a deploy checklist

Create `~/.claude/skills/pre-deploy/SKILL.md`:

```markdown
---
name: pre-deploy
description: Run pre-deployment checks on the current branch.
---

# /pre-deploy - Pre-deployment checklist

Run through the pre-deployment checklist for the current branch.

## Step 1: Check branch state
- Verify we're on a feature branch, not main
- Check for uncommitted changes
- Verify the branch is up to date with main

## Step 2: Run tests
- Run the full test suite
- Report any failures

## Step 3: Check for common issues
- Look for console.log / print statements in the diff
- Check for TODO or FIXME comments in changed files
- Verify no .env or credentials files are staged

## Step 4: Report
Present a pass/fail summary. If anything failed, list what needs fixing before deploy.
```

## Further reading

- [Claude Code Agents docs](https://docs.anthropic.com/en/docs/claude-code/sub-agents)
- [Claude Code Skills docs](https://docs.anthropic.com/en/docs/claude-code/skills)
- [Claude Code Hooks docs](https://docs.anthropic.com/en/docs/claude-code/hooks)
