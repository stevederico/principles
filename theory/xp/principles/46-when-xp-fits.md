# When XP fits

**Rule:** Use XP when requirements change or the project is risky, the team is small, the whole team including customers can work together, and automated tests are possible.

**Why:** XP was made for changing requirements and for delivery-date or novelty risk. It suits 2 to 12 programmers (30 reported), not a huge staff, and ordinary programmers are fine. It needs an extended team working elbow to elbow and testability, which may mean changing the design. Higher productivity is reported but is not the goal; the goal is the software needed, when needed.

**Do:**
```
check: requirements shifting? risk high?
check: team 2 to 12 (30 reported)? customers and managers join?
check: can you automate unit and functional tests?
```

**Don't:** Applying it to a huge staff.

**Break it when:** Domains that cannot be tested automatically may disqualify it, though the site says to apply testing ingenuity first.

**Source:** http://www.extremeprogramming.org/when.html
