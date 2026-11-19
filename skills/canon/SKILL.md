---
name: canon
author: stevederico
description: Look up engineering principles from the canon repo (Rails, Laravel, Next.js, Extreme Programming and more) when designing, structuring or reviewing an app in any language. Use when the user says "canon", "the Rails way", "like Laravel", "Next.js rules", "XP practice", or asks how a respected framework or methodology handles architecture, data, caching, security, jobs, testing or process.
allowed-tools: Read, Grep
---

# canon

Language-agnostic engineering principles, one short file each: rule, why, pseudo-code, common failure, when to break it, source. Each source stands alone.

Repo: `~/Projects/canon` (clone `https://github.com/stevederico/canon` if missing; private, needs GitHub auth).

## Use

1. Read `~/Projects/canon/README.md` to see which sources exist.
2. Open the matching source index, for example `rails/README.md`, `laravel/README.md`, `nextjs/README.md`, `theory/xp/README.md`. Each is a themed list with a one-line summary per principle.
3. Pick only the principles the task needs, usually 3 to 8, and read those files in the source's `principles/` folder. Never load a whole set.
4. Apply the rule in the target language with its own idioms. Never port the source language's syntax.
5. The project's own conventions win over a principle. Use "Break it when" to judge edge cases.
6. When reviewing code, cite the principle file you used.

## Notes

- A principle's Source line lists the doc page and code path it came from. "docs only" means no code backed it.
- If the user names one framework, use only that one. Do not mix sources unless asked.
