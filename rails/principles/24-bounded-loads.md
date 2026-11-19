# Load only what you need, in bounds

**Rule:** Never loop over a whole table as objects. Process ordered batches with a checkpoint, let the database compute aggregates, and make lazy loading of related data an error in development and test.

**Why:** Loading everything builds an object per row and holds them all. Batches resume after interruption. The database counts and sums faster than objects can. Eager loading cannot prove nothing is still lazy, so strict mode raises on the N+1 before production.

**Do:**
```
last = checkpoint.load() or MIN
loop: rows = select where key > last order by key limit 1000     # unique key
      if empty: break; process(rows); last = rows.last.key; checkpoint.save(last)
total = sum(orders.subtotal where ...);  ids = pluck(books.id)   # no objects
dev/test: posts = load_all(posts, with: [author]); post.comments (not loaded) -> raises
prod: log only, never raise
```

**Don't:** Loop a big table as objects, batch by a non-unique or changing column, or turn strict raising on in production where it becomes an outage.

**Break it when:** The set is small (under about a thousand rows), you need model behavior on the values, or in one-off admin and console work.

**Source:** Guides: https://guides.rubyonrails.org/active_record_querying.html (Retrieving Multiple Records in Batches, Calculations, pluck, N + 1 Queries Problem, strict_loading); https://guides.rubyonrails.org/6_1_release_notes.html (Strict Loading Associations); https://guides.rubyonrails.org/association_basics.html (:strict_loading). Code: activerecord/lib/active_record/relation/batches.rb:10,140-165,373-385; activerecord/lib/active_record/core.rb:99-100,277-285.
