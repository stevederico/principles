# Split into cooperating processes, then design the protocol between them

**Rule:** Cut a big program into small cooperating processes when that lowers global complexity, and accept that their interface now needs deliberate protocol design, including each side's states; give a shared resource a single owning server.

**Why:** Monoliths founder on their own complexity, and cheap process creation and communication make splitting practical. Bugs collect at the interfaces, and the hard part is protocol logic that must be expressive, free of deadlock and simple enough to verify by reasoning. One server owning a shared resource removes contention from clients and lets many specialized clients coexist.

**Do:**
```
for each process pair: define(messages, states_per_side); check(no_wait_cycle)
protocol spec = separate document from both implementations
server owns resource; clients speak the protocol, never touch server internals
```

**Don't:** Bolt on an ad hoc message exchange and assume it is correct.

**Break it when:** Spawn or messaging cost dominates the work, or the split yields a protocol more complex than the code it divides.

**Source:** http://www.catb.org/esr/writings/taoup/html/multiprogramchapter.html (Chapter 7 introduction) ; http://www.catb.org/esr/writings/taoup/html/ch03s01.html (Cooperating Processes) ; http://www.catb.org/esr/writings/taoup/html/ch11s06.html (Client/Server Pair) ; http://www.catb.org/esr/writings/taoup/html/ch07s04.html (Process Partitioning at the Design Level). Book only.
