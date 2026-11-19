# No one paradigm

**Rule:** Use whatever style fits the problem: objects, functions, data pipelines, declarative setup. Do not force one style everywhere.

**Why:** Real problems are mixed. A purist rule makes some parts awkward. Taking the best idea from each style gives a framework that reads well in more places.

**Do:**
```
# declarative where it describes data
has_many comments, on_delete: remove

# functional where it transforms data
posts.map(title).sort

# plain procedures where steps matter
publish(post): validate; save; notify
```

**Don't:** Wrap a three-line procedure in a pattern class to stay "pure".

**Break it when:** A team needs one style for consistency. Then write the rule down.

**Source:** Rails Doctrine, "No one paradigm".
