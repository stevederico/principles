# On a single-writer database, take the lock up front and hold it briefly

**Rule:** Open write transactions in immediate mode, do slow pure work (hashing, name resolution, rendering) before the transaction, move checkpointing off the request thread, and re-verify any fact a saved grant depends on inside the same transaction.

**Why:** Comments in both apps say work was reordered to happen before the lock. Inline checkpoints fsync during requests. A password change or room close can commit between an early check and the write; inside an immediate transaction the check and the write are atomic.

**Do:**
```
database: default transaction mode = immediate ; auto checkpoint = off
admin = User.new(params) ; hash password          # before the lock
transaction { create account ; save admin }
subscription: transaction { if session still exists: upsert }
background thread: passive checkpoint every 250 ms under a file lock
```

**Don't:** Take the lock and then call the network, or check at request start and write later.

**Break it when:** The database is a server with row-level locks, or staleness is harmless.

**Source:** https://github.com/basecamp/once-campfire config/database.yml, lib/rails_ext/sqlite_wal_checkpoint.rb, app/controllers/users/push_subscriptions_controller.rb, app/models/session.rb ; https://github.com/basecamp/writebook app/models/first_run.rb.
