# Design with CRC cards

**Rule:** Design as a whole team using class, responsibility and collaborator cards, and walk through the system by simulating which object sends which message.

**Why:** The cards break the habit of procedural thinking and let the whole team contribute, so more good ideas get in. Stepping through exposes weaknesses fast, and alternatives are cheap: sweep the desk clean and start over, as the coffee-maker team did, without wasting effort on diagrams. In a rowdy session, limit card movers to two.

**Do:**
```
one card per class: name on top, responsibilities down the left,
                     collaborators beside each responsibility
simulate a scenario aloud; move cards as objects send messages
if the design feels wrong: clear the table, start again
```

**Don't:** Drawing a full diagram for each design alternative.

**Break it when:** If a lasting record is required, write one card per class out in full and keep them as documentation.

**Source:** http://www.extremeprogramming.org/rules/crccards.html, http://www.extremeprogramming.org/example/crcsim.html
