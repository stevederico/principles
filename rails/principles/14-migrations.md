# Schema changes are versioned

**Rule:** Every database change is a small, ordered, committed script. The schema is rebuilt by replaying them.

**Why:** Everyone gets the same database. History is reviewable. Production and local never drift apart.

**Do:**
```
2026_11_19_001_create_posts:   up: create table posts(...)   down: drop table posts
2026_11_19_002_add_slug:       up: add column slug          down: remove column slug
run pending migrations on deploy
```

**Don't:** Edit the database by hand, or edit an old migration that has already shipped.

**Break it when:** Never for shipped changes. Fix forward with a new migration.

**Source:** Rails practice, Active Record migrations.
