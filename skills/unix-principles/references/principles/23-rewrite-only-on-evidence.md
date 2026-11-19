# Rewrite only on evidence, and keep the rewrite small

**Rule:** Scrap a bad design instead of patching it forever, but weigh the field-tested behavior you would lose, and keep the replacement near the proven core instead of restoring everything the first version left out.

**Why:** A clean small design usually comes from starting simple again, yet successors of small systems tend to balloon and collapse under their own weight. Years of fixes for odd platforms and quirky peers are knowledge that is costly to re-learn. A merely adequate incumbent is a strong opponent, so a rewrite must be decisively better or be adopted piecemeal.

**Do:**
```
if repair_cost > rebuild_cost(against_the_spec) and quirks_listed_and_covered:
    rebuild(core + features_with_measured_demand)
else:
    adopt_improvements_incrementally()
```

**Don't:** Justify patching by money already spent, rewrite for fashion, or treat a rewrite as the chance to add every deferred wish.

**Break it when:** The old code is a dead end that blocks a requirement it cannot meet.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch02s01.html (Origins and History of Unix, 1969-1995 (second-system effect)) ; http://www.catb.org/esr/writings/taoup/html/ch17s04.html (Specifications as DNA, Code as RNA) ; http://www.catb.org/esr/writings/taoup/html/ch14s04.html (Language Evaluations (C case study)) ; http://www.catb.org/esr/writings/taoup/html/plan9.html (Plan 9: The Way the Future Was). Book only.
