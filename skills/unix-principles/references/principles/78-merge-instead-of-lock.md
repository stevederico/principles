# Merge changes instead of locking, keep few branches, and exchange deltas

**Rule:** Let people edit concurrently and merge mechanically, asking a human only on a true conflict; limit the number of live variants, retest after each merge, and pass changes as small deltas that apply to a base that has moved on.

**Why:** Real conflicts are rarer than feared, locking makes one absent person a point of failure, and open merging makes casual contribution easy. A conflict-free merge does not prove the combination works, and many variants make even bug reports hard to match to a version. Deltas are small and survive drift of the base; whole-file copies overwrite others' concurrent work.

**Do:**
```
delta = diff(base, mine); apply(delta, their_current_base)    # works if context still matches
on commit: merge automatically; on conflict: ask human; run tests after merge
keep(few, long_lived_branches)
```

**Don't:** Hold exclusive locks on shared files across long edits, or treat a clean merge as verified.

**Break it when:** Files cannot be merged (opaque binary), the team is tiny, or divergent ports need separate lines.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch15s05.html (Concurrent Version System (CVS)) ; http://www.catb.org/esr/writings/taoup/html/ch15s05.html (Automated Version Control) ; http://www.catb.org/esr/writings/taoup/html/ch02s01.html (TCP/IP and the Unix Wars) ; http://www.catb.org/esr/writings/taoup/html/ch19s01.html (Unix and Open Source). Book only.
