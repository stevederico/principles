# Programmer happiness

**Rule:** Optimize for how it feels to write and read the code, not only for speed or purity.

**Why:** Happy people work longer, care more, and make fewer careless mistakes. Joy is a design input, not a bonus.

**Do:**
```
# Reads like a sentence
user.posts.published.recent.first(5)

# Not
PostQuery.new(user_id: user.id, status: 2).order(created, DESC).limit(5).run()
```

**Don't:** Pick the clunky API because it is easier to implement. The cost moves to every reader forever.

**Break it when:** A hot path needs raw speed. Isolate it and label it.

**Source:** Rails Doctrine, "Optimize for programmer happiness".
