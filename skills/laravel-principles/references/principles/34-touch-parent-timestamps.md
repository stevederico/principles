# Touch the parent

**Rule:** Declare which parent records have their updated-at refreshed when a child is saved, so caches, ETags and keys derived from the parent expire when the child changes.

**Why:** A comment edit should invalidate the page cached for its post. The touch walks upward through parents. It only happens when the child is saved through the record, so a bulk statement that skips the save path does not touch anything.

**Do:**
```
Comment touches [post]                 # saving a comment updates post.updated_at
cache_key(post) = post.id + ":" + post.updated_at
```

**Don't:** Forgetting to declare it and serving stale pages, or expecting it after a bulk update.

**Break it when:** The parent's timestamp has its own meaning, such as last edited by its author.

**Source:** https://laravel.com/docs/eloquent-relationships ; code: src/Illuminate/Database/Eloquent/Concerns/HasRelationships.php
