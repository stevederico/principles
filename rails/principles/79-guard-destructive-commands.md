# Guard destructive commands

**Rule:** Destructive maintenance tasks refuse to run in protected environments unless the operator sets an explicit override. Interactive access to live data starts safe: a sandbox that rolls back on exit and a read-only query path. A replaceable policy layer can veto or reroute dangerous schema operations.

**Why:** One wrong shell tab should not wipe production, and the override keeps the power available. A console that rolls back lets people try destructive changes safely.

**Do:**
```
protected_environments = [production]
task reset_db: if env in protected and no override flag: error
console --sandbox          # every connection starts a transaction; rolled back on exit
sandbox_by_default = true  # optional for production consoles; --no-sandbox to opt out
query "Account.where(plan: premium)"   # reading role if configured, else writes are blocked
strategy.drop_table(name): if env == production: raise "not allowed"   # swappable policy
```

**Don't:** Make the guard impossible to bypass (people script around it), open a read-write shell on production for a lookup, or hard-code environment checks in every script.

**Break it when:** A disposable environment named like a protected one, or a deliberate data repair (use an explicit, logged, non-sandbox session).

**Source:** Guides: https://guides.rubyonrails.org/configuring.html (protected_environments, sandbox_by_default); https://guides.rubyonrails.org/command_line.html (bin/rails console, bin/rails query); https://guides.rubyonrails.org/active_record_migrations.html (Customizing Migration Behavior with Swappable Strategies). Code: activerecord/lib/active_record.rb:201-211; activerecord/lib/active_record/tasks/database_tasks.rb:71-77; activerecord/lib/active_record/railties/console_sandbox.rb:3-5; railties/lib/rails/commands/console/console_command.rb:44-49; railties/lib/rails/commands/query/query_command.rb:115-140; activerecord/lib/active_record/migration/execution_strategy.rb:40-48.
