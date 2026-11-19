# Grow reusable primitives unless the specification is firm and complete

**Rule:** Use top-down stepwise design only when behavior can be fully specified in advance and will not change; otherwise build reusable low-level primitives and assemble the application from them, dropping inherited assumptions first so the primitives are general.

**Why:** Pure top-down work over-invests in code that is scrapped when the interface fails a reality check; pure bottom-up produces bricks unrelated to the application. Primitives leave room to refine a vague specification, and stripping out accidental conditions of the original problem reveals reuse.

**Do:**
```
list(assumptions); for each: if not essential: remove
if requirements_are_firm: design_top_down()
else: build(primitives); expose(as_library); assemble(application)
```

**Don't:** Commit to a full top-down design before users have tested the interface, or bake the first use case into the API.

**Break it when:** The primitives are not yet obvious; start with a top-down prototype to find them.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch04s03.html (Top-Down versus Bottom-Up) ; http://www.catb.org/esr/writings/taoup/html/ch04s02.html (The Value of Detachment). Book only.
