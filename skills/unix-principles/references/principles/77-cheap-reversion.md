# Use version control from the start and make reverting nearly free

**Rule:** Keep all work under version control, make its steps cost nothing in the editor or tooling, commit small, and compare against the last known good state before committing.

**Why:** If reverting is unreliable people avoid risky changes. Hand-made snapshots and emailed copies fail under pressure and lose order, author and reason. Asking what changed since the last good version also catches forgotten debug code, and history lets you reproduce a bug against an older version. Extra steps per edit get skipped.

**Do:**
```
commit small and often
before commit: review(diff(last_good, working_copy))
commit = atomic set of file changes including renames
```

**Don't:** Rely on copied backup folders and comments in files, or version file contents while leaving renames and the namespace unrecorded.

**Break it when:** Throwaway scripts with no history value.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch15s05.html (Why Version Control?) ; http://www.catb.org/esr/writings/taoup/html/ch15s05.html (Version Control by Hand) ; http://www.catb.org/esr/writings/taoup/html/ch15s08.html (Emacs and Version Control). Book only.
