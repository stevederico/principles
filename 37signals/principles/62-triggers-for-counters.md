# Keep derived counters correct with database triggers

**Rule:** When a counter must be right for ORM writes, raw SQL and foreign connections alike, maintain it in triggers, backfill in the migration, and re-verify them at boot.

**Why:** Model callbacks are skipped by raw paths and would double count if combined with triggers. Schema dumps do not carry triggers, so they must be re-checked.

**Do:**
```
migration: add column ; backfill count ; install insert, delete and update triggers
on boot and after db prepare: ensure triggers exist, else reinstall in one write transaction
```

**Don't:** Increment a counter in an after-create callback.

**Break it when:** Only the application layer ever writes the table.

**Source:** https://github.com/basecamp/once-campfire app/models/room/messages_count.rb, db/migrate/20261007190000_add_messages_count_to_rooms.rb, config/initializers/room_messages_count.rb, lib/tasks/room_messages_count.rake.
