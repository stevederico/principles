# Report progress as unknown versus known, and do the riskiest work first

**Rule:** Track each scope as uphill (still working out the approach) or downhill (all steps known, executing), not as percent, task counts or hour estimates; start with what is most uncertain and leave routine work for last.

**Why:** A list with no open tasks may mean done or may mean undiscovered tasks. One estimate hides whether the work is familiar. People hide uncertainty from managers; a marker that stops moving is a raised hand without anyone confessing. "Solved" means validated by building until no unknowns remain, not thought through. Routine work compresses into a day at the end; novel problems can take weeks.

**Do:**
```
status(scope) in { unknown, approach_chosen, validated_by_building, nothing_unknown, executing, done }
ask each scope: "if time ran out, could we whip this together?"  no -> do it first
manager reads history; a scope stuck uphill -> ask which unknown remains
```

**Don't:** Estimate unfamiliar work as one number, declare a risky part done from a mental plan, or interrupt the team with "are you stuck?".

**Break it when:** Work is repetitive and well understood; counts are fine. An easy item that unblocks a risky one goes first.

**Source:** https://basecamp.com/shapeup/3.4-chapter-13. Docs only.
