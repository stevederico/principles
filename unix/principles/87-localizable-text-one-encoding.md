# Keep user-visible text out of the logic and use one universal encoding

**Rule:** Keep messages in replaceable per-language catalogs keyed by the original string, falling back to that string when no translation exists, use one universal text encoding inside the program, and match letter categories by named classes instead of hand-written ranges.

**Why:** New languages then arrive without touching code, and a lightweight home-grown catalog often suffices. A range written for one alphabet misses lowercase letters of others, and several internal character sets add historical clutter.

**Do:**
```
text = lookup(catalog[language], original_string) or original_string
internal text encoding = one universal encoding; convert at boundaries
match(lowercase_class), not [a..z]
```

**Don't:** Scatter literal user-facing strings through logic, or assume a to z covers all lowercase.

**Break it when:** The product ships in one language and will not change, or a protocol mandates a legacy encoding at its edge (convert there).

**Source:** http://www.catb.org/esr/writings/taoup/html/ch17s06.html (Internationalization). Book only.
