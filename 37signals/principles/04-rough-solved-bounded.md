# Specify work that is rough, solved and bounded

**Rule:** Hand over a definition that is rough (no pixel or field detail), solved (the main parts connect and known holes are closed) and bounded (it states the budget and what is out). Explore in words about places, actions and connections before any layout.

**Why:** Wireframes are too concrete: they hide implementation complexity and tie the builder's hands. One-line titles are too abstract: they give no edge. Describing what connects to what is the same for a dialog or a full page, and exposes functional questions without arguments about looks.

**Do:**
```
spec = { problem, budget,
         places: [ "Invoice" -> action "Turn on autopay" -> "Setup", "Setup" -> "Confirm" ],
         patches: [...], not_doing: [...] }
walk the use case step by step; list open questions at each place
# where an idea is inherently visual: use a deliberately coarse sketch
```

**Don't:** Share a high-fidelity mockup as "just direction", or draw wireframes during exploration.

**Break it when:** One visual detail is the linchpin everyone must see to grasp the idea. Add only that detail and mark the rest as latitude.

**Source:** https://basecamp.com/shapeup/1.1-chapter-02 ; https://basecamp.com/shapeup/1.3-chapter-04 ; https://basecamp.com/shapeup/1.5-chapter-06. Docs only.
