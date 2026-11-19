# Store state as named values, and deactivate instead of deleting

**Rule:** Keep state in string-valued enums with domain names; replace a boolean with a status when a third state appears; deactivate users and trash content instead of deleting, and route every lookup through the live scope.

**Why:** States stay readable in the database and scopes; parallel booleans can disagree. Other records still point to people and pages, and trashed pages kept their revisions readable until lookups were scoped to active ones. Deactivation removes credentials and rewrites the unique email so it can be reused.

**Do:**
```
status in { active, deactivated, banned } ; involvement in { invisible, nothing, mentions, everything }
migration: add status ; fill from old flag ; drop flag
user.deactivate: transaction { delete sessions ; status = deactivated ; email = unique placeholder }
find through book.leaves.active.find(id)
```

**Don't:** Keep `active` and `banned` as two booleans, or hard delete authors of content.

**Break it when:** The state is truly binary, or privacy law demands erasure (add a purge path).

**Source:** https://github.com/basecamp/once-campfire app/models/user.rb, app/models/membership.rb, db/migrate/20251126115722_change_active_to_status_on_users.rb ; https://github.com/basecamp/writebook app/models/leaf.rb, app/models/access.rb, app/controllers/concerns/page_leaf_scoped.rb.
