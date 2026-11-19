# reference

Design principles from great open source frameworks, rewritten with no language attached. An agent (or a person) reads a principle and applies it in any language.

Each framework is a folder. Each principle is one short file: rule, why, a language-neutral example, what to avoid.

## Frameworks

- [rails](rails/README.md): 21 principles

## Format

```
# Title
Rule:   one sentence an agent can act on
Why:    the reason, so it can judge edge cases
Do:     pseudo-code, no language syntax
Don't:  the common way it goes wrong
Source: where the idea comes from
```

## Rules for adding principles

1. Own words. Link to the source, never copy its text.
2. No language syntax. Pseudo-code only (`find`, `save`, `each`).
3. One principle per file. Under 40 lines.
4. Say when to break the rule.
