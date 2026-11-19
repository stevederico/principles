# Decide deliberately whether the interface or the implementation absorbs the complexity

**Rule:** For each design choice, name who pays for the hard part, the user of the interface or the implementer, pick one, and record the reason.

**Why:** A simpler interface can often be bought with a harder implementation, and the reverse. Resuming an interrupted operation automatically is friendlier to callers but harder to build than returning an error for the caller to retry. Simple implementations spread faster, while simple, consistent behavior is easier to rely on; covering every edge case in advance can make code brittle and never ship, yet ignoring races and resource limits makes behavior irregular.

**Do:**
```
options = [simple_interface + hard_implementation, hard_interface + simple_implementation]
choose(option); record(reason)
handle the edge cases that cause dangerous or irregular behavior; document and defer the rest
```

**Don't:** Drift to one extreme by default, or chase total edge-case coverage in the first design.

**Break it when:** Neither choice is clearly better; the source offers no formula and expects fresh judgment each time.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch13s01.html (Tradeoffs between Interface and Implementation Complexity) ; http://www.catb.org/esr/writings/taoup/html/two_paths.html (Master Foo Discourses on the Two Paths). Book only.
