# Prefer simple algorithms and data structures until n is known to be large

**Rule:** Choose the plain algorithm, let a good data structure make it obvious, keep hot data compact, and reach for a sophisticated method only when measurement shows large n on a hot path.

**Why:** Fancy methods carry large constants, lose at the small sizes that are usually real, and are buggier. Organizing the data dominates algorithm choice. Moving between memory levels grows relatively costlier over time, so size-for-speed tricks such as lookup tables or unrolling can lose to recomputation and may expire.

**Do:**
```
if n_is_small_or_unknown: use plain_scan or simple_structure
if measured(n_large) and hot: consider(fancy_method) and re-measure
measure with and without any precomputed table or unrolled loop
```

**Don't:** Introduce a clever structure for hypothetical scale.

**Break it when:** You know up front that n is large, such as a data-store index.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Optimization (Pike's rules and brute-force maxim)) ; http://www.catb.org/esr/writings/taoup/html/ch12s03.html (Nonlocality Considered Harmful). Book only.
