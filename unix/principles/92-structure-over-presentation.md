# Store structure and meaning, and derive every presentation from it

**Rule:** Keep one master that records what each piece of content is, such as heading, warning or term, keep it as visible editable text, generate every visual form from it with separate style rules, and ship the generated forms most users need beside the master.

**Why:** Presentation-level markup cannot be reliably converted to other media or indexed, since meaning must be guessed back. Hidden markup in visual editors breaks transparency and least surprise, and a global layout change to a long document becomes thousands of clicks. Shipping pre-rendered forms keeps documentation usable for people lacking the toolchain.

**Do:**
```
master = tree_of_typed_elements
for target in [web, print, terminal]: output = apply(style[target], master)
package(master + generated_reference_form + generated_web_form)
```

**Don't:** Author in a format that records only fonts and positions and hope to recover meaning later, or ship only generated output.

**Break it when:** The document is short, single-medium and disposable, or page-level control matters more than reuse.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch18s01.html (Documentation Concepts) ; http://www.catb.org/esr/writings/taoup/html/ch18s02.html (The Large-Document Bias) ; http://www.catb.org/esr/writings/taoup/html/ch18s03.html (The Zoo of Unix Documentation Formats) ; http://www.catb.org/esr/writings/taoup/html/ch18s06.html (Best Practices for Writing Unix Documentation). Book only.
