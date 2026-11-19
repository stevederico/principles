# Do not buy simplicity by pushing chores onto users or by multiplying special cases

**Rule:** Avoid two opposite traps: keeping the code small by leaving users to do tedious low-level steps by hand, and keeping each piece small by inventing a separate hack for every variant of what is really one class of problem.

**Why:** An interface shaped mainly to save implementers effort makes people perform error-prone mechanical work, and small sharp tools do the same when the user carries all shared context. Conversely, several special-purpose pieces that later need reintegration are worse than one general mechanism, even a somewhat complex one.

**Do:**
```
if users repeat a mechanical low-level step often:
    provide the higher-level operation
if three or more ad hoc pieces solve variants of one problem:
    replace them with one general mechanism
```

**Don't:** Cite code size to justify missing high-level operations, or add a special-purpose hack per case because each looks small.

**Break it when:** The missing operation is rare and a composable tool already covers it; or the class has one member and will not grow.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch13s01.html (The Three Sources of Complexity) ; http://www.catb.org/esr/writings/taoup/html/ch13s03.html (Compromise Doesn't Work). Book only.
