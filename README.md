# Don't be a sloperator.

A set of rules that stop AI from writing like AI. Works with [Claude Code](https://docs.anthropic.com/en/docs/claude-code), but the principles apply anywhere you talk to an LLM.

## Who this is for

You use ChatGPT, Claude, or another LLM and you're tired of getting back text that sounds like it was written by a committee of middle managers. You don't have a custom setup. You don't want to build one. You just want the output to stop sounding like a corporate press release.

This is not for engineers who already have their own CLAUDE.md and agent configs. They're fine. This is for everyone else.

**Using Claude Code?** Drop in two files and you're done. **Using ChatGPT?** Copy `CHATGPT.md` into your custom instructions (it's sized to fit). **Using Gemini, Copilot, or anything else?** Read the [Iron Laws](#the-iron-laws) below and paste the ones you like into your custom instructions. The rules are plain English, not config syntax.

## What AI does WITHOUT this"

You: "Write a tagline for my coffee shop in Portland."

AI:
> "Crafted with passion, served with purpose. Your neighborhood coffee destination, designed to elevate every sip into an experience that seamlessly blends artisanal quality with community warmth."<

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
1. It refused to write generic slop. (Law #3: No AI Slop Copy)
2. It asked what makes the shop different before writing a word. (Law #4: Critical Thinking)
3. Every option is specific to THIS shop. Compare that to "crafted with passion, served with purpose."

The Iron Laws replace AI's default people-pleasing with actual judgment.

## Install

**Claude Code:** Copy `CLAUDE.md` to `~/.claude/CLAUDE.md`. Done. Optionally copy `commands/work.md` to `~/.claude/commands/work.md` if you write code.

**ChatGPT:** Copy the contents of [`CHATGPT.md`](CHATGPT.md) into Settings > Personalization > Custom Instructions. It's a condensed version of the Iron Laws, written to fit ChatGPT's 1,500-character limit.

**Gemini, Copilot, or anything else:** Open `CLAUDE.md`, copy the rules, and paste them into your custom instructions. Or paste the file into a conversation and ask "set these as my instructions" and it'll walk you through it.

> **Already have custom instructions?** Merge the rules in instead of replacing what you have.

## The Iron Laws

Ten rules that fix AI's worst habits.

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

## The /work command

Type `/work` followed by a task description to activate a structured 4-phase workflow:

1. **Understand** - Read the brief, ask questions, research what's needed
2. **Plan** - Break the work into sections, present an outline for approval
3. **Execute** - Do the work section by section, checking quality as you go
4. **Verify** - Review against the original brief, check for slop, present results

Each phase has a gate. AI cannot skip to output without understanding the problem first.

The examples in `/work` lean toward software development, but the structure works for anything complex: writing a proposal, planning an event, restructuring a document. For non-coding tasks, it automatically skips the dev-specific steps (agents, TDD, code review) and just gives you the structured thinking. The value is forcing granular reasoning before action. Without it, LLMs skip straight to a mediocre first draft.

## Law tags

You'll see AI tagging its actions like this:

```
[Law #7 - Evidence Over Assertion] Reading the config before diagnosing.
[Law #4 - Critical Thinking] This approach has a flaw. Here's why...
[Law #10 - Fix the Root Cause] This looks like a symptom. Investigating.
```

That's intentional. The tags make the rules visible. You can watch AI following the discipline in real time instead of just hoping it does.

## How is this different from stop-slop?

[stop-slop](https://github.com/hardikpandya/stop-slop) and [anti-slop-writing](https://github.com/adenaufal/anti-slop-writing) maintain lists of banned words and phrases. That works, but it's whack-a-mole: ban "seamlessly" and AI switches to "effortlessly."

The Iron Laws take a different approach. Instead of banning specific words, they change how AI evaluates its own output. "If the copy could describe any product in any industry, it's too generic" is a test AI applies to everything it writes, not a list it checks against.

The anti-slop rules are also just 3 of 10 laws. The rest address deeper problems: people-pleasing, guessing instead of verifying, and band-aid fixes. Those aren't writing problems. They're thinking problems.

## Works with your existing setup

The Iron Laws are a foundation, not a framework. They layer under whatever else you use:

- Your own agents and skills keep working
- Your project-level CLAUDE.md files take precedence for project-specific rules
- The /work command is optional and independent

If a rule doesn't fit your workflow, delete it. If you want to add your own, add them. It's a short markdown file, not a build system.

## License

MIT
