# Size a program by the context it must share

**Rule:** Decide what state or context the pieces of a job must share, and draw the program boundary exactly around that, no larger and no smaller.

**Why:** Small tools struggle to share data unless something carries the context between them, which is why large programs earn their size: they spare users from naming and juggling shared resources. Convenience pressure also drives bloat, as when one tool absorbs a neighbour's task merely because the data is nearby.

**Do:**
```
needed_shared_state = list(state that two steps must see together)
program_boundary    = group(steps by needed_shared_state)
for each adjacent task not needing that state:
    leave it outside; link by a narrow channel
```

**Don't:** Fold an adjacent task into the program just because it is convenient, or split tools whose users must then re-supply the same context by hand.

**Break it when:** The shared context is so valuable that one integrated tool clearly beats switching between several.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch13s04.html (The Right Size of Software (Rule of Minimality)) ; http://www.catb.org/esr/writings/taoup/html/ch13s03.html (Compromise Doesn't Work). Book only.
