# Build large systems from simple parts behind narrow interfaces

**Rule:** Divide a system into small units that talk only through a few well-defined entry points, so that a fault stays local and one unit can be repaired or replaced without disturbing the rest.

**Why:** Most development time goes into finding bugs, and a bug is far easier to find when the faulty unit is identified by its interface. The interfaces, not the internals, are what define the architecture, and they stop details leaking into neighbours. Each new programming fashion has raised the ceiling of manageable complexity only until people hit it again.

**Do:**
```
unit.public  = [few, documented entry points]
unit.private = everything else            # no shared mutable globals
when a bug appears:
    find the unit whose contract was violated
    fix inside it; callers never change
```

**Don't:** Reach across a boundary because it is quicker to type, or expect a new paradigm to make a tangled design manageable.

**Break it when:** The whole problem fits in one head and splitting it would add interface cost with no isolation gain; or a measured hot path forces one narrow, documented exception.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Modularity) ; http://www.catb.org/esr/writings/taoup/html/ch04s01.html (Encapsulation and Optimal Module Size) ; http://www.catb.org/esr/writings/taoup/html/modularitychapter.html (Chapter 4 introduction). Book only.
