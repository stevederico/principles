# Get robustness from simplicity and few special cases

**Rule:** Make a program robust by keeping its internals easy to reason about, handling degenerate inputs such as empty, zero and one through the same general path, and minimizing special-case branches.

**Why:** Programs break when they are too complex to hold in one's head. Machine-generated input contains shapes people never write by hand, and special cases are where defects collect, including defects from their interactions with each other.

**Do:**
```
handle(collection):
    for item in collection: process(item)     # empty list needs no extra branch
```

**Don't:** Reject an empty input because "no person would send that".

**Break it when:** An empty value is semantically invalid for the domain and silently accepting it would hide a real error; reject it with a clear message.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch01s06.html (Rule of Robustness). Book only.
