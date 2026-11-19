# Pursue both transparency and discoverability, and keep code maintainable by others

**Rule:** Make the system predictable from a simple mental model with no hidden corners, and also give newcomers an active path to that model through documentation, naming and a short guide to key data structures and algorithms; prefer simple algorithms so someone else can safely modify the code.

**Why:** Transparency lowers the cost of living in the code and discoverability lowers the barrier to entry; a system can have one without the other. Complex algorithms are not only more bug-prone at first but harder for later maintainers, and projects judged live rather than dormant are those others can modify.

**Do:**
```
code: obvious data flow, few central state structures, named constants
repo: README, hacker's guide (data structures, invariants, algorithm sketches), updated with changes
pick the obvious algorithm; optimize only measured hot spots
```

**Don't:** Assume clear code needs no entry-point documentation, or excuse murky internals because docs exist.

**Break it when:** Throwaway code with a single author and a short life, or a measured performance requirement the simple algorithm misses.

**Source:** http://www.catb.org/esr/writings/taoup/html/transparencychapter.html (Chapter 6 introduction) ; http://www.catb.org/esr/writings/taoup/html/ch06s02.html (Designing for Transparency and Discoverability) ; http://www.catb.org/esr/writings/taoup/html/ch06s03.html (Designing for Maintainability). Book only.
