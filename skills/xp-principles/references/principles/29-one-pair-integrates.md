# One pair integrates at a time

**Rule:** Let only one pair integrate, test and commit at a time, taking turns on one shared token such as a dedicated integration computer.

**Why:** Parallel integration leaves combinations of code never tested together and no clear latest version. Class owners become bottlenecks; an integrator or integration team is too slow, as on C3 where a hierarchy cut integration to once every three weeks. Taking turns keeps development parallel but gives one latest version and limits debugging to one pair. The site prefers a shared machine over automated build software, since sharing builds community and shows who is releasing; a software tool can enable a process but cannot replace it.

**Do:**
```
wait for the integration computer (or token) to be free
load latest code + your changes; run the full suite
100% -> commit and release; else back out and debug at your workstation
free the token fast
```

**Don't:** Substituting automated build software for the shared station, or letting an integrator or team gatekeep releases.

**Break it when:** The dedicated computer works best for co-located teams; a physical token passed between developers works too.

**Source:** http://www.extremeprogramming.org/rules/sequential.html, http://www.extremeprogramming.org/rules/dedicated.html, http://www.extremeprogramming.org/kent.html, http://www.extremeprogramming.org/don.html, http://www.extremeprogramming.org/lessons.html
