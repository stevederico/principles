# Keep modules mid-sized and audit them against concrete numbers

**Rule:** Size modules so a person can hold one in mind, avoid splitting so far that interfaces dominate, and review code for globals, oversized functions, missing internal interfaces and too many entry points.

**Why:** Defect density against module size is U-shaped: very large and very small modules both breed bugs, because at small grain the cost of interfaces swamps the gain. The reported sweet spot is a few hundred logical lines, a hint rather than a law. A function whose promise to callers cannot be stated in one line is probably too big, a procedure-call hierarchy deeper than about four levels is a warning, and working memory holds only about seven items.

**Do:**
```
for each function: write_one_line_contract(); if impossible: split
count(globals, entry_points_per_module, call_depth); flag outliers
if module > few_hundred_logical_lines: split_along_real_seam()
if splitting made interfaces dominate: merge_back()
```

**Don't:** Judge by line count alone, or keep splitting until each piece needs the whole system to be understood.

**Break it when:** Your own measurements show a different sweet spot, or a flagged outlier is justified and documented.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch04s01.html (Encapsulation and Optimal Module Size) ; http://www.catb.org/esr/writings/taoup/html/ch04s06.html (Coding for Modularity) ; http://www.catb.org/esr/writings/taoup/html/ch06s02.html (Coding for Transparency and Discoverability). Book only.
