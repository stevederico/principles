# Match the method to the product's maturity and the team's size

**Rule:** Keep the invariant truths (set a budget, shape before committing, cap the downside, separate known from unknown) and let the mechanics flex: spike a new product with senior people first, shape and ship once the load-bearing structure exists, and finish with a short cleanup.

**Why:** You cannot shape what you do not know. Early architectural choices define the holes future features fit into and must not be delegated. Before launch, forgotten details surface and leaders must make final cuts. Two or three people can alternate roles with no ceremony; coordination cost grows with headcount, and then structure pays. Adopt by one bounded experiment, not a reorganisation.

**Do:**
```
R&D:        senior team spikes; no ship goal; commit only code that works
production: shape normally; "shipped" = merged and untouched
cleanup:    no teams, small merges, at most two cycles, cut features for v1
adopt:      one well-shaped project, small protected team, no interruptions
```

**Don't:** Delegate the first architecture to a build team, copy large-team ceremony into a tiny team, or let cleanup stretch from launch nerves.

**Break it when:** The product exists and the change is additive; use the normal flow.

**Source:** https://basecamp.com/shapeup/2.3-chapter-09 ; https://basecamp.com/shapeup/4.1-appendix-02 ; https://basecamp.com/shapeup/4.2-appendix-03. Docs only.
