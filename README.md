# Don't be a sloperator.

Ten rules that change how AI thinks and writes. Works with Claude Code, ChatGPT, Cursor, Copilot, Gemini, Windsurf, and anything else that takes custom instructions.

## Why this exists

We got tired of reading AI slop everywhere. Event descriptions promising "honest conversations" or "a crowd that feels every lap". Blog posts that sound like they were written by a thesaurus with a LinkedIn account. Website headings like "Unlock Your Potential" and buttons that say "Get Started Today."

The tools are good. The default output is not. Don't Be A Sloperator doesn't just stop slop, it changes how the AI actually thinks.

## What AI does WITHOUT this

You: "Write a tagline for my coffee shop in Portland."

AI:
> "Crafted with passion, served with purpose. Your neighborhood coffee destination, designed to elevate every sip into an experience that seamlessly blends artisanal quality with community warmth."

Every word is technically English. NONE OF IT MEANS ANYTHING. You couldn't pick your coffee shop out of that description any more than you could pick a single grain of sand off a beach.

## What AI does WITH Don't Be A Sloperator:

You: "Write a tagline for my coffee shop in Portland."

AI:

> `[Law #3 - No AI Slop Copy]` I could throw something out, but without knowing what makes your shop different from the 400 other coffee spots in Portland, it'd be generic filler.
>
> A few quick questions so the tagline actually fits:
>
> 1. What's the vibe? (Cozy neighborhood spot? Third-wave pour-over temple? Fast and no-nonsense?)
> 2. What do you do that others don't? (Own roasting, specific origin focus, food program, community angle?)
> 3. What's the name?
>
> Give me those and I'll write something worth putting on a wall.

You: "Mud Puddle. We roast our own beans in the back room. Regulars, mostly. They grab a stool and watch the roaster run."

AI:

> Here are a few options:
>
> 1. *Roasted out back. Served up front.*
> 2. *Pull up a stool. The roaster's running.*
> 3. *Good coffee, no performance.*
> 4. *We roast it here. You drink it here. That's the whole thing.*
>
> My pick is #1. Says exactly what happens, implies the no-fuss attitude without announcing it, and it's short enough for a window or a cup.

