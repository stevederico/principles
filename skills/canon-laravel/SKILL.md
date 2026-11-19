---
name: canon-laravel
author: stevederico
description: Laravel design principles without PHP, verified against the Laravel docs and framework code. Use when designing or reviewing the structure of a backend app in any language and the user says "the Laravel way", "like Laravel", or asks how to structure a service container, middleware, form requests, policies, queues, events, caching, auth, or tests the way Laravel does.
allowed-tools: Read, Grep
---

# canon-laravel

80 language-agnostic principles from the Laravel docs and framework code. Each is one short file: rule, why, pseudo-code, common failure, when to break it, source.

Repo: `~/Projects/canon` (clone `https://github.com/stevederico/canon` if missing; private, needs GitHub auth).

## Use

1. Read `~/Projects/canon/laravel/README.md`. It is a themed index (Philosophy, Wiring, Requests and routing, Data, Caching, Views, Background work, Security and auth, Testing, Tooling and operations).
2. Pick only the principles that match the task, usually 3 to 8. Read those files in `~/Projects/canon/laravel/principles/`. Do not load the whole set.
3. Apply the rule in the target language with its own idioms. Never port PHP syntax.
4. The project's own conventions win over a principle. Use "Break it when" to judge the edge cases.
5. When reviewing code, cite the principle file you used.

## Notes

- Principles for separate packages (billing, search, monitoring, feature flags, AI tools) are marked "docs only" in their Source line.
- Ideas shared with Rails (migrations, queues, callbacks) appear only where the Laravel docs add something distinct. See `canon-rails` for the rest.
