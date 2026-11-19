# Keep data changes out of schema scripts

**Rule:** Change structure in migrations. Run backfills and content changes as separate, resumable, observable scripts, and switch reads to a derived column only after it is filled.

**Why:** Schema and data have different lifecycles, long data jobs lock tables, and data changes are hard to roll back. A migration that loads application models breaks the day the model changes.

**Do:**
```
migration 1: add column plan_name (nullable)
script:      backfill plan_name in batches, pausable, safe to re-run
migration 2: make plan_name not null
counter column: add (default 0) and keep updating on writes while reads still COUNT;
                backfill; then flip reads to the column
```

**Don't:** Reshape rows through application models inside a migration, or add a counter and read it in the same deploy.

**Break it when:** Tiny static seed data must exist in every environment right now.

**Source:** Guides: https://guides.rubyonrails.org/active_record_migrations.html (Data Migrations, Migrations and Seed Data, What are Schema Files for?); https://guides.rubyonrails.org/association_basics.html (Counter Cache). Code: activerecord/lib/active_record/reflection.rb:398,571.
