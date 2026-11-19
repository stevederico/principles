# Query safety

**Rule:** Pass user values only as bound parameters, map user-chosen columns or sort fields to a fixed allowlist, wrap every OR condition in a group, and refuse a clause the engine cannot honor instead of dropping it.

**Why:** Binding cannot bind identifiers, so a user-chosen column reaches the SQL text. A bare OR escapes every earlier filter, including global ones (tenant, soft delete). A silently ignored limit turned a bounded delete into an unbounded one.

**Do:**
```
allowed = ["name", "created_at"]
col = request.sort if request.sort in allowed else "created_at"
query.order_by(col).where("age", ">", request.min_age)           # value is bound
where(active).where_group(a = 1 or b = 2)                        # active AND (a OR b)
delete with a limit the engine cannot bound: raise
```

**Don't:** order_by(request.sort), where_raw("age > " + request.min_age), where(active).or_where(a = 1).

**Break it when:** Raw fragments are fine with a bindings list and text you wrote. A lone top-level query with no other filter and no global scopes needs no group.

**Source:** https://laravel.com/docs/queries, https://laravel.com/docs/eloquent-relationships, https://laravel.com/docs/upgrade ; code: src/Illuminate/Database/Query/Builder.php
