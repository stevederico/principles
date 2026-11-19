# Follow the common plain-text file conventions

**Rule:** Make text formats line-oriented with short lines, comment lines, backslash escapes, line continuation, ignored trailing blanks, either line-ending style accepted, no meaning for tab versus space, hex over octal, and round-trip tests for any floating-point number.

**Why:** These habits tame the learning curve, fit line-oriented tools, and guard against editor accidents. Anything the eye cannot see, such as a tab or trailing blank, must never change meaning, which is why whitespace-sensitive syntax has been called a design botch in several tools. A float written as text and read back may lose precision, depending on how good the formatting library is.

**Do:**
```
reader: strip_trailing_blanks; accept(LF or CRLF); skip_comment_lines; join_continuations
writer: emit_canonical_form
assert parse(format(x)) == x for sample and edge floats   # else use exact encoding
```

**Don't:** Make tab versus space or a stray trailing blank change how a file is read.

**Break it when:** A strong, specific reason exists; the source says follow them unless you have one. Display-only numbers may lose precision.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch05s02.html (Unix Textual File Format Conventions) ; http://www.catb.org/esr/writings/taoup/html/ch08s02.html (Case Study: The Documenter's Workbench Tools) ; http://www.catb.org/esr/writings/taoup/html/ch15s04.html (Basic Theory of make). Book only.
