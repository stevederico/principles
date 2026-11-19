# Majestic monolith

**Rule:** Start with one deployable app. Split only when a measured problem demands it.

**Why:** Services add network calls, versioning, and deploy coordination. A monolith keeps code in one place, makes refactoring easy, and lets a small team move fast.

**Do:**
```
one repo, one app, one database, one deploy
clear internal modules (billing, accounts, content)
extract a service only when one module needs separate scaling or ownership
```

**Don't:** Build microservices on day one "for scale" you do not have.

**Break it when:** Different parts have very different load, security boundaries, or teams.

**Source:** Rails practice, "The Majestic Monolith" (DHH).
