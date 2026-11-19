# Write for portability, even for throwaway code

**Rule:** Assume hardware and platforms are short-lived, build on documented standard interfaces and the features most likely to persist, and avoid assumptions about word size, byte order or vendor extras.

**Why:** Software routinely outlives its predicted lifetime and original platform, and portability discipline also simplifies architecture and cuts maintenance cost. Portability runs forward in time as well as sideways across systems.

**Do:**
```
code to the standard interface; keep machine assumptions out of the logic
avoid technologies likely to be withdrawn; if one is required, keep an exit plan
```

**Don't:** Assume a prototype will be short-lived and bind it to perishable technology.

**Break it when:** Kernel or driver code that must touch machine specifics.

**Source:** http://www.catb.org/esr/writings/taoup/html/portabilitychapter.html (Chapter 17 introduction) ; http://www.catb.org/esr/writings/taoup/html/ch17s05.html (Programming for Portability) ; http://www.catb.org/esr/writings/taoup/html/ch17s07.html (Portability, Open Standards, and Open Source). Book only.
