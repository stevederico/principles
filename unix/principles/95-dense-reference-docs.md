# Write dense reference documentation for capable readers, and date perishable claims

**Rule:** Aim documentation at an active, capable reader: complete but terse, edited hard, with each fact stated once and pointers to related facts, and mark statements that describe the current state of the world with a date.

**Why:** Condescension reads as incompetence and drops important facts; accessibility comes from careful thought and ruthless editing, not volume. Screenshots convey look and feel more than information. A date stamp warns later readers that a claim may have gone stale.

**Do:**
```
state_each_fact_once; cut_filler; link_to_related
perishable claim: "as of <date>, X is true"
```

**Don't:** Pad for volume, repeat things, or replace a clear text description with an image.

**Break it when:** The audience is explicitly novice; then write a separate tutorial instead of diluting the reference.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch18s02.html (Cultural Style) ; http://www.catb.org/esr/writings/taoup/html/ch18s06.html (Best Practices for Writing Unix Documentation) ; http://www.catb.org/esr/writings/taoup/html/preface.html (Preface). Book only.
