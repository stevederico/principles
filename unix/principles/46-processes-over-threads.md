# Use concurrency for structure, and prefer processes and event loops to threads

**Rule:** Split work across processes or an event loop to clarify architecture, not as a first speed tactic, and use shared-memory threads only as a last resort, sharing as little as possible.

**Why:** Threads share one address space, so nothing enforces encapsulation between them, and locking regimes grow harder as code grows, producing races, deadlocks and timing bugs hard to reproduce. Finer locking costs latency that can cancel the gain, library threads leak to callers, and thread semantics differ across platforms.

**Do:**
```
prefer in order: single event loop -> processes + messages -> limited shared memory + guards -> threads
if threads: share minimal state; prefer thread-local data
```

**Don't:** Make a design concurrent for its own sake, or combine threads, remote objects and deep hierarchies in one design.

**Break it when:** Measurements show copy and context-switch cost dominate and the shared state is small and well guarded.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch07s01.html (Separating Complexity Control from Performance Tuning) ; http://www.catb.org/esr/writings/taoup/html/ch07s03.html (Threads - Threat or Menace?). Book only.
