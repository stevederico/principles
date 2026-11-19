# Stored type names are aliases

**Rule:** In a polymorphic link store a short stable alias for the target type plus its id, keep the alias-to-class map in one place, and optionally refuse types that have no alias.

**Why:** A stored class name ties rows to the code layout, so renaming or moving a class breaks existing data. The pair of type and id also keeps user 1 and team 1 apart. Enforcing the map turns an unmapped type into an error instead of a silent full class name.

**Do:**
```
type_map = { post: Post, video: Video, team: Team }
require_map = true                        # unmapped type raises
comment.target_type = "post"; comment.target_id = 7
```

**Don't:** Letting the default class name reach a long-lived table. Adding a map to a live system also means rewriting the stored rows.

**Break it when:** Throwaway or prototype data.

**Source:** https://laravel.com/docs/eloquent-relationships, https://laravel.com/docs/ai-sdk ; code: src/Illuminate/Database/Eloquent/Relations/Relation.php, src/Illuminate/Database/Eloquent/Concerns/HasRelationships.php
