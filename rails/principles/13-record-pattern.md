# One object per table row

**Rule:** A domain object wraps one database row. It knows how to load, change, and save itself, and carries the rules for its own data.

**Why:** Data and behavior stay together. Fields map to columns by name, so there is almost no mapping code.

**Do:**
```
post = Post.find(5)
post.title = "New"
post.save          # validates and writes
```

**Don't:** Split every row into a data bag, a repository, a mapper, and a service for a simple app.

**Break it when:** Domain logic stops matching the table shape. Then add a separate domain layer on top.

**Source:** Rails practice, Active Record (Fowler pattern).
