# Triage bugs by reach and severity, not by arrival

**Rule:** Interrupt for crises (data loss, outage, wide wrong display) and send everything else to a cool-down, a shaped pitch, or a periodic bug cycle; rank by people affected times severity, and keep top lists short.

**Why:** All software has bugs and some need no fixing; treating each as urgent means never shipping anything new. Arguing for a fix at the planning table makes delay a deliberate choice. Blame cultures cause defects to be hidden, and honest status builds trust.

**Do:**
```
if data_loss or app_down or wide_wrong_display: drop everything, use the incident path
else: small -> fix in cool-down ; big -> shape and pitch ; yearly -> one bug-smash cycle
score = users_affected * severity ; keep a capped top-N list
tell the reporter the real status and the reason
```

**Don't:** Fix in arrival order, let any report pre-empt committed work, or punish reporters.

**Break it when:** Security or regulatory bugs are fixed regardless of reach.

**Source:** https://basecamp.com/shapeup/2.2-chapter-08 (What about bugs) ; https://basecamp.com/gettingreal/15.4-all-bugs-are-not-created-equal ; https://github.com/basecamp/handbook/blob/main/titles-for-QA.md. Docs only.
