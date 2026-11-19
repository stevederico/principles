# Treat configuration files and data files as different designs

**Rule:** Keep startup configuration small, hand-edited and never rewritten by the program, and keep application data program-generated, round-trip safe and free to grow.

**Why:** Configuration flows one way from file to settings, while data formats associate properties with named resources and are read and written repeatedly; they deserve different conventions.

**Do:**
```
config: human-first syntax; program only reads it
data:   machine-generated, stable schema, round-trip safe; humans use a tool, not a text editor
```

**Don't:** Silently rewrite a hand-edited config, or hand-edit a large generated data file.

**Break it when:** The program offers an explicit configuration interface that owns the file.

**Source:** http://www.catb.org/esr/writings/taoup/html/textualitychapter.html (Chapter 5 introduction (closing paragraphs)). Book only.
