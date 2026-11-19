# Build half a product, and price every feature you keep

**Rule:** Ship a small product that does a few things well. Cut the idea list in half, then in half again, and before accepting any feature list the full downstream work and let that list veto it.

**Why:** Starting from the core lets later choices rest on real use. Every feature must be designed, tested, documented, explained, priced and kept forever, and it pulls follow-on features; removing one later angers users. Compete by solving simple, common problems and leaving rare hard ones to others. A mature product need not grow just to justify itself.

**Do:**
```
scope = most_essential(ideas, keep = half), twice
cost = design + build + tests + (help, tour, copy, terms, pricing) + promises_to_check + follow_on
accept only if value > cost ; test: does it change anyone's behaviour?
```

**Don't:** Add every decent idea, estimate only the coding time, or match a competitor's feature matrix.

**Break it when:** A table-stakes capability is missing and users cannot do the core job; or the change is a tiny internal fix touching none of those surfaces.

**Source:** https://basecamp.com/gettingreal/05.1-half-not-half-assed ; https://basecamp.com/gettingreal/05.2-it-just-doesnt-matter ; https://basecamp.com/gettingreal/05.4-hidden-costs ; https://basecamp.com/gettingreal/02.1-build-less ; https://basecamp.com/gettingreal/15.7-beware-the-bloat-monster. Docs only.
