# Once and only once, both halves

**Rule:** Say each intention exactly once, but do not merge two pieces of code whose intentions differ even when they look alike.

**Why:** The usual reading stops at removing duplicates. The first half matters just as much: express the full intention of the code, even at the price of duplication. The site's example is multiplying by 100 for a percentage and for meters to centimeters: two named functions, because the names say why and which inputs are valid.

**Do:**
```
percent(fraction)        = fraction * 100
centimeters(meters)      = meters * 100
# not: convert_percent_or_meters(x)   # one function, two intents
```

**Don't:** Merging look-alike code into one vague function just to remove duplication.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/simple.html, http://www.extremeprogramming.org/rules/refactor.html
