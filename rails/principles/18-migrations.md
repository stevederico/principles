# Schema changes are versioned

**Rule:** Make every schema change a small, ordered, committed script with a unique timestamp id, applied once per database and recorded. Also commit a generated snapshot of the schema: existing databases run pending scripts, fresh ones load the snapshot.

**Why:** Scripts give reviewable history. Replaying years of them breaks, because old scripts lean on code that moved on, so a snapshot is faster and shows changes as a diff. Timestamps avoid id collisions across branches. A version stamp keeps changed defaults from rewriting old history.

**Do:**
```
migrations/20261119143005_add_slug      # id = timestamp, written for tool v8.0
applied = table of versions;  pending = scripts not in applied
after migrate: regenerate snapshot (committed, never hand-edited)
existing db: run pending       fresh db: load snapshot, mark versions applied
snapshot header says "tool v8.0", so the loader applies v8.0 defaults
CI: fail when a script is pending
```

**Don't:** Edit the database or the snapshot by hand, edit a script that already ran elsewhere, or build test databases by replaying everything.

**Break it when:** Never for shipped scripts: fix forward. Use the database's own structure dump if the snapshot cannot express triggers or procedures. Run a full replay in CI now and then to prove the scripts still work.

**Source:** Guides: https://guides.rubyonrails.org/command_line.html (Schema Management); https://guides.rubyonrails.org/active_record_migrations.html (Schema Dumping and You, Old Migrations); https://guides.rubyonrails.org/8_0_release_notes.html (fresh database loads the schema); https://guides.rubyonrails.org/configuring.html (timestamped_migrations, validate_migration_timestamps). Code: activerecord/lib/active_record/railties/databases.rake:94-100,383-392; activerecord/lib/active_record/tasks/database_tasks.rb:180-210; activerecord/lib/active_record/migration.rb:624-636; activerecord/lib/active_record/schema_dumper.rb:128.
