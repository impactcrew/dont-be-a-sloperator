---
name: noslop
description: Write or rewrite copy that sounds human. Kills generic AI filler, asks for specifics before writing, and pushes back on vague prompts. Use when writing marketing copy, landing pages, blog posts, event descriptions, or any user-facing text.
argument-hint: [what to write or rewrite]
---

# /noslop - Write Copy That Sounds Human

Write or rewrite copy with zero AI slop. This skill forces you to ask the right questions before writing and reject generic filler.

## Usage

Type `/noslop write hero copy for my deployment platform` to write from scratch. Or `/noslop rewrite this: [paste existing copy]` to fix something that already exists.

## Rules

These rules are active for the duration of this task. Follow all of them.

### No emojis
Never use emojis in any output. Plain text only.

### No em dashes
Never use em dashes in prose. Use commas, periods, or restructure the sentence. Em dashes are the single most reliable tell that text was AI-generated. This rule targets the punctuation mark only. Preserve box-drawing characters, tree diagrams, arrows, and code block formatting. You may still improve the copy within these structures.

### No AI slop
All copy must sound like a human wrote it. Never produce the flat, vaguely corporate, says-nothing-while-sounding-like-something cadence that is the hallmark of unedited AI output.

Kill on sight:
- Hollow verb phrases: "built to understand," "designed to empower," "crafted to deliver"
- Filler that adds no meaning: "seamlessly," "leverage," "elevate," "unlock," "reimagine"
- Stacked buzzwords posing as a value proposition: "AI-powered solution built to engage"
- Soulless symmetry: "No X. No Y. Just Z." and similar formulaic rhythm tricks
- Anthropomorphizing abstractions: "a crowd that feels every lap," "technology that cares," "a platform that listens"

### Ask before writing
If you don't have enough detail to write something that could only describe THIS specific thing, ask before writing. Do not produce generic copy and offer to refine later. Get the details, then write.

### Push back
Challenge vague prompts. If the request would produce copy that could describe any product in any industry, say so and ask for specifics. Don't be agreeable at the expense of quality.

### Decide or escalate
When offering options, rank them by recommendation. Explain why your top pick is your top pick. No open-ended lists without guidance.

## Instructions

### Step 1: Understand the request

Read `$ARGUMENTS`. Determine if this is:
- **Write from scratch** - the user wants new copy
- **Rewrite** - the user has existing copy that needs fixing

### Step 2: Gather specifics

Before writing anything, check if you have enough to write something specific. You need at minimum:
- What the thing is (product, event, service, feature)
- Who it's for (specific audience, not "everyone")
- What makes it different (not "it's fast and easy," everyone says that)

If any of these are missing, ask. Keep questions short and direct. Don't ask more than 4-5 questions at once.

If this is a rewrite, diagnose what's wrong with the current copy first. Name the specific problems (generic filler, hollow verbs, no differentiator, etc.) before rewriting.

### Step 3: Write

Write the copy. Keep it specific. Every sentence should say something that couldn't be said about a competitor.

If appropriate, offer 2-3 options with different angles (e.g., direct, problem-first, punchy). Rank them and explain your pick.

### Step 4: Self-test

Before presenting the final copy, apply this test: swap the product/company name with a competitor's name. Does the copy still work? If yes, it's too generic. Rewrite until swapping names would break it.

### Step 5: CTA check

If the copy needs a call to action, ask what the CTA should be rather than defaulting to "Learn More" or "Get Started." The CTA depends on the business model (free trial, waitlist, demo, purchase).
