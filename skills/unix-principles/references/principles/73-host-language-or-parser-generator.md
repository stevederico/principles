# Reuse a host language or a parser generator instead of building an interpreter

**Rule:** Implement an imperative domain language as a library for an existing scripting language, and for a custom grammar describe it declaratively and generate the parser, separating tokenizing from grammar analysis and keeping error locations pointed at the spec.

**Why:** Every facility of the host is one you do not write; where the host lacks a binding or speed, extend it with compiled code. Hand-written parsers embedded in application code are accidents that cost maintenance, while generators wall off parser complexity, recover from errors better and are easier to change. Generated lexers can be slow, so prototype with the generator and hand-tune only a measured bottleneck. Errors reported against generated text are useless unless line mappings refer back to the spec.

**Do:**
```
imperative DSL: library of functions in host language + user scripts; hot paths: native extension
custom grammar: spec = tokens + grammar -> generate(parser); emit(line_mapping_to_spec)
```

**Don't:** Grow a hand-rolled parser inside business code, or write a new general interpreter for a small DSL.

**Break it when:** The input is trivial, you need grammar-level diagnostics a generator cannot give, or measured performance requires tuning by hand.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch08s03.html (Extending and Embedding Languages) ; http://www.catb.org/esr/writings/taoup/html/ch08s03.html (Writing a Custom Grammar) ; http://www.catb.org/esr/writings/taoup/html/ch15s03.html (Special-Purpose Code Generators). Book only.
