# Separate policy from mechanism, and interface from engine

**Rule:** Keep the engine that performs operations apart from the layer that decides when and in what manner to use them, joined by a defined seam, and bet your long-term investment on the mechanism.

**Why:** Policy changes quickly and mechanism slowly. Welding them makes policy rigid and puts the engine at risk on every policy tweak. A separate engine is also testable on its own, while fast-aging policy hardly merits deep testing. Two cooperating halves are often simpler than one tangle. The price is that users who may choose must choose, so ship a sensible default policy.

**Do:**
```
engine.expose(small_stable_operations)
policy_layer.compose(engine.operations)     # scriptable, replaceable
policy_layer.defaults = sensible_choices()
```

**Don't:** Bake look and feel or business choices into core operations, or put policy inside a framework that should only supply hooks.

**Break it when:** Users cannot or will not choose and a single fixed policy is acceptable for a closed appliance.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Separation) ; http://www.catb.org/esr/writings/taoup/html/ch01s04.html (What Unix Gets Wrong) ; http://www.catb.org/esr/writings/taoup/html/ch01s05.html (Flexibility All the Way Down) ; http://www.catb.org/esr/writings/taoup/html/ch13s04.html (The Right Size of Software). Book only.
