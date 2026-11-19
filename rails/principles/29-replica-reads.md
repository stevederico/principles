# Read your own writes on replicas

**Rule:** When reads go to replicas, send a user's reads to the writer for a short window after that user writes. Enforce read-only both in the app and in the database permissions of the replica user.

**Why:** Replication lags. A user who just saved a form must see the change; others can tolerate delay. The in-app write guard only catches queries that look like writes, so the database is the real lock.

**Do:**
```
if request is mutating:              use writer; remember last_write_time(user)
elif now - last_write_time < 2 sec:  use writer, forbid writes
else:                                use replica, forbid writes
replica database user: SELECT only
```

**Don't:** Route every read to replicas and wonder why a just-created record is missing, or trust only the in-app guard.

**Break it when:** Other users' lag-sensitive reads (balances, inventory): pin those to the writer explicitly. The framework does not measure real lag.

**Source:** Guide: https://guides.rubyonrails.org/active_record_multiple_databases.html (Automatic Role Switching, Configuring a Replica, Manual Role Switching). Code: activerecord/lib/active_record/middleware/database_selector/resolver.rb:20,51-90; activerecord/lib/active_record/connection_adapters/query_intent.rb:427.
