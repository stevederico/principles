# Server validation is authoritative

**Rule:** Validate every form and credential input on the server with a schema before touching the database or an external provider, return field-level errors as data, hash passwords before storing, and bind non-field arguments on the server rather than in hidden inputs.

**Why:** Client checks are bypassable and hidden fields are visible in the rendered page. An early return avoids needless provider and database calls. A mutation endpoint is same-origin and holds the secrets, so keys never reach the browser.

**Do:**
```
parsed = schema.safe_parse(input)
if not parsed.ok: return { errors: parsed.field_errors }
db.insert({ ..., password: hash(parsed.password) })
```

**Don't:** Trust required or type attributes as the only validation, put identifiers in hidden fields, or store raw passwords.

**Break it when:** Never skip server validation; add cheap client hints for experience only.

**Source:** https://nextjs.org/docs/app/guides/forms, https://nextjs.org/docs/app/guides/authentication, https://nextjs.org/docs/pages/guides/forms; docs only
