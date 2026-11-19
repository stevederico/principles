# Name your queries

**Rule:** Give common filters a name on the domain object, and chain them.

**Why:** Names turn query details into intent. The filter is defined once and tested once.

**Do:**
```
Post.scope published = where(status = "published")
Post.scope recent    = order(created DESC)

Post.published.recent.first(5)
```

**Don't:** Repeat `where(status = "published" AND deleted = false)` across ten files.

**Break it when:** A query is used once and never changes. Inline it.

**Source:** Rails practice, Active Record scopes.
