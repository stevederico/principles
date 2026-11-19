# Find the identity, then prove the request

**Rule:** Split authentication into two parts: a user provider that fetches an identity from storage by non-secret fields, and a guard that decides how each request proves it, and never check the secret during the lookup.

**Why:** Storage can change (SQL or documents) without touching how requests authenticate (cookie or token), and the reverse. A lookup that ignores secrets cannot short-circuit or leak the verification; the framework strips the password field before querying and compares the hash in one separate step.

**Do:**
```
provider.find_by_credentials(creds):  query by creds minus the secret fields
provider.verify(user, creds):          the only place the hash is compared
guard.attempt(creds): user = provider.find(creds)
                      if user and provider.verify(user, creds): login(user)
```

**Don't:** One query that matches email and password together, or a user type welded to one storage engine.

**Break it when:** A tiny internal tool with one fixed credential.

**Source:** https://laravel.com/docs/authentication ; code: src/Illuminate/Auth/EloquentUserProvider.php
