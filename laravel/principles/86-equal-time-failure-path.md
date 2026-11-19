# Equal-time failure path

**Rule:** When an operation reveals whether an account exists or a secret is right, pad the failing branch to a fixed minimum duration and let the success branch return early.

**Why:** Response-time differences let an attacker tell valid from invalid users. The floor must exceed your slowest real failure, otherwise padding does nothing.

**Do:**
```
timebox(200ms):
  user = find(credentials)
  ok = user and check(user, credentials.password)
  if ok: return_early_ok
  return false                    # waits out the rest of the floor, also on exceptions
```

**Don't:** Returning at once on "no such user" while running a slow hash when the user exists.

**Break it when:** The identity is public anyway (public handles) and enumeration does not matter.

**Source:** https://laravel.com/docs/helpers ; code: src/Illuminate/Support/Timebox.php, src/Illuminate/Auth/SessionGuard.php, src/Illuminate/Auth/Passwords/PasswordBroker.php
