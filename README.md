# canon

Engineering principles from great open source frameworks, rewritten with no language attached. An agent (or a person) reads a principle and applies it in any language.

Each framework is a folder. Each principle is one short file: rule, why, a language-neutral example, what to avoid.

## Frameworks

- [rails](rails/README.md): 81 principles
- [laravel](laravel/README.md): 121 principles
- [nextjs](nextjs/README.md): 100 principles
- [37signals](37signals/README.md): 110 principles (Shape Up, Getting Real, Hotwire, Kamal, Solid libraries, Campfire and Writebook)

## Theory

Methodology principles taken from a single primary source.

- [theory/xp](theory/xp/README.md): 51 principles (Extreme Programming, from extremeprogramming.org)

## Skills

One self-contained skill per source in `skills/`: `rails-principles`, `laravel-principles`, `nextjs-principles`, `37signals-principles`, `xp-principles`. Each carries its own copy of the index and principles. They are generated: edit a source folder, then run `scripts/build-skills.sh`. Not installed by default; symlink or copy a skill folder into `~/.claude/skills` to use it.

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
