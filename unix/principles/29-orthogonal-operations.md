# Make operations orthogonal: one change, one effect

**Rule:** Let each operation change exactly one thing with no hidden side effects, offer one route to alter any property, and let every operation accept the same general way of choosing its targets.

**Why:** Side effects burden the mental model and must be worked around. Orthogonal parts have fewer combinations to test, can be replaced without disturbing others, and are easier to document and reuse. A handful of operations that each accept any selector cover far more cases than many special commands.

**Do:**
```
convert(input_stream) -> output          # not convert(filename) that also opens and resets things
command = operation + target_selector    # any operation with any selector
```

**Don't:** Bury file opening, global resets or other effects inside a function whose job is something else, or add a special command per operation and target combination.

**Break it when:** The side effect is required by the primary function and does not raise complexity, or one combination needs different semantics and clearer is a separate command.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch04s02.html (Orthogonality) ; http://www.catb.org/esr/writings/taoup/html/ch13s02.html (A Tale of Five Editors) ; http://www.catb.org/esr/writings/taoup/html/ch13s03.html (The Right Size for an Editor). Book only.
