# Decide whether metadata lives in the content or beside it

**Rule:** When data needs type or attribute information, choose explicitly whether it travels inside the bytes or is attached to the name, and define which operations preserve it, such as copy, redirect, move and export.

**Why:** Self-describing content lets any tool inspect it but every program that touches the file must preserve the in-band marker. Side attributes keep content clean but raise awkward questions about which operations carry them, and meaning that depends on a side table is invisible to generic tools. Export as one serialized stream carrying both is the best solution found so far.

**Do:**
```
file = bytes + self_identifying_header          # inspectable by any tool
or:  attrs(file) separate from bytes; define copy, redirect, export:
        copy preserves attrs ; export = serialize(attrs + content)
```

**Don't:** Add type hints only some writers honor, or leave preservation semantics unspecified.

**Break it when:** The attribute is orthogonal (access control, indexing) and nothing needs it to interpret the content.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch03s01.html (File Attributes and Record Structures) ; http://www.catb.org/esr/writings/taoup/html/ch20s03.html (A Unix File Is Just a Big Bag of Bytes). Book only.
