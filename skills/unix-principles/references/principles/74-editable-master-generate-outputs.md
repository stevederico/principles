# Keep an editable master and generate the rest from it

**Rule:** Keep rarely changing content or layouts in an editable master that looks like its displayed form, and produce markup, tables or embedded code from it with a small build step, instead of hand-writing outputs or standing up a database.

**Why:** Inlined, escaped copies break the visual match with the output and make edits painful; hand-written markup turns every format change into a manual sweep; a database and live rendering add moving parts for static data. The master stays searchable in any editor and the script acts like a stylesheet, separating content from form. Describing a UI or grammar declaratively also lets one spec feed several target languages or be loaded at run time.

**Do:**
```
master:  field1:field2:field3                # explicit delimiters
build:   for row in master: emit(cells(row))  # or: master -> transform -> generated source
optional: spec -> generator -> source  OR  spec -> runtime loader -> live objects
```

**Don't:** Hand-maintain an escaped copy of a text screen in source, or serve static data from a database.

**Break it when:** Data changes often or needs queries and multi-user edits, or the language offers multiline literals that keep the text as it is.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch09s02.html (Ad-hoc Code Generation) ; http://www.catb.org/esr/writings/taoup/html/ch08s02.html (Case Study: Glade) ; http://www.catb.org/esr/writings/taoup/html/ch15s03.html (Case Study: Glade). Book only.
