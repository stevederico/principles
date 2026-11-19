# Track complexity on three axes and name its kind before arguing about it

**Rule:** Judge every change by its effect on implementation complexity, interface complexity and total code size, and label each source of complexity as accidental, optional or essential so you apply the right remedy.

**Why:** Defect density per line is roughly constant across languages, so every extra line adds expected bugs, and finding them is the costliest stage of development. Builders see implementation complexity while users feel interface complexity. Accidental complexity falls to better design, optional complexity only to a change of goals, essential complexity only to a redefinition of the problem; mixing the kinds turns scope questions into quarrels about elegance.

**Do:**
```
for each change:
    note delta in {implementation, interface, code_size}
for each source_of_complexity:
    accidental -> redesign
    optional   -> scope decision: does the goal justify it?
    essential  -> keep, or rethink the problem
```

**Don't:** Quote one measure ("it is simple inside") and ignore the user's burden, or treat every optional feature as accidental bloat.

**Break it when:** A larger codebase buys a real drop in the other two axes and the trade is explicit.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch13s01.html (The Three Sources of Complexity) ; http://www.catb.org/esr/writings/taoup/html/ch13s01.html (Essential, Optional, and Accidental Complexity). Book only.
