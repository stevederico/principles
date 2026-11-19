# Be tolerant in what you accept and strict in what you emit

**Rule:** Accept odd but unambiguous input and harmless variations, emit only the clean canonical form, and write the tolerated variations into the specification so every implementation agrees.

**Why:** A tolerant reader cooperates with sloppy producers and strict output keeps downstream chains clean. When each implementation silently invents its own private superset, the result is incompatible dialects. Tolerance means accepting harmless form, never silently dropping content.

**Do:**
```
read(input):  accept(documented_leniencies); else fail_loudly(location)
write(output): canonical_form_only
```

**Don't:** Let every implementation guess differently, or discard part of a document after a trivial structural slip.

**Break it when:** Security-sensitive parsing, where leniency turns into ambiguity attackers exploit; be strict on input too.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Repair (tolerance passage)) ; http://www.catb.org/esr/writings/taoup/html/ch01s08.html (Applying the Unix Philosophy) ; http://www.catb.org/esr/writings/taoup/html/ch08s03.html (Choosing the Right Complexity Level) ; http://www.catb.org/esr/writings/taoup/html/ch11s06.html (The Filter Pattern). Book only.
