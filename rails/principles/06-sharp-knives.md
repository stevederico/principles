# Provide sharp knives

**Rule:** Trust developers with powerful tools. Make the safe path the easy path, but do not remove the dangerous one.

**Why:** A dull knife is more dangerous because it slips. Locking away power makes experts work around the framework. Treat people as adults.

**Do:**
```
save(record)           # default: validates, safe
save(record, skip_validation: true)   # explicit, visible, allowed
```

**Don't:** Forbid an operation because someone could misuse it. Warn, name it clearly, and let them proceed.

**Break it when:** The damage is irreversible and silent (data loss, security holes). Then add friction, not a wall.

**Source:** Rails Doctrine, "Provide sharp knives".
