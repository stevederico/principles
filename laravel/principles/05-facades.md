# Facades

**Rule:** Offer short, global-looking access to container services, backed by the real service and swappable in tests.

**Why:** Plain dependency injection can be wordy for simple calls. A facade keeps call sites short while the container still decides what runs.

**Do:**
```
Cache.get("key")      # looks static
# really: container.make(Cache).get("key")
Cache.fake()          # tests swap it
```

**Don't:** Hide real global state. A facade must resolve to a swappable service, not a fixed singleton.

**Break it when:** A class has many dependencies. Make them explicit in the constructor so the design is visible.

**Source:** Laravel docs, facades.
