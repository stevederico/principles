# Default to readable text for files, streams and protocols

**Rule:** Store and exchange data as human-readable, human-editable text with explicit delimiters and no fixed field widths, and serialize to a documented textual form rather than dumping memory; consider binary only after a text version has been tried and measured.

**Why:** Text can be inspected, filtered, compared and generated with general tools, and its limits discourage programs from sharing dense private state. The parsing cost is small next to the integration and debugging gain; in one real case packing a file tightly saved under a tenth of its size while imposing numeric limits and ruling out simple queries. Text also has no baked-in width: a larger number is simply more digits. Raw memory dumps break across word size, byte order and pointers.

**Do:**
```
format = one_record_per_line, delimited_fields, no_fixed_columns
save = flatten(structure) -> documented_text ; load = parse + validate
before inventing binary: prototype(text); measure(cost)
```

**Don't:** Choose a clever binary layout as the first option, allocate exactly the bits today's maximum needs, or write pointer-bearing blobs to disk or wire.

**Break it when:** Volume, latency or precision needs are proven to rule text out; then use a documented binary format with an inspection tool, or keep a speed-optimized private cache beside the text master.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch05s01.html (The Importance of Being Textual) ; http://www.catb.org/esr/writings/taoup/html/textualitychapter.html (Chapter 5 introduction) ; http://www.catb.org/esr/writings/taoup/html/ch03s01.html (Binary File Formats) ; http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Composition). Book only.
