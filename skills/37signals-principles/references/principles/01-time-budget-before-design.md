# Set the time budget first, then design to fit it

**Rule:** Decide how much time an idea deserves before designing it, then shrink the solution to fit; when work overruns, cut scope, never the date or the quality.

**Why:** An estimate starts from a design and ends with a number; a budget starts from a number and ends with a design. The same problem has different right answers at two weeks and six weeks, and without a limit there is always a better version, so debate never ends. Fixed time plus fixed money forces early prioritisation, and cut items can always return later.

**Do:**
```
budget = decide("how much is this worth?")        # days or weeks, not "how long will it take"
design = smallest_solution(problem, budget)
while estimate(design) > budget:
    design.remove(least_important_part)            # parked, not lost
```

**Don't:** Ask for an estimate of an open-ended idea and then treat the number as a promise while scope stays fixed. Do not reject a simple solution because a fancier one exists.

**Break it when:** Scope is a fixed obligation (compliance, contract, safety). Then estimate honestly and say that scope cannot flex. Also when the cheap version creates a cost that outlasts the budget, such as data that cannot be migrated later.

**Source:** https://basecamp.com/shapeup/1.2-chapter-03 ; https://basecamp.com/gettingreal/02.4-fix-time-and-budget-flex-scope ; https://basecamp.com/gettingreal/03.4-embrace-constraints. Docs only.
