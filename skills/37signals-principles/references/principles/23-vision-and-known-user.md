# Write a one-sentence vision, know your user, take sides

**Rule:** State the product's purpose in one sentence, add a few short maxims that say which way to fail, build first for a problem you or a named core audience really have, and commit to an approach instead of staying neutral.

**Why:** A short upfront statement settles many small choices. Every decision made without knowing the user is a guess, and guesses accumulate as hidden debt. People choose products for their approach as much as features; a stripped stance can be the reason something works. Maxims set the direction of failure, such as a payments switch that errs toward not processing rather than double processing.

**Do:**
```
vision = "<one sentence>" ; maxims = ["err toward <safe side>"]
core_user = { who } ; ask self-as-user or a real user, never leave a silent guess
on decision d: accept only if consistent_with(vision, maxims, core_user)
publish the approach so non-fitting users self-select out
```

**Don't:** Write a long mission, design for an imagined audience, or chase users who dislike the approach.

**Break it when:** Your own need is unrepresentative (sit with real users early), the vision proves wrong (change it openly), or you build a platform whose users are builders (keep the opinion in defaults, not locked doors).

**Source:** https://basecamp.com/gettingreal/04.1-whats-the-big-idea ; https://basecamp.com/gettingreal/02.2-whats-your-problem ; https://basecamp.com/gettingreal/04.4-hire-the-right-customers ; https://basecamp.com/gettingreal/04.6-make-opinionated-software. Docs only.
