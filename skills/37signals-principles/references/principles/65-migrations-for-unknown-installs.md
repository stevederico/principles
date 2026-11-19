# Ship schema changes in additive steps that tolerate unknown installs

**Rule:** Make migrations idempotent and tolerant of dirty data, backfill before adding a not-null, resolve duplicates before a unique index, and for a breaking change stage it: a bridge version that reads old and new, nullable column, dual-write, backfill, constrain, switch reads, drop the old.

**Why:** Operators upgrade from any version, and the singleton migration notes an install may already hold more than one account. Deploys are not instantaneous; queued jobs from before the change must still work, and new migrations stay optional until a major version. A disposable table such as a cache can simply be truncated.

**Do:**
```
add column nullable ; deploy code that writes it ; backfill ; add not-null and index
return unless table exists ; add index if not exists
absent new field -> old behavior ; changed default -> document how to restore it
```

**Don't:** Skip across a breaking release, require in-flight jobs to match a new format at once, or assume a clean schema.

**Break it when:** The table is new in the same release, or a major version declares the legacy path removed (announce the precondition).

**Source:** https://github.com/basecamp/writebook db/migrate/20261031120000_add_singleton_guard_to_accounts.rb ; https://github.com/basecamp/once-campfire db/migrate/20240131105830_alter_users_set_password_digest_not_null.rb ; https://github.com/rails/solid_cache upgrading_to_version_0.4.x.md ; https://github.com/rails/solid_queue UPGRADING.md.
