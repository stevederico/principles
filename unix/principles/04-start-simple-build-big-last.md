# Start from the simplest design and build big only after smaller approaches fail

**Rule:** Try a small single program first, then a set of small programs on an existing framework, and write a large program only when you can show both were inadequate; add complexity only when a demonstrated need forces it.

**Why:** Complexity comes from pride and from checklist features nobody uses. Large programs are costly to maintain and invite investment in approaches that should be abandoned. A program that sits halfway, small by promise but absorbing special features, ends up neither minimal nor extensible.

**Do:**
```
if composition_of_existing_parts(job):  use it
elif small_new_program(job):            build it
elif toolkit_on_framework(job):         build that
else:
    record(why the smaller options failed)
    build_large(job)
```

**Don't:** Add features because a competitor lists them, or build intricate machinery to show skill.

**Break it when:** A measured requirement cannot be met by composing parts and the evidence for partitioning is already negative.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Simplicity and Rule of Parsimony) ; http://www.catb.org/esr/writings/taoup/html/ch13s03.html (Compromise Doesn't Work) ; http://www.catb.org/esr/writings/taoup/html/ch13s04.html (The Right Size of Software). Book only.
