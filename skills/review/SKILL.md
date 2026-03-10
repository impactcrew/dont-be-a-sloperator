---
name: review
description: Run a multi-angle code review using three specialist agents in parallel. Use when the user types /review or when finishing a code task.
argument-hint: [file or area]
---

# /review - Code Review

Run a multi-angle code review on the current branch using three specialist agents in parallel.

## Usage

Type `/review` to review all changes on the current branch against main. Or `/review <specific file or area>` to narrow the scope.

## What it does

Launches three agents simultaneously, each reviewing the same diff from a different angle:

1. **Code Reviewer** - Code quality, bugs, performance problems, maintainability
2. **Security Auditor** - OWASP Top 10, injection risks, auth/authz issues, dependency vulnerabilities
3. **Architect Reviewer** - Structural integrity, design patterns, coupling, scalability

Each agent runs on Sonnet for speed. Results are consolidated into a single report.

## Instructions

Determine the review target:
- If `$ARGUMENTS` is empty, review the full diff of the current branch against `main`
- If `$ARGUMENTS` names a file or directory, scope the review to that area
- If on `main` with uncommitted changes, review the working tree diff

### Step 1: Gather context

```bash
git diff main...HEAD --stat
git diff main...HEAD
```

If `$ARGUMENTS` specifies a scope, filter to those paths.

### Step 2: Launch reviewers

Launch all three agents in parallel using the Agent tool with `run_in_background: true`:

**Agent 1: Code Review**
- subagent_type: "code-reviewer"
- Prompt: "Review this diff for code quality issues. Check for bugs, performance problems, dead code, unclear naming, missing error handling, and adherence to existing code patterns. Prioritize issues by severity. Diff: [include diff]"

**Agent 2: Security Audit**
- subagent_type: "security-auditor"
- Prompt: "Audit this diff for security vulnerabilities. Check for OWASP Top 10 issues, injection risks, authentication/authorization problems, secrets exposure, insecure dependencies, and missing input validation. Prioritize by CVSS-equivalent severity. Diff: [include diff]"

**Agent 3: Architecture Review**
- subagent_type: "architect-review"
- Prompt: "Review this diff for architectural concerns. Check for proper separation of concerns, coupling issues, violated abstractions, missing patterns, scalability risks, and consistency with the existing codebase structure. Diff: [include diff]"

### Step 3: Consolidate results

Once all three agents complete, present a single report:

```
## Review Results

### Critical (fix before merge)
- [list any critical findings from all three agents]

### Important (should fix)
- [list important findings]

### Suggestions (nice to have)
- [list suggestions]

### Clean
- [note any areas all three reviewers found no issues with]
```

If all three agents find nothing, say so: "All three reviewers passed. No issues found."

### Step 4: Offer next steps

After presenting results, ask:
- "Want me to fix any of these?" (if issues found)
- "Ready to commit?" (if clean or after fixes)
