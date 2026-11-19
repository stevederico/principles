# Provide the standard targets, including a faithful uninstall and a one-command test

**Rule:** Offer conventional entry points: build everything by default, run the tests, clean, package, install and uninstall, with uninstall exactly reversing install and the whole test suite runnable by one command.

**Why:** Conventional names make a project's structure a roadmap. A package target that depends on the full build avoids shipping without derived files, and uninstall avoids large leftovers. A one-command suite lets the team regress before every release and lets users validate their own ports.

**Do:**
```
all (default) ; test ; clean ; dist (depends on all) ; install ; uninstall (exact inverse of install)
new test = drop a file in the test directory
```

**Don't:** Ship install without uninstall, or tests only reachable through an arcane framework.

**Break it when:** The project is not installed system-wide, or tests need proprietary hardware or data; document how to run them.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch15s04.html (Utility Productions) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Test your code before release). Book only.
