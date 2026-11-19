# Progress over stability

**Rule:** Prefer better ideas to unchanging ones. Breaking changes are acceptable when they move things forward, if you give people a path.

**Why:** A framework frozen for compatibility rots. Users stay current when upgrades are worth the cost and the cost is small.

**Do:**
```
v2 removes old_api
deprecate old_api in v1.9 with a warning and the replacement named
ship an upgrade guide
```

**Don't:** Break things silently, or keep every mistake alive forever.

**Break it when:** You have a large user base that cannot move. Then lengthen the deprecation window.

**Source:** Rails Doctrine, "Progress over stability".
