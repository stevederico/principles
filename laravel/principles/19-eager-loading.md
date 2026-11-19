# Eager loading

**Rule:** When you will read related records for many items, load them together in one extra query up front.

**Why:** Loading related rows inside a loop runs one query per item. A hundred posts means a hundred and one queries. Two queries do the same job.

**Do:**
```
posts = Post.with(author, comments).get()    # 3 queries total
posts.each: show(post.author.name)
```

**Don't:**
```
posts = Post.all()
posts.each: show(post.author.name)   # 1 query per post
```

**Break it when:** You read the relation for only a few items. Lazy load is fine.

**Source:** Laravel docs, Eloquent relationships (eager loading).
