# Publish known defects and limits plainly

**Rule:** Ship a visible, unsoftened list of known bugs and limitations with the reference documentation, and never drop functional details or warnings for fear of looking bad.

**Why:** Peers read a short honest known-problems section as a sign of quality, while euphemized or removed sections correlated with decline. Problems users meet unannounced cost more credibility than those disclosed.

**Do:**
```
reference page sections = [synopsis, behavior, options, known_bugs (specific, unsparing)]
```

**Don't:** Rename the bugs section to something vaguer, or skip a confusing detail to keep docs simple.

**Break it when:** A flaw is an unfixed security hole; coordinate disclosure first.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch18s02.html (Cultural Style) ; http://www.catb.org/esr/writings/taoup/html/ch18s06.html (Best Practices for Writing Unix Documentation). Book only.
