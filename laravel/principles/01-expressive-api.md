# Expressive API

**Rule:** Design every public call so the code reads like a plain sentence. Chain small, named steps.

**Why:** Code is read far more than it is written. A fluent call site shows intent without comments.

**Do:**
```
users.where(active).orderBy(name).limit(10).get()
mail.to(user).send(WelcomeMessage)
```

**Don't:** Make callers pass long positional lists or flags: `query(users, true, "name", 10, null, false)`.

**Break it when:** A hot path needs a raw, flat call. Keep the fluent version as the default.

**Source:** Laravel philosophy, "elegant, expressive syntax".
