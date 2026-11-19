---
name: canon-rails
author: stevederico
description: Rails design principles without Ruby, verified against the Rails guides and code. Use when designing or reviewing the structure of a backend app in any language and the user says "the Rails way", "like Rails", "convention over configuration", or asks how to structure models, routes, jobs, caching, migrations, security, or tests the way Rails does.
allowed-tools: Read, Grep
---

# canon-rails

81 language-agnostic principles from the Rails guides and framework code. Each is one short file: rule, why, pseudo-code, common failure, when to break it, source.

Repo: `~/Projects/canon` (clone `https://github.com/stevederico/canon` if missing; private, needs GitHub auth).

## Use

1. Read `~/Projects/canon/rails/README.md`. It is a themed index (Doctrine, Structure, Data, Requests, Views, Background work, Caching, Security, Testing, Upgrades and operations).
2. Pick only the principles that match the task, usually 3 to 8. Read those files in `~/Projects/canon/rails/principles/`. Do not load the whole set.
3. Apply the rule in the target language with its own idioms. Never port Ruby syntax.
4. The project's own conventions win over a principle. Use "Break it when" to judge the edge cases.
5. When reviewing code, cite the principle file you used.

## Notes

- Principles 1 to 9 are the Rails Doctrine (philosophy). The rest are practice.
- A Source line marked "docs only" has no backing code in the framework repo.
