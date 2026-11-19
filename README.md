# principles

[![skills.sh](https://skills.sh/b/stevederico/principles)](https://skills.sh/stevederico/principles)

Engineering principles from great open source frameworks, rewritten with no language attached. An agent (or a person) reads a principle and applies it in any language.

Each framework is a folder. Each principle is one short file: rule, why, a language-neutral example, what to avoid.

## Frameworks

- [rails](rails/README.md): 81 principles
- [laravel](laravel/README.md): 121 principles
- [nextjs](nextjs/README.md): 100 principles
- [37signals](37signals/README.md): 110 principles (Shape Up, Getting Real, Hotwire, Kamal, Solid libraries, Campfire and Writebook)
- [unix](unix/README.md): 101 principles (The Art of Unix Programming, Eric S. Raymond)
- [axum](axum/README.md): 100 principles (Axum, the Rust web framework from the Tokio project)

## Theory

Methodology principles taken from a single primary source.

- [theory/xp](theory/xp/README.md): 51 principles (Extreme Programming, from extremeprogramming.org)

## Install

These are agent skills, installed with the [skills.sh](https://skills.sh) CLI. It works with Claude Code, Cursor, Codex, Windsurf, Gemini and others.

```
npx skills add stevederico/principles
```

The CLI lists the skills in this repo and asks which to install. To pick one directly:

```
npx skills add stevederico/principles --skill rails-principles
```

To see what is in the repo without installing:

```
npx skills add stevederico/principles --list
```

To pull the latest versions of skills you already installed:

```
npx skills update
```

Once installed, an agent loads a skill when your request matches its description, for example "the Rails way" or "how would Unix structure this". It reads the skill's index, then opens only the few principles the task needs.

## Skills

One self-contained skill per source in `skills/`: `rails-principles`, `laravel-principles`, `nextjs-principles`, `37signals-principles`, `xp-principles`, `unix-principles`, `axum-principles`. Each carries its own copy of the index and principles, so it works installed on its own. They are generated: edit a source folder, then run `scripts/build-skills.sh`.

To use one without the CLI, copy or symlink its folder from `skills/` into `~/.claude/skills`.

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

## Sources and licenses

Every principle is written in original words and cites the page it came from. The sources keep their own licenses and authors' rights. This repo's text is MIT (see LICENSE).
