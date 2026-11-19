#!/usr/bin/env bash
# Generate one self-contained skill per source from its folder.
# Edit the source folders (rails/, laravel/, ...), never skills/. Then run this script.
set -euo pipefail
cd "$(dirname "$0")/.."

build() {
  local src="$1" name="$2" lang="$3" title="$4" triggers="$5"
  local n; n=$(ls "$src/principles" | wc -l | tr -d ' ')
  local out="skills/$name"
  rm -rf "$out"; mkdir -p "$out/references"
  cp "$src/README.md" "$out/references/README.md"
  cp -r "$src/principles" "$out/references/principles"
  cat > "$out/SKILL.md" <<EOT
---
name: $name
description: $title engineering principles without $lang, $n short rules checked against the primary source. Use when designing, structuring or reviewing an app in any language and $triggers.
allowed-tools: Read, Grep
---

# $name

$n language-agnostic principles. Each is one short file: rule, why, pseudo-code, common failure, when to break it, source.

## Use

1. Read \`references/README.md\`. It is a themed index with a one-line summary per principle.
2. Pick only the principles the task needs, usually 3 to 8, and read those files in \`references/principles/\`. Never load the whole set.
3. Apply the rule in the target language with its own idioms. Never port $lang syntax.
4. The project's own conventions win over a principle. Use "Break it when" to judge edge cases.
5. When reviewing code, cite the principle file you used.

Each Source line names the page it came from. "docs only" means no code backed the claim.
EOT
  echo "$name: $n"
}

build rails         rails-principles    Ruby       "Rails"                  'the user says "the Rails way", "like Rails" or "convention over configuration", or asks how to structure models, routes, jobs, caching, migrations, security or tests the Rails way'
build laravel       laravel-principles  PHP        "Laravel"                'the user says "the Laravel way" or "like Laravel", or asks how to structure a container, middleware, form requests, policies, queues, events, caching, auth or tests the Laravel way'
build nextjs        nextjs-principles   JavaScript "Next.js"                'the user asks about the server and client boundary, rendering, caching, routing, mutations, streaming or security the Next.js way'
build 37signals     37signals-principles Ruby      "37signals"              'the user says "the 37signals way", "like Basecamp", "Shape Up", "Getting Real" or "Hotwire", or asks about shaping work, scope, small teams, Hotwire, Kamal or vanilla Rails structure'
build theory/xp     xp-principles       "code" "Extreme Programming" 'the user asks about XP practices such as pair programming, test first, small releases, the planning game, refactoring or sustainable pace'
build unix          unix-principles     "code" "Unix"                'the user says "the Unix philosophy", "the Unix way", "small tools" or "do one thing well", or asks about CLI design, text streams, pipes, modularity, least surprise, silence or composing programs'
build axum          axum-principles     Rust       "Axum"                   'the user says "the Axum way" or "like Axum", or asks about extractors, handlers, middleware layers, shared state, error handling, graceful shutdown or structuring a Rust web service'
