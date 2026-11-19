# One deployment, one account: enforce it in the schema

**Rule:** When each customer runs its own instance, do not thread a tenant id through every query; keep a single account row read through the request context and a unique-guard column so a second row cannot exist.

**Why:** Distinct customer groups mean separate deployments, and the security policy builds on that (the admin is the server operator). Tenant columns everywhere add bugs for no benefit.

**Do:**
```
account = Account.first                      # via request context
accounts.singleton_guard integer default 0 not null, unique index
```

**Don't:** Add `account_id` to every table just in case.

**Break it when:** One process must serve many mutually untrusting customers.

**Source:** https://github.com/basecamp/once-campfire app/models/current.rb, db/migrate/20251212154340_add_singleton_constraint_to_accounts.rb, docs/self-hosting.md, SECURITY.md ; https://github.com/basecamp/writebook db/migrate/20261031120000_add_singleton_guard_to_accounts.rb.
