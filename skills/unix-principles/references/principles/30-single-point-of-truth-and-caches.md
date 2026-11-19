# Represent every fact once, and treat a cache as a costly second copy

**Rule:** Give each piece of knowledge exactly one authoritative form and derive all other copies from it; add a cache only after measurement, give it a single owner, and define its invalidation rule first.

**Why:** Duplicates drift: you change some and miss others. A cache is a duplicate that can go stale, and keeping it coherent with its master is leaky, bug-prone and sometimes slower than not caching. A cache owned wholly by one program, which regenerates when its source changes, avoids the worst of it.

**Do:**
```
declare(constants, tables, metadata) once; generate docs, headers and boilerplate from it
cache.owner = exactly_one_component
if measured_uncached_is_too_slow and invalidation_rule_defined: add(cache)
```

**Don't:** Paste the same table into two languages by hand, memoize everything by default, or let several tools write a derived copy and trust timestamps.

**Break it when:** A boundary forces duplication; then generate one side from the other and add a check that they agree.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch04s02.html (The SPOT Rule) ; http://www.catb.org/esr/writings/taoup/html/ch12s04.html (Throughput vs. Latency (Caching Operation Results)). Book only.
