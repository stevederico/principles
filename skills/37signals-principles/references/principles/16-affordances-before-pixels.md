# Build plain affordances first and stub what you can

**Rule:** Wire inputs, buttons and data with unstyled markup and hard-coded or mock data first; add styling and full infrastructure after the interaction proves out.

**Why:** The big unknowns are whether it works, makes sense and is hard to build, and plain controls test those cheaply. Design and code take turns on the same piece instead of one big hand-off. A hard-coded shared password let real data be tried without building authentication that would teach nothing.

**Do:**
```
v0: plain controls and labels, mock reads, shared password
loop: designer adds affordance -> programmer wires -> designer styles
```

**Don't:** Spend days on pixel-perfect screens, or on full auth, before the flow is known to work.

**Break it when:** The stub would hold real sensitive data without protection; keep minimal protection even in the stub.

**Source:** https://basecamp.com/shapeup/3.2-chapter-11 (Affordances before pixel-perfect screens, Program just enough for the next step). Docs only.
