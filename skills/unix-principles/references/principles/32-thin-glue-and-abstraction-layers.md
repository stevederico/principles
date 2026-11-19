# Keep glue and abstraction layers thin enough to see through

**Rule:** Make the code joining application logic to lower-level primitives as thin as possible, add an abstraction layer only when it maps to a real entity or variation, and fix mismatches in the layers instead of hiding them in glue.

**Why:** Glue is where kludges collect, and organizing it into a middle layer often produces a second layer of glue. Designers who organize code around their own concepts can no longer see through them when debugging, and placeholder hierarchies add opacity without knowledge. Transparency costs craft but lowers total life-cycle cost.

**Do:**
```
for each layer: ask "which real entity or variation does this represent?"
if none: remove(layer)
if glue is growing: change(layer_above_or_below) to fit instead
```

**Don't:** Add an adapter per mismatch and then an adapter for the adapter, or add indirection with no second user.

**Break it when:** An external specification you cannot change forces a protective layer; keep it small and isolated. Or the domain is naturally object-shaped, where wrong types are easy to notice.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch04s03.html (Glue Layers) ; http://www.catb.org/esr/writings/taoup/html/ch06s02.html (The Zen of Transparency) ; http://www.catb.org/esr/writings/taoup/html/unix_and_oo.html (Unix and Object-Oriented Languages). Book only.
