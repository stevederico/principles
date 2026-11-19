# No one paradigm

**Rule:** Use whatever style fits the problem: objects, functions, data pipelines, declarative setup. Do not force one style everywhere.

**Why:** Real problems are mixed. A purist rule makes some parts awkward, and borrowing the best idea from each style reads better in more places.

**Do:**
```
# declarative where it describes data
relation comments: removed when the post is removed

# functional where it transforms data
titles = sort(map(posts, title))

# plain procedure where the steps matter
publish(post): validate; save; notify
```

**Don't:** Wrap a three-line procedure in a pattern class to stay pure.

**Break it when:** A team needs one style for consistency. Then write the rule down.

**Source:** Doctrine: https://rubyonrails.org/doctrine (No one paradigm). Docs only: no guide page states this rule and no code enforces it.
