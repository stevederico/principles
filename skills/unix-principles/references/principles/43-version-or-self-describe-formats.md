# Give every format a version or independently droppable self-describing parts

**Rule:** Put a version number, or better self-describing clauses a reader may skip, into every file format and protocol, and make readers ignore unknown parts safely.

**Why:** Designers cannot anticipate every use; a small cost of self-description pays back many times through forward evolution without breaking old readers.

**Do:**
```
format = { version: n, clauses: [ self_describing_clause, ... ] }
reader: for clause in format.clauses: if unknown(clause): skip_safely(clause)
```

**Don't:** Fix a format with no room to grow, or require readers and writers to upgrade in lockstep.

**Break it when:** The format is private and short-lived and both ends always ship together.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Extensibility) ; http://www.catb.org/esr/writings/taoup/html/ch05s02.html (Unix Textual File Format Conventions) ; http://www.catb.org/esr/writings/taoup/html/ch05s01.html (Case Study: The PNG Graphics File Format). Book only.
