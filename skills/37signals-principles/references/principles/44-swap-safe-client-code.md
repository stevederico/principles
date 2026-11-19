# Write client code that survives page swaps

**Rule:** Attach behavior by watching the document (or by delegating from the root), not in a one-time "page loaded" hook; release everything a component started when it detaches; make every edit of server HTML idempotent; mark elements whose local state must survive with a stable id.

**Why:** Navigation, fragment loads and stream updates add and remove elements without a fresh load, and the process persists. Pages are cached as clones and restored with events firing again, so non-idempotent steps stack duplicates. Elements detach when navigated away, and an unreleased timer keeps fetching. Replacing the body drops listeners and local edits.

**Do:**
```
connect():    handle = start_timer(refresh)       # called whenever the element enters the document
disconnect(): stop_timer(handle)                   # alternates strictly with connect
insert_header(group): if header already present: return ; insert
element with id + "permanent" flag: carried over to the new page
flash messages: marked temporary so they are removed before caching
```

**Don't:** Add listeners to single elements in a navigation hook with no cleanup, or append decorations unconditionally.

**Break it when:** A one-off page script is simpler and the page is excluded from caching, or the resource intentionally lives for the whole page.

**Source:** https://turbo.hotwired.dev/handbook/building ; https://stimulus.hotwired.dev/reference/lifecycle-callbacks ; https://stimulus.hotwired.dev/handbook/working-with-external-resources ; code: https://github.com/hotwired/stimulus src/core/context.ts, https://github.com/hotwired/turbo src/core/bardo.js.
