# Give every binary format a lossless text form and a way back

**Rule:** For each complex binary format write a tool that converts it to text and back with zero loss, or an inspector when the object is too large or live to round-trip.

**Why:** People reason better over text, so a textualizer enables hand edits of obscure fields, scripted generation, comparison and version control, test cases and inspection. Lossless fidelity lets users experiment without fear of damaging data. Writing one teaches the structure, yields reusable marshaling code and can become the engine beneath a separate interface. Ideally it also reads damaged objects, showing nonsense values raw, so you can craft broken tests and repair real damage.

**Do:**
```
to_text(binary) -> text ; from_text(text) -> binary
assert from_text(to_text(x)) == x for sample and edge cases
keep the command line separate from the marshal/unmarshal library
```

**Don't:** Ship a lossy exporter and call it a debugging tool, or a binary format with no way to look inside.

**Break it when:** Round-trip fidelity is impossible (live, enormous or opaque by design); settle for a read-only inspector.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch06s01.html (Case Study: SNG) ; http://www.catb.org/esr/writings/taoup/html/ch06s02.html (Transparency and Editable Representations). Book only.
