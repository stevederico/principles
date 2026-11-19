# Use the simplest notation that fits, and decide whether it is data or a language

**Rule:** Climb only as far as needed from a flat name-value file to structured data, a declarative minilanguage, an imperative one, and a general interpreter; decide deliberately whether a format is data or a language, and promote it to an explicit designed language when control flow starts creeping in.

**Why:** More general interpreters embed fewer assumptions and carry richer type systems; declarative notations state relationships and let the engine plan the work. Formats that grow loops by accident attract obscure tricks from clever users, and pasted-on control flow yields weak procedures. Configuration syntax grown patch by patch became unmanageable in a famous mail-transport case.

**Do:**
```
key -> value only?         flat file
structured?                serialization format with no execution semantics
relations over a context?  declarative minilanguage
loops and conditionals?    embed a general language, or design real control structures
```

**Don't:** Let a config format drift into an ad hoc programming language one special case at a time.

**Break it when:** A domain needs control flow and a general interpreter is too heavy to embed.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch08s01.html (Understanding the Taxonomy of Languages) ; http://www.catb.org/esr/writings/taoup/html/ch08s03.html (Choosing the Right Complexity Level) ; http://www.catb.org/esr/writings/taoup/html/minilanguageschapter.html (Chapter 8 introduction). Book only.
