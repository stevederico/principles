# Escape with one rule and delimit records explicitly

**Rule:** Use a single escape character whose only job is to take the next character literally, mark record boundaries with a visible delimiter that is hard to produce by accident, and define how that delimiter is escaped inside payload.

**Why:** One rule covers separator, escape and newline together. Multi-case quoting schemes with doubled quotes and optional continuations left implementations disagreeing on edge cases. A length declared in a header breaks when someone hand-edits, and a one-character delimiter can arise from a typo.

**Do:**
```
parse: if ch == ESC: take_next_char_literally()
write: escape(SEPARATOR, ESC, NEWLINE)
record separator = line_of_two_printable_chars ; payload line equal to it gets escaped
```

**Don't:** Combine wrap-in-quotes, doubled quotes and continuation rules, or trust a declared length in a human-editable file.

**Break it when:** You must interoperate with a legacy format; then pin down a precise written grammar. A machine-only file may rely on other corruption detection.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch05s02.html (DSV Style) ; http://www.catb.org/esr/writings/taoup/html/ch05s02.html (RFC 822 Format) ; http://www.catb.org/esr/writings/taoup/html/ch05s02.html (Cookie-Jar Format) ; http://www.catb.org/esr/writings/taoup/html/ch05s02.html (Record-Jar Format). Book only.
