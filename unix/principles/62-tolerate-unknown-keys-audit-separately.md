# Tolerate unknown keys at runtime and audit them in a separate checker

**Rule:** Keep fixed domain data in editable files the engine reads at start, let the engine skip keys it does not know, and ship a separate validator that humans run after edits to catch typos and unused entries.

**Why:** Ignoring unknown properties lets data and engine evolve independently, but it hides misspelled keys, which clashes with failing loudly; moving the strictness into a distinct audit tool resolves the conflict. Problems of shared mutable registries do not arise when everyone reads the data and only maintainers edit it.

**Do:**
```
engine: for key in file: if unknown(key): skip
auditor: report(keys_used_in_data - keys_declared_by_engine, and the reverse)
data supports include directives to split into editable units
```

**Don't:** Make the engine accept everything silently and give no way to check the data.

**Break it when:** The data is untrusted or supplied by users at runtime; then the engine itself validates strictly.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch06s01.html (Case Study: Freeciv Data Files). Book only.
