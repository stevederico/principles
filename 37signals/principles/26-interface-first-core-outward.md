# Design the interface first, from the core outward, large to small

**Rule:** Sketch and mock the interface before programming, in order of cost of change: idea, paper, plain HTML screens, then code. On each screen design the essential unit first, then extras by importance, and polish details only after use shows which hurt.

**Why:** Code is the costliest layer to change and the interface is the product; a fixed interface also keeps scope honest because every feature needs a place. Building the frame first leaves the real purpose with leftover space. Early detail work breeds arguments and false progress.

**Do:**
```
brainstorm -> paper sketch -> html screens -> implement   # discard any stage that disappoints
rank(elements by importance); design each in order; chrome and colour last
1. rough structure and flow  2. use it  3. refine what hurts
```

**Don't:** Bolt an interface onto finished logic, start from a page template and pour content in, or spend week one on a font size.

**Break it when:** There is no human interface (a library or protocol), the main risk is feasibility (prototype the risky mechanism first), or a detail is a hard constraint such as a legal wording.

**Source:** https://basecamp.com/gettingreal/09.1-interface-first ; https://basecamp.com/gettingreal/09.2-epicenter-design ; https://basecamp.com/gettingreal/04.2-ignore-details-early-on ; https://basecamp.com/gettingreal/06.3-from-idea-to-implementation. Docs only.
