# Search as a derived copy

**Rule:** Treat a search index as a derived copy of your records: start with the database's own search, sync the copy from write events through a queue as idempotent upserts, index only what should be found, and re-apply access rules after the engine answers.

**Why:** Observers keep the index current without the saving code knowing, and the queue keeps pages fast; engines may lag. A database engine reads your table so global scopes apply, but an external engine does not know them, and the callback that customizes the final lookup runs after the engine chose results. Cheap recall first, then rerank only that small set. Engine settings belong in versioned config applied at deploy.

**Do:**
```
on Post.saved: queue(index_upsert(post)) ; on Post.deleted: queue(index_remove(post))
should_be_searchable(post): post.is_published
ids = engine.search(q, filters = {team_id: me.team})
rows = Post.where(id in ids)                 # then apply row rules yourself
candidates = full_text(q).limit(50); best = rerank(candidates, q).limit(10)
```

**Don't:** Calling the search service inline so its outage fails the save, trusting default scopes to hide rows, or reranking the whole table.

**Break it when:** Tiny scale on the in-database engine, where there is no separate copy. A corpus small enough that one stage suffices.

**Source:** https://laravel.com/docs/search, https://laravel.com/docs/scout ; code: src/Illuminate/Database/Eloquent/Concerns/HasEvents.php, src/Illuminate/Database/Query/Builder.php, src/Illuminate/Bus/UniqueLock.php
