# Write filters that read a stream, write a stream and keep data clean

**Rule:** Make stream-transforming tools take input from the standard input unless given files, write results to the standard output and diagnostics elsewhere, keep every field they were not asked to change, and add no banners, totals or conversions unless a switch requests them.

**Why:** Pipes let small utilities replace custom code and adapt old tools to new uses. Leniency on input prevents brittleness in someone's toolchain, strict one-record-per-line output feeds the next stage, discarded data cannot be recovered downstream, and decoration makes parsing harder. Dates are especially hard to parse, so default to an unambiguous standard form.

**Do:**
```
for record in input_stream:
    emit(transform(record) if relevant(record) else record)      # pass through the rest
output: fixed field order, standard date format ; decoration behind --pretty
```

**Don't:** Mix diagnostics into data output, normalize fields you were never asked to touch, or print a summary line by default.

**Break it when:** Dropping data is the declared purpose (redaction, privacy) or output is only for human eyes, where a machine mode should also exist.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch11s06.html (The Filter Pattern) ; http://www.catb.org/esr/writings/taoup/html/ch07s02.html (Pipes, Redirection, and Filters) ; http://www.catb.org/esr/writings/taoup/html/ch01s08.html (Applying the Unix Philosophy). Book only.
