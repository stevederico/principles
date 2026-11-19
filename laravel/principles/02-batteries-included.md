# Batteries included

**Rule:** Ship a first-party answer for every common need: auth, mail, queues, files, cache, search, billing helpers, testing.

**Why:** Every missing piece means a library hunt, an integration, and a different style. One official answer keeps apps consistent and lets teams start building the feature.

**Do:**
```
new app already has: login, password reset, email, jobs, file storage, tests
each part uses the same naming and the same config style
```

**Don't:** Leave basics to "find a package" and let each project invent its own.

**Break it when:** A need is rare. Offer an optional package instead of core bloat.

**Source:** Laravel philosophy, first-party ecosystem.
