# Package a contribution as a minimal, current, explained delta

**Rule:** Send a small change against the current baseline, with enough context lines to apply after nearby edits and no regenerated-file noise, together with the documentation update, a short note on why it is needed and what risk it carries, and comments that explain intent; treat rejection as information.

**Why:** Maintainers can rarely judge code deeply, so they judge the packaging. A delta against stale code forces them to separate duplicated work from new, and generated hunks bury the real change. Documentation shows the author understands the effects, honest risk notes build trust, and authorship stamps in comments are noise. Maintainers are conservative because they must not break the project.

**Do:**
```
sync(current_baseline); drop(hunks_for_regenerated_files)
submission = delta + doc_updates + note[why; what I did not fix; known risk]
comment explains the reason for the guard, not who wrote it
if rejected: ask what blocked it; revise if addressable
```

**Don't:** Send whole files, stale-base diffs, bulky generated hunks, or argue and quit after a rejection.

**Break it when:** The changed file is new to the codebase, or the rejection reveals a real defect in your approach.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Good Patching Practice) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Do include documentation with your patch) ; http://www.catb.org/esr/writings/taoup/html/ch19s02.html (Don't take it personally if your patch is rejected). Book only.
