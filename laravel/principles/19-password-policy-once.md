# One password policy

**Rule:** Define the password policy (length, character mix, breach check) in one default that every form uses, vary it by environment if needed, and check breaches with a range query that reveals only a short hash prefix.

**Why:** One definition means one edit. In the framework only the first five characters of the password's SHA-1 are sent to the breach service and the rest is compared locally, and a failed lookup is reported and treated as "not found" instead of blocking sign-up.

**Do:**
```
password_defaults = min(8) + (production ? mixed_case + uncompromised : nothing)
rule: password: [required, confirmed, password_defaults]
breach(p): h = sha1(p); matches = service.range(prefix(h, 5)); return suffix(h) in matches
on service error: report it, allow the password
```

**Don't:** Sending a full password or full hash to a third party, or copying a different length rule into each form.

**Break it when:** A policy that demands sign-up be blocked when the check cannot run: fail closed on purpose.

**Source:** https://laravel.com/docs/validation ; code: src/Illuminate/Validation/NotPwnedVerifier.php, src/Illuminate/Validation/Rules/Password.php