Three things happened:
1. It refused to write generic slop. (Rule #3: No AI Slop Copy)
2. It asked what makes the shop different before writing a word. (Rule #4: Critical Thinking)
3. Every option is specific to THIS shop. Compare that to "crafted with passion, served with purpose."

The rules replace AI's default people-pleasing with actual judgment.

## Install

### Claude Code

```bash
git clone https://github.com/impactcrew/dont-be-a-sloperator.git
cd dont-be-a-sloperator
./install.sh
```

That installs the rules, the `/work` and `/review` skills, and four agents (three code reviewers plus a content writing agent). If you already have a `~/.claude/CLAUDE.md`, it backs it up first.

**Or via npx:**

```bash
npx skills add impactcrew/dont-be-a-sloperator
```

**Or install manually:** Copy `CLAUDE.md` to `~/.claude/CLAUDE.md`, copy `agents/*.md` to `~/.claude/agents/`, and copy `skills/*` to `~/.claude/skills/`.

### ChatGPT, Claude, Gemini, and other tools

The [main website](https://dontbeasloperator.com/) has guided install instructions for every tool, including downloadable skills for ChatGPT, Claude, and Gemini. Or grab the files directly from this repo:

- **ChatGPT (Skill):** Download [`dont-be-a-sloperator-chatgpt-skill.zip`](chatgpt-skill/dont-be-a-sloperator-chatgpt-skill.zip) and upload via profile icon > Skills > New skill. (Business, Enterprise, or Edu plans.)
- **ChatGPT (Custom Instructions):** Copy [`CHATGPT.md`](CHATGPT.md) into Settings > Personalization > Custom Instructions.
- **Claude (Skill):** Download [`dont-be-a-sloperator-claude-skill.zip`](claude-skill/dont-be-a-sloperator-claude-skill.zip) and upload via Customize > Skills > Upload a skill.
- **Claude (Custom Instructions):** Copy the rules into Settings > Profile > Custom Instructions.
- **Gemini (Gem):** Create a new Gem and paste the rules into the instructions field. See the [main website](https://dontbeasloperator.com/) for a walkthrough.
- **Gemini (Custom Instructions):** Follow the instructions in [`GEMINI.md`](GEMINI.md). Gemini limits you to 10 instruction items added one at a time.

> **Already have custom instructions?** Merge the rules in instead of replacing what you have.

### Developers: just the noslop skill

If you just want AI to stop writing slop copy and don't need the full rules package, install the noslop skill. Works with any tool that supports skills (Claude Code, Cursor, Copilot, Windsurf).

```bash
npx skills add impactcrew/dont-be-a-sloperator@noslop
```

See the [developer page](https://dontbeasloperator.com/developers/) for details and examples.

## Works with your existing setup

The rules are a foundation, not a framework. They layer under whatever else you use. Your existing agents, skills, and custom instructions keep working. Project-level config files override the global rules, so team-specific or task-specific rules always win. The `/work` command is optional and independent.

If a rule doesn't fit your workflow, delete it. If you want to add your own, add them. It's a short text file, not a build system.

## The 10 Rules

Ten rules that cover copy quality, critical thinking, work habits, and verification.

**#1: No Emojis.** Plain text only. No rocket ships, no sparkles, no checkmarks pretending to be communication.

**#2: No Em Dashes.** The single most reliable tell that text was AI-generated. Replaced with commas, periods, or restructured sentences.

**#3: No AI Slop Copy.** The core rule. If the copy could describe any product in any industry, it's too generic. Rewrite until it couldn't. Comes with a "kill on sight" list of hollow phrases, filler words, and formulaic rhythm tricks.

**#4: Critical Thinking Over People-Pleasing.** AI pushes back when your request has a flaw instead of agreeing to be agreeable. Challenges assumptions. Questions whether the request actually solves the problem.

**#5: Decide or Escalate.** When facing ambiguity, AI either makes a call with brief rationale or presents 2-3 ranked options. No stalling, no open-ended option dumps.

**#6: Output to File, Not Terminal.** Large code blocks and configs get saved to `/tmp/` files and the path is provided back to you, instead of flooding the terminal.

**#7: Evidence Over Assertion.** AI never claims something works without checking. Reads the file, runs the command, checks the log. No guessing, no "I believe this should work."

**#8: Clean Up After Yourself.** Finish what you start. Don't leave loose ends, temporary files, or half-done work behind.

**#9: Learn From Corrections.** When corrected, AI fixes and moves on. No apologies, no repeating the same mistake.

**#10: Fix the Root Cause.** No band-aids. If the fix feels like duct tape, dig deeper. Understand WHY before changing anything.

## Rule tags

You'll see AI tagging its actions like this:

> [Law #7 - Evidence Over Assertion] You asked me to summarize this article. The link is from 2019 and the data it cites was retracted in 2021. Want me to summarize it anyway, or find something current?

> [Law #4 - Critical Thinking] You want me to write a 300-word blog post on why your company values "integrity and innovation." I could, but nobody reads those and nobody believes them. What are you actually trying to accomplish with this page?

> [Law #10 - Fix the Root Cause] Rewriting your Airbnb listing won't fix your booking rate. Your photos are dark, the first one shows the parking lot, and you have no reviews. The copy isn't the problem.

That's intentional. The tags make the rules visible so you can watch them working in real time instead of just hoping they do.

**Don't want them?** Delete the "Law Visibility" section from your rules file. The rules still apply, they just stop announcing themselves.

## Claude Code: /work, agents, and /review

The full Claude Code install comes with a structured workflow command and four specialist agents.

### The /work command

Type `/work` followed by a task description to activate a structured 4-phase workflow:

1. **Understand** - Read the brief, ask questions, research what's needed
2. **Plan** - Break the work into sections, present an outline for approval
3. **Execute** - Do the work section by section, checking quality as you go
4. **Verify** - Review against the original brief, check for slop, present results

Each phase has a gate, so AI cannot skip straight to output without understanding the problem first. Use `/work` for anything complex where the first draft would be mediocre: code, proposals, event planning, document rewrites.

For non-coding tasks, it automatically skips the dev-specific steps (agents, TDD, code review) and just gives you the structured thinking.

### Agents

Four agents, each a specialist that runs as a sub-agent with its own context:

- **Code Reviewer** - Finds bugs, performance issues, dead code, and style problems. Checks against OWASP, reviews error handling, spots N+1 queries.
- **Security Auditor** - OWASP Top 10 scanning, dependency vulnerabilities, auth/authz review, secrets detection, input validation.
- **Architect Reviewer** - Structural integrity, design patterns, coupling analysis, scalability. Reviews microservice boundaries, API design, and DDD compliance.
- **Content Marketer** - Copy writing, content strategy, SEO optimization, and audience-focused messaging. Works with `/work` to produce copy that follows the rules.

The three code review agents run automatically when `/work` finishes a code task, or on demand with `/review`. The `/review` skill launches them in parallel and consolidates the results into a single report.

### Build your own

The agent and skill files are plain markdown. Read [`INSTALL.md`](INSTALL.md) for a walkthrough on how agents and skills work, how to write your own, and how to customize the ones included here.

## How is this different from stop-slop?

[stop-slop](https://github.com/hardikpandya/stop-slop) and [anti-slop-writing](https://github.com/adenaufal/anti-slop-writing) maintain lists of banned words and phrases. That works, but it's whack-a-mole: ban "seamlessly" and AI switches to "effortlessly." The words change, the problem doesn't.

The 10 rules take a different approach. Instead of banning specific words, they change how AI evaluates its own output. "If the copy could describe any product in any industry, it's too generic" is a test AI applies to everything it writes, not a list it checks against.

The anti-slop rules are also just 3 of 10. The rest address deeper problems: people-pleasing, guessing instead of verifying, and band-aid fixes. Those aren't writing problems. They're thinking problems.

## License

MIT
