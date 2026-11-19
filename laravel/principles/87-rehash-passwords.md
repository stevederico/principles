# Rehash passwords on login

**Rule:** Store passwords with a slow, tunable hash, and on each successful login re-hash the plain text just verified if the stored hash used weaker settings than today's.

**Why:** Work factors must rise over time, and login is the only moment the plain value exists, so it is the only time you can upgrade without a reset. Verification algorithm checks also reject foreign hash formats.

**Do:**
```
on login_success(user, plain):
  if hasher.needs_rehash(user.password_hash): user.password_hash = hasher.make(plain); save(user)
```

**Don't:** Leaving old low-cost hashes forever, or forcing everyone to reset to raise the cost.

**Break it when:** Login that never sees plain text (single sign-on, tokens): upgrade at next password change. A custom provider without write access needs a switch to disable it.

**Source:** https://laravel.com/docs/hashing, https://laravel.com/docs/authentication ; code: src/Illuminate/Auth/EloquentUserProvider.php, src/Illuminate/Auth/SessionGuard.php
