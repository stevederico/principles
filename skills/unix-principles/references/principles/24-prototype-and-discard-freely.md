# Prototype early, automate repeated work, and discard clumsy parts

**Rule:** Build a rough working version quickly, let real users react to it, then estimate and build the production version; write a tool for any task that repeats, and throw away parts that prove clumsy.

**Why:** A person judges a running prototype far more easily than a specification, and estimates made afterwards are more accurate. Early trials expose weak parts cheaply, and deleting code is one of the most valuable edits.

**Do:**
```
prototype = quickest_version(); users.try(prototype)
estimate(production_version) after the trial
if task.repeats: write_tool(); discard(tool) if it stops paying
```

**Don't:** Write a large requirements document before anyone has seen behavior, or defend sunk-cost code.

**Break it when:** A wrong prototype is costly or irreversible (hardware, safety-critical), so analysis must come first.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Optimization (prototype anecdote) and the four-point summary) ; http://www.catb.org/esr/writings/taoup/html/ch01s09.html (Attitude Matters Too). Book only.
