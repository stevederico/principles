# Fight software rot

**Rule:** Fight decay from the first day by refactoring, keeping tests, delivering early and treating requirements, analysis and design as never done.

**Why:** Rot comes from easy changes taken instead of hard design changes, and duplication piling up, until one bug fix causes several worse bugs. The cost-of-change curve (ratios from 5:1 up to 100:1) warns you to be ready, not to write perfect documents; a well-run project keeps the curve low longer. Three events speed rot: declaring the design done, switching process at maintenance, and the cost of vital changes passing your resources. About 20 percent of changes cost 80 percent of effort, so estimate honestly and let the customer guide spending.

**Do:**
```
never declare design final
same process in development and maintenance
refactor continually; keep unit and acceptance tests as the fear-remover
deliver partial systems early to find big changes while cheap
```

**Don't:** Freezing the design, changing process on entering maintenance, or saying code quality does not matter because customers never see it.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/change.html, http://www.extremeprogramming.org/lessons.html
