# Let standards grow from running code and independent implementations

**Rule:** Write a specification by ratifying features already proven in working implementations, require interoperable implementations by independent parties before it counts as mature, publish an open reference implementation, and label each document's status.

**Why:** Features invented in committee were the most disliked and least successful, specifications from theory or politics produce documents nobody implements, and an open implementation beat a technically better proprietary protocol. A staged ladder lets field use act as the gate, and labelled drafts cannot be claimed as compliant specs.

**Do:**
```
prototype -> public_draft -> numbered_spec -> two_independent_interoperable_implementations -> mature
publish(spec + open_reference_code + conformance_tests)
```

**Don't:** Ratify a specification before anyone implemented it, or let vendors claim compliance with unfinished drafts.

**Break it when:** A closed system with a single implementer needs no interoperation; or a new coordination protocol cannot be implemented before the standard exists, so run reference code beside the draft.

**Source:** http://www.catb.org/esr/writings/taoup/html/c_evolution.html (C Standards) ; http://www.catb.org/esr/writings/taoup/html/ietf_process.html (IETF and the RFC Standards Process) ; http://www.catb.org/esr/writings/taoup/html/ch17s02.html (Unix Standards) ; http://www.catb.org/esr/writings/taoup/html/ch17s07.html (Portability, Open Standards, and Open Source). Book only.
