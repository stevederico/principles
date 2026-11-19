# Compose behavior from small modules

**Rule:** Pull a cohesive piece of behavior into a named module and mix it into the objects that need it.

**Why:** Big objects get unreadable. A small module gives the behavior a name and a home, and lets many objects share it.

**Do:**
```
module Archivable: archive(), archived?(), scope archived
Post   includes Archivable
Comment includes Archivable
```

**Don't:** Use modules as junk drawers. One module, one idea, named for what it adds.

**Break it when:** A module needs knowledge of many objects. Use an explicit collaborator instead.

**Source:** Rails practice, concerns.
