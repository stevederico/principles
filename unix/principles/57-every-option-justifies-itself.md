# Make every option justify itself against its test cost

**Rule:** Before adding a switch, ask whether you can omit it, change the default harmlessly, whether it is purely cosmetic, and whether a separate program or wrapper could provide it; expose no tuning knobs when the program can run economically itself.

**Why:** Every on-off option doubles the configurations in theory and splits testing in practice, so ten options mean over a thousand combinations each tested less. Marginal user-tuned gains rarely repay interface clutter, and clutter is complexity made hidden.

**Do:**
```
for each proposed option:
    can_omit? default_change_ok? cosmetic? separate_tool?
    if any yes: do not add it
count(independent_options); keep combinations you will actually test
```

**Don't:** Add a flag per preference or per tuning idea.

**Break it when:** Real users with different hardware need a resource bound you cannot infer; or options are orthogonal and covered by separate modules with separate tests.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch10s01.html (What Should Be Configurable?). Book only.
