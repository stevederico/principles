# Keep bedrock interfaces stable and absorb others' interfaces faithfully

**Rule:** Hold the core interfaces stable and move change into layers above, add to shared interfaces rather than diverging from them, and when absorbing a competing interface read and write it faithfully instead of extending it into a trap.

**Why:** Where the base does not move, skills and code stay valid; where nothing is predictable, half of what people know goes stale quickly. Vendors who differentiated by diverging interfaces fragmented their own market, and emulating a rival's format while letting users leave attracts them, whereas extend-until-required breaks compatibility to lock users in.

**Do:**
```
core_api.change_policy = additive_only ; breaking changes only in new layers
accept(foreign_format) -> write(foreign_format unchanged, when asked)
```

**Don't:** Churn the foundation for taste, or make proprietary additions to a shared format mandatory.

**Break it when:** The base has a flaw whose cost exceeds the break, such as a security hole; or no faithful round trip exists and you document the lossy conversion.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s02.html (The Durability of Unix) ; http://www.catb.org/esr/writings/taoup/html/ch02s01.html (TCP/IP and the Unix Wars) ; http://www.catb.org/esr/writings/taoup/html/ch03s02.html (Linux (emulate and subsume)). Book only.
