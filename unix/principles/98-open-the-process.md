# Open the process and lower the insider barrier

**Rule:** Publish both the source and the way it gets built and decided, welcome outside review and redistribution, keep the core team's privileges inconspicuous, and use the same contribution path for insiders and outsiders.

**Why:** Bug characterization and fixing, and exploring variants near a prototype, divide well across many people; casual contributors drop in and out and are discouraged by social walls. Secrecy habits cap what loosely networked teams can achieve. Depending on closed components deters reviewers.

**Do:**
```
public repository; public tracker; same review path for everyone
change = diff(base, edited); share via tracker or repository, host source in network-accessible version control
```

**Don't:** Gate review behind private channels or reserve decisions for an invisible inner circle.

**Break it when:** Security fixes need an embargo window, or content cannot legally be shared.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch19s01.html (Unix and Open Source) ; http://www.catb.org/esr/writings/taoup/html/opensourcechapter.html (Chapter 19 introduction). Book only.
