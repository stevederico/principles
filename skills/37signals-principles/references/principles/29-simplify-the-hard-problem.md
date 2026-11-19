# Restate the hard problem as an easier one

**Rule:** Prefer a variant that serves most of the need with a fraction of the code, let engineers counter-offer, and treat implementation difficulty as design feedback.

**Why:** Complexity grows faster than line count; less code means fewer bugs, less support and cheaper change. The original problem is rarely worth five times the effort. Pain in the code often points to a better model, and a copy change can sometimes route users around the need for code entirely.

**Do:**
```
for request in hard_requests:
    option = cheaper_variant(request)       # "will not do X, will do Y in 1h not 12h"
    consider: change the wording so users take a path needing no code
if estimate(feature) is large: search for a variant with a small estimate
if the team reports change is hard: schedule the fix
```

**Don't:** Implement the literal request when a simpler one serves 80 percent, or force the large version through.

**Break it when:** The remaining 20 percent is the safety or compliance part, or the large version is the core differentiator.

**Source:** https://basecamp.com/gettingreal/10.1-less-software ; https://basecamp.com/gettingreal/10.3-code-speaks. Docs only.
