# Search, read and compose before you write

**Rule:** Look for an existing design or implementation first, read it even if you will not use it, and reuse by composition through its interface rather than by copying; do as little new work as the data and existing tools allow.

**Why:** Few problems are new, and thinking time is the scarcest resource. Reinvented wheels are often crude, because the quick version looks cheap and is false economy. A short composition of existing tools can replace thousands of lines and hours of debugging, and copying code into your program forks its defects.

**Do:**
```
candidates = search(local_tools, libraries)
read(candidates); compose(by_interface)
write_new_code(only_for the genuine gap)
```

**Don't:** Copy-paste a snippet, or build bespoke code for a problem an existing filter solves.

**Break it when:** No candidate fits, or its quality, dependencies or terms cost more than the saving.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch16s05.html (Where to Look?) ; http://www.catb.org/esr/writings/taoup/html/reusechapter.html (Chapter 16 introduction) ; http://www.catb.org/esr/writings/taoup/html/ten-thousand.html (koan on the thousand-line pipeline) ; http://www.catb.org/esr/writings/taoup/html/ch09s02.html (Ad-hoc Code Generation (closing lesson)). Book only.
