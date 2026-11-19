# Ship distinct documents for distinct reader jobs

**Rule:** Give any non-trivial project a quick reference, a guided tutorial, an evolving FAQ, a short top-level roadmap file and a web copy, and split a bloated reference page into a summary plus a long manual.

**Why:** Each form answers a different question, giant single pages are hard to navigate, and a maintained FAQ turns repeated support questions into one answer. Explorers scan top-level file names first, so conventional names tell them where to look.

**Do:**
```
if a question is asked twice: add to FAQ; point new askers there first
top level: README (short), INSTALL, NEWS, license, FAQ ; reference pages short with pointers
```

**Don't:** Stuff tutorial, reference and troubleshooting into one document, or invent unusual names for standard files.

**Break it when:** The project is tiny enough that one README covers everything, or the ecosystem has its own metadata convention.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch18s06.html (Best Practices for Writing Unix Documentation) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Include a README). Book only.
