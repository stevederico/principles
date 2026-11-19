# Collective ownership

**Rule:** Let any developer change any line of code at any time, backed by unit tests that run 100 percent before each release.

**Why:** No one becomes a bottleneck, and no single architect can hold a non-trivial system in mind, so the design is already spread across the team and authority should follow. It is more reliable than a per-class owner, who can leave. On C3 a shared integration station led to this; the author estimates the team then worked about six and a half times faster. It needs tests first: without them you cannot let everyone edit the core classes.

**Do:**
```
write unit tests as you code; release only at 100%
need a change in any class? make it, run all tests, release
never wait for the owner of a class
```

**Don't:** Naming class owners or a chief architect who gatekeeps changes.

**Break it when:** The site names no exception.

**Source:** http://www.extremeprogramming.org/rules/collective.html, http://www.extremeprogramming.org/don.html, http://www.extremeprogramming.org/start.html, http://www.extremeprogramming.org/rules/unittests.html
