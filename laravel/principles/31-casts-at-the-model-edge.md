# Casts at the model edge

**Rule:** Declare per-field conversions once (int to bool, text to structure, string to enum, several columns to a value object, secrets to encrypted or hashed) and apply them when reading from and writing to storage, and store times in UTC.

**Why:** Domain code sees real types while storage keeps primitives, and dirty checks compare converted values, ignoring JSON key order and float noise. Output date format is a separate setting from storage. Encrypted columns cannot be queried, and a hashed field is write-only.

**Do:**
```
casts: is_admin: bool, options: json, status: ServerStatus, amount: decimal(2)
       ssn: encrypted, password: hashed
address: get(row) = Address(row.line1, row.line2) ; set(a) = {line1, line2}
output(date) = iso8601_utc(date)
```

**Don't:** Converting at each call site, filtering or sorting on an encrypted column, storing local times, or casting a primary key.

**Break it when:** A field is only ever an opaque string. A value that is inherently local (9:00 in a named zone): store the zone beside it.

**Source:** https://laravel.com/docs/eloquent-mutators, https://laravel.com/docs/eloquent-serialization ; code: src/Illuminate/Database/Eloquent/Concerns/HasAttributes.php
