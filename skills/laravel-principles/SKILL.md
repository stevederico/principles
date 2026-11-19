---
name: laravel-principles
description: Laravel engineering principles without PHP, 121 short rules checked against the primary source. Use when designing, structuring or reviewing an app in any language and the user says "the Laravel way" or "like Laravel", or asks how to structure a container, middleware, form requests, policies, queues, events, caching, auth or tests the Laravel way.
allowed-tools: Read, Grep
---

# laravel-principles

121 language-agnostic principles. Each is one short file: rule, why, pseudo-code, common failure, when to break it, source.

## Use

1. Read `references/README.md`. It is a themed index with a one-line summary per principle.
2. Pick only the principles the task needs, usually 3 to 8, and read those files in `references/principles/`. Never load the whole set.
3. Apply the rule in the target language with its own idioms. Never port PHP syntax.
4. The project's own conventions win over a principle. Use "Break it when" to judge edge cases.
5. When reviewing code, cite the principle file you used.

Each Source line names the page it came from. "docs only" means no code backed the claim.
