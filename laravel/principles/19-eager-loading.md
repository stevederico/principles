# Eager loading

**Rule:** When you will read related records for many items, load them together up front (one extra query per relation), or count and aggregate them in the parent query instead of loading them.

**Why:** Loading inside a loop runs one query per item: 25 books cost 26 queries lazily and 2 eagerly. Counts, sums and existence come back as extra fields on each parent. The same N+1 shape appears wherever a lookup sits inside a loop, even feature-flag checks.

**Do:**
```
posts = Post.with(author, comments).get()                 # 1 + 2 queries
posts = Post.with_count(comments).where_has(comments, body like "code%")
posts.load_missing(author)                                # list already fetched
posts = Post.with(comments.link_parent())                 # children see their parent, no query
```

**Don't:** Reading post.author in a loop, or post.comments.length in a list view.

**Break it when:** You only learn after loading whether the relation is needed: load it afterwards for the whole set, or turn on automatic batching. A one-row-at-a-time cursor cannot eager load; use chunks.

**Source:** https://laravel.com/docs/eloquent-relationships, https://laravel.com/docs/eloquent, https://laravel.com/docs/eloquent-collections, https://laravel.com/docs/pennant ; code: src/Illuminate/Database/Eloquent/Builder.php, src/Illuminate/Database/Eloquent/Concerns/QueriesRelationships.php, src/Illuminate/Database/Eloquent/Model.php
