# Put hard-to-retrofit properties in the foundation first

**Rule:** Settle isolation between components, privilege separation, the concurrency model and the security boundary before polishing the interface layered on top.

**Why:** Adding server-grade properties to a design built for a single trusted user is very difficult, breaks compatibility and produces fragile results, whereas adding a friendly interface to a solid base mostly takes effort and cleverness. A system that touches a network needs privilege domains from the start, even with one user.

**Do:**
```
design order: boundaries and privilege -> concurrency model -> data model -> interface
untrusted-input handlers run with the least authority they need
```

**Don't:** Defer security or isolation to a later release.

**Break it when:** A throwaway demonstration with no future and no network exposure.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch03s03.html (What Goes Around, Comes Around) ; http://www.catb.org/esr/writings/taoup/html/ch03s01.html (Internal Boundaries). Book only.
