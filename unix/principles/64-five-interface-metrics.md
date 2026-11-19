# Judge each interface on five metrics, and make it feel intuitive

**Rule:** Evaluate interface styles for your users on concision, expressiveness, ease, transparency and scriptability, and make the interface feel intuitive by giving it a discovery path, visible state and feedback, and familiar conventions.

**Why:** Concision bounds the effort per transaction, expressiveness is the range of actions including unplanned combinations, ease is inverse to what must be memorized, transparency is how little state users must keep in mind, and scriptability is how readily programs can drive it. Humans and programs, novices and experts weigh these differently, and a visual metaphor can backfire by oversimplifying the domain. Early surprises are tolerable when discoverability and transparency make longer use rewarding.

**Do:**
```
for user_type in [novice, expert, program]:
    score(candidate_interface, [concision, expressiveness, ease, transparency, scriptability])
simple operations on the surface; advanced ones reachable by exploring; state visible
```

**Don't:** Optimize ease alone, or equate "intuitive" with "few features".

**Break it when:** One known user type with one dominant need.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch11s03.html (Evaluating Interface Designs) ; http://www.catb.org/esr/writings/taoup/html/ch11s05.html (Transparency, Expressiveness, and Configurability) ; http://www.catb.org/esr/writings/taoup/html/interfacechapter.html (Chapter 11 introduction). Book only.
