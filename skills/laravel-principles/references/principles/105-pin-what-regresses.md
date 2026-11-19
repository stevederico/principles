# Pin what regresses

**Rule:** Assert the exact query count on hot pages and make response shape assertions strict, so unmentioned fields fail the test unless you say others are allowed.

**Why:** N+1 growth then fails a test instead of production, and a loose "contains this fragment" check passes even when a password field leaks.

**Do:**
```
expect_query_count(5); render_orders_page()
assert_json(response): where id == 1 ; missing "password" ; allow_other_fields()   # remove to be strict
```

**Don't:** Asserting only on output for pages that load relations, or only a fragment of a response.

**Break it when:** The count is legitimately data dependent, or the shape is open-ended (third-party passthrough).

**Source:** https://laravel.com/docs/database-testing, https://laravel.com/docs/http-tests ; code: src/Illuminate/Foundation/Testing/Concerns/InteractsWithDatabase.php, src/Illuminate/Testing/Fluent/Concerns/Interaction.php
