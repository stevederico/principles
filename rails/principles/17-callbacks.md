# Callbacks with restraint

**Rule:** Use lifecycle hooks (before save, after create) only for things that belong to the object itself. Keep side effects out.

**Why:** Hooks run invisibly. Hidden emails, charges, or API calls make behavior hard to follow and tests hard to write.

**Do:**
```
before_save: normalize email to lowercase        # about the object
publish(post): save; enqueue notify(post)         # side effect, explicit
```

**Don't:** Send an email or call another service from `after_save`.

**Break it when:** A hook is truly part of the invariant. Keep it tiny and obvious.

**Source:** Rails practice, callback guidance.
