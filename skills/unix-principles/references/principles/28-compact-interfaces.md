# Keep interfaces compact enough to fit in a head

**Rule:** Shape APIs, command sets and protocols so the working set for normal use is small and a reference card, not a manual, covers most expert work.

**Why:** Human short-term memory is small, so compact designs are pleasant, productive and less likely to cause damage. Redundant ways to do the same thing push each programmer into a private subset, which makes shared code hard to read.

**Do:**
```
count(entry_points_in_core_set); aim for around seven
if the feature set is rich: layer it so the common subset stays small
```

**Don't:** Add a second route to something already possible.

**Break it when:** The domain is truly too complex for a compact design and the power justifies the cost, as in networking interfaces; treat compactness as a strong preference, not an absolute.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch04s02.html (Compactness and Orthogonality) ; http://www.catb.org/esr/writings/taoup/html/ch04s06.html (Coding for Modularity). Book only.
