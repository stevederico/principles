# Say what cannot be undone, and run scripts atomically

**Rule:** Make each schema script reversible by construction, state plainly when it is not, run it inside one transaction where the database can roll back schema changes, and lock so two hosts never migrate at once.

**Why:** Before transactional scripts, a failure at step 3 left steps 1 and 2 applied but the version marked done, so the script could not be rerun. A down step that silently does nothing is worse than an honest refusal.

**Do:**
```
add_column(users, nickname)             # reverse derived automatically
remove_column(users, nickname, type)    # type given so it can be restored
add enum value "review"                 # down: IRREVERSIBLE -> raise
run():
  acquire lock(db) or abort; reload applied versions
  for each pending: transaction { run; record version }   # opt out for steps that cannot
```

**Don't:** Write an empty down step, mix several irreversible steps in one script on a database without schema transactions, or migrate from several hosts unlocked.

**Break it when:** A statement cannot run in a transaction (building an index concurrently): opt that script out and keep it to one step. For data loss, fix forward with a new script.

**Source:** Guides: https://guides.rubyonrails.org/active_record_migrations.html (Using the change Method, Throwing an error to prevent reverts, Transactions); https://guides.rubyonrails.org/2_2_release_notes.html (Transactional Migrations); https://guides.rubyonrails.org/active_record_postgresql.html (Enumerated Types). Code: activerecord/lib/active_record/migration/command_recorder.rb:134-140,204-229,369; activerecord/lib/active_record/migration.rb:1630-1666.
