# Exalt beautiful code

**Rule:** Treat readable, elegant code as a goal. If the code is ugly, keep changing the design until it reads well.

**Why:** Ugly code is a signal that the abstraction is wrong. Beautiful code is easier to read, change, and teach.

**Do:**
```
# the API you want to write comes first, then you build it
validates name: present, length: 3..50
# not
validator_registry.add(name_validator_factory.create(min=3, max=50))
```

**Don't:** Accept an API because it works. Try writing the call site the way you wish it read.

**Break it when:** Never as a goal. But do not trade clarity for cleverness.

**Source:** Rails Doctrine, "Exalt beautiful code".
