# Pick an established text metaformat by the shape of the data

**Rule:** Reuse a standard, library-supported format matched to the data: delimited records for tabular keyed data, header-style attribute lines for flat records with varying fields, a record-jar for multi-record files with variable fields, tree markup for nested data, sectioned name-value files for named groups.

**Why:** Standard formats cut custom parsing code and are recognized on sight, lowering the learning cost, while home-grown syntaxes tend to have slightly broken quoting and whitespace rules. Tree markup brings checkability and a standard parser but also bulk and a poor fit with line-oriented tools.

**Do:**
```
shape = tabular               -> delimited lines
shape = flat, varying fields  -> attribute lines
shape = nested or recursive   -> tree markup (check against a schema)
shape = two-level groups      -> sections of name-value pairs
```

**Don't:** Invent a new syntax with its own escaping rules, or use heavy markup for a flat list of pairs.

**Break it when:** No existing format fits; then document the new one precisely.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch05s02.html (Data File Metaformats) ; http://www.catb.org/esr/writings/taoup/html/ch05s02.html (XML) ; http://www.catb.org/esr/writings/taoup/html/ch05s02.html (Windows INI Format). Book only.
