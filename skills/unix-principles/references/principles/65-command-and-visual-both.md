# Offer a scriptable command or language interface beside the visual one

**Rule:** For a serious tool expose every capability through commands or a language and build the visual interface on the same engine, so scripts and bulk jobs have a route and novices have another.

**Why:** Command interfaces carry a high memory load but past a crossover point of frequent use, experience or scale their concision, expressiveness and scriptability win. Visual interfaces suit one-off tasks, novices and visual domains, but cannot be scripted, so direct manipulation turns into drudgery at scale. When each visual action issues a command in the engine's language, scripts and humans share one engine.

**Do:**
```
every gui_action = command(engine.language)
bulk operations accept lists as arguments or input
automation layer = the commands beneath the form handler or button
```

**Don't:** Ship a graphical-only tool whose power users will have repetitive batch jobs, or keep the only copy of a transaction inside a request handler.

**Break it when:** The domain is inherently one-off and visual with no batch use.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch11s04.html (Tradeoffs between CLI and Visual Interfaces) ; http://www.catb.org/esr/writings/taoup/html/ch11s06.html (Language-Based Interface Patterns) ; http://www.catb.org/esr/writings/taoup/html/ch11s08.html (The Web Browser as a Universal Front End). Book only.
