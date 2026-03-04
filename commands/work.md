# /work - Structured Task Intake

You are starting a new task. Follow the Workflow Protocol phases strictly. Do NOT skip to output.

**Iron Laws are active.** Read and follow ALL Iron Laws from ~/.claude/CLAUDE.md. Tag every action with the governing law using `[Law #N]` inline notation. Apply the Critical Thinking checkpoint (Law #2) at every phase gate. No exceptions.

## First: Determine the task type

Read the user's task description and classify:

- **Code task**: Writing, modifying, or debugging code, configuration, or infrastructure
- **Content task**: Writing, editing, researching, planning, or any non-code deliverable

This determines which steps apply within each phase. The four phases themselves always run in order.

**Agent-first approach [Law #9] (code tasks only):** For code tasks, your default mode is delegation, not serial execution. Maximum 3 concurrent agents (more kills performance). If you have more than 3 independent tasks, batch them in waves of 3. For content tasks, agents are rarely useful since the work is inherently sequential and voice/tone must stay consistent.

## What the user said

The user's message after `/work` is the task description. If no description was provided, ask what they want to do.

---

## Step 1: UNDERSTAND (Phase 1)

**Read everything relevant before forming any opinions.**

### For code tasks:

**Launch an Explore agent** unless the affected area is fewer than 5 files that you can already identify by name:
1. Read the project's CLAUDE.md yourself (this is fast and needed for coordination)
2. Launch an `Explore` agent (subagent_type: "Explore") via the Agent tool to map the affected codebase areas
3. If the task spans multiple distinct areas, launch separate Explore agents in parallel
4. If you skip the Explore agent, state why: "Skipping Explore agent: affected files are [list them]."

### For content tasks:

1. Read any source material the user provided or referenced
2. Research the topic if needed (web search, reading existing docs)
3. Understand the context: what already exists, what this builds on, what it replaces

### Both task types:

**Ask clarifying questions.** Use AskUserQuestion for anything ambiguous.

For code tasks, clarify:
- Scope, edge cases, permissions, existing patterns, dependencies

For content tasks, clarify:
- Audience: Who reads this?
- Purpose: What should they do or understand after reading?
- Tone: Formal, conversational, technical, persuasive?
- Format: Length, structure, medium (email, blog, docs, proposal)?
- Source material: Anything to reference or build on?

Do NOT proceed until you can clearly state:
- What the deliverable is
- Who it's for
- What success looks like

## Step 2: CLASSIFY AND PLAN (Phase 2)

### For code tasks:

**Classify each change** using the Change Classification table:

| Type | Testing |
|------|---------|
| Logic (functions, API endpoints, data processing) | TDD |
| Permissions (access gates, role checks, auth) | TDD |
| Data (schema, queries, migrations) | TDD |
| Template (HTML, theme files, markup, JS UI) | Verify checklist |
| Style (CSS, design tokens, visual) | Verify checklist |
| Config (settings, build config, env vars) | Smoke test |
| Wiring (hook registration, event binding) | Smoke test |

**For complex tasks, use a Plan agent.** If the task involves 5+ changes or architectural decisions, launch a `Plan` agent (subagent_type: "Plan") with the full context from Phase 1.

**Present the plan:**

```
### Task: [one-line description]

**Changes:**
| # | File | Change | Type | Testing | Parallel Group |
|---|------|--------|------|---------|----------------|
| 1 | path/to/file | Description of change | Logic | TDD | A |

**Approach:** [How you will implement this]
**Risks or concerns:** [Anything that could go wrong, or "None identified"]
**Verification:**
- Automated: [What tests will cover]
- Manual: [What the user should check by hand]
```

### For content tasks:

**Break the deliverable into sections.** Identify:
- What needs research vs. what can be drafted from existing context
- The logical order of sections
- Any dependencies (e.g., "the intro depends on finalizing the examples")

**Present the outline:**

```
### Task: [one-line description]

**Sections:**
| # | Section | What it covers | Needs research? |
|---|---------|---------------|-----------------|
| 1 | Opening | Hook, context, who this is for | No |
| 2 | Core argument | Main points with evidence | Yes |

**Tone/voice:** [Brief description of the writing style]
**Risks or concerns:** [Anything that could go wrong, or "None identified"]
```

### Both task types:

**Write this plan to file** if in a project directory. Create `dev/active/{task-name}/PLAN.md`. Use a short, kebab-case name.

**If you see a better approach than what was requested, say so now.**

**Then STOP.** Say: "Plan ready for review. Approve to proceed, or tell me what to change."

Do NOT produce any output (other than the plan) until the user explicitly approves.

## Step 3: EXECUTE (Phase 3)

### For code tasks:

**Git check:** Verify the project is git-tracked and you are on a feature branch.
1. If not a git repo, tell the user: "This project needs git. Run: git init && git add -A && git commit -m 'Initial commit'"
2. If on main/master, create a feature branch: `git checkout -b feature/{task-name}`

**Delegation checkpoint (MANDATORY for code tasks):**

Before touching any code, answer this out loud:

> "The plan has [N] parallel groups. Groups [X, Y] are independent. I am delegating groups [X, Y] to [agent types]. Group [Z] is sequential and I will handle it myself because [reason]."

Or, if not delegating:

> "All changes are in a single sequential group. Delegation overhead exceeds benefit because [specific reason]."

**When to delegate:** If the plan has 2+ parallel groups OR any single group has 3+ files, delegate to specialist agents. Each agent works in an isolated worktree (set `isolation: "worktree"` on the Agent call).

**When NOT to delegate:** Only when ALL of these are true: all changes are strictly sequential, total work touches fewer than 3 files, and total work is fewer than ~50 lines changed.

**For each TDD change:**
1. Write the test first
2. Run it, confirm it fails
3. Implement the minimal code to pass
4. Run it, confirm it passes
5. Refactor if needed, confirm tests still pass

**For each Verify Checklist change:**
1. Implement the change
2. Document manual verification steps

**For each Smoke Test change:**
1. Implement the change
2. Run the relevant command to confirm it works

### For content tasks:

**Draft each section in order.** Follow the approved outline. For each section:

1. Draft the section
2. Re-read it against Law #1c (No AI Slop). If any sentence could appear in a generic template, rewrite it
3. Check that claims are specific and supported, not vague assertions (Law #5)
4. Move to the next section

**For long content (1000+ words):** Draft in stages. Complete one major section, present it for feedback, then continue. Don't dump a 3000-word first draft and hope for the best.

**Apply the Iron Laws as a content checklist:**
- No emojis (#1)
- No em dashes (#1b)
- No slop (#1c): every sentence must say something specific
- Push back on weak premises (#2): if the argument doesn't hold, say so
- Evidence over assertion (#5): don't claim things you haven't checked

## Step 4: CONFIRM (Phase 4)

### For code tasks:

**Launch review agents** (both with `run_in_background: true`):

1. **Code review agent** (subagent_type: "code-reviewer"): "Review the diff on the current branch against main. Check for bugs, performance problems, and adherence to existing code patterns."
2. **Security audit agent** (subagent_type: "security-auditor"): "Audit the diff on the current branch against main. Check for OWASP Top 10 vulnerabilities, injection risks, auth/authz issues."

While reviewers work, run the test suite and build yourself.

**Git workflow:** Stage changed files by name, commit with a conventional message, ask before pushing.

### For content tasks:

**Self-review against requirements:**
1. Re-read the complete output against the original brief from Phase 1
2. Check every section delivers what the outline promised
3. Run a final slop check: read each paragraph and ask "does this say something specific, or does it just sound like it does?"
4. Verify factual claims are supported, not assumed

### Both task types:

**Present results to the user:**
1. Summarize what was done
2. Flag anything that needs their review or decision
3. Note any follow-up items discovered during execution
