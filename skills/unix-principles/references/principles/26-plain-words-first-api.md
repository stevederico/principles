# Describe the interface in plain words before writing it

**Rule:** Write what the module does and promises in prose, with no code, before implementing it; if the description is confusing or needs apologies, redesign the interface.

**Why:** The description clarifies what the code must do, doubles as the module's header comment, and exposes overcomplicated interfaces early. If you cannot explain it to a colleague over the phone, callers will not follow it either.

**Do:**
```
contract = write_prose(inputs, outputs, errors, guarantees)
if contract.is_hard_to_state: redesign(interface)
then: implement(interface)
```

**Don't:** Let the interface emerge from whatever the implementation happened to need.

**Break it when:** Exploratory spike code that will be discarded.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch04s01.html (Encapsulation and Optimal Module Size) ; http://www.catb.org/esr/writings/taoup/html/ch04s06.html (Coding for Modularity). Book only.
