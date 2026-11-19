# Uniqueness on update ignores the record itself

**Rule:** When a uniqueness rule runs on update, exclude the record being edited by its system-generated id taken from the loaded record, and scope the check explicitly (tenant, soft-deleted rows).

**Why:** Without the exclusion a user who saves a profile without changing the email conflicts with themselves. The docs warn that feeding request input into the exclusion argument opens a query-injection hole. Soft-deleted rows count as taken unless the rule is told otherwise.

**Do:**
```
email: required, unique(users).ignore(current_user.id)        # id from the loaded record
slug:  unique(posts).where(account = current_account.id).without_trashed()
```

**Don't:** Passing the id from the request body or query string to the exclusion, or forgetting to scope by tenant.

**Break it when:** A create form, where nothing needs excluding.

**Source:** https://laravel.com/docs/validation ; code: src/Illuminate/Validation/Rules/Unique.php, src/Illuminate/Validation/Rules/DatabaseRule.php
