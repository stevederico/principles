---
name: axum-principles
description: Axum engineering principles without Rust, 100 short rules checked against the primary source. Use when designing, structuring or reviewing an app in any language and the user says "the Axum way" or "like Axum", or asks about extractors, handlers, middleware layers, shared state, error handling, graceful shutdown or structuring a Rust web service.
allowed-tools: Read, Grep
---

# axum-principles

100 language-agnostic principles. Each is one short file: rule, why, pseudo-code, common failure, when to break it, source.

## Use

1. Read `references/README.md`. It is a themed index with a one-line summary per principle.
2. Pick only the principles the task needs, usually 3 to 8, and read those files in `references/principles/`. Never load the whole set.
3. Apply the rule in the target language with its own idioms. Never port Rust syntax.
4. The project's own conventions win over a principle. Use "Break it when" to judge edge cases.
5. When reviewing code, cite the principle file you used.

Each Source line names the page it came from. "docs only" means no code backed the claim.
