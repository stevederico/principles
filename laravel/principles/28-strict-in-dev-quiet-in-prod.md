# Strict in dev, quiet in prod

**Rule:** Turn silent mistakes (lazy loading, dropped input fields, missing attributes) into errors outside production, and keep production tolerant or log-only unless the check guards integrity or security.

**Why:** N+1 queries and discarded input are cheap to fix before release, but a production outage is the wrong place to learn of them. A custom violation handler can log instead of throwing.

**Do:**
```
strict_mode(enabled = not is_production)
on_lazy_load_violation(handler)       # production: log it
if input_field_dropped: dev raises, prod drops silently
```

**Don't:** Leaving strict mode off in tests, or throwing on non-critical production paths.

**Break it when:** A check that protects data integrity or security fails hard everywhere.

**Source:** https://laravel.com/docs/eloquent, https://laravel.com/docs/eloquent-relationships ; code: src/Illuminate/Database/Eloquent/Model.php, src/Illuminate/Database/Eloquent/Concerns/HasAttributes.php
