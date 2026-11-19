# Separate the engine from its interfaces

**Rule:** Put the domain logic in a documented engine or library with a narrow channel to it, and make every user interface, whether command line, graphical, web or scripted, a thin layer over that channel.

**Why:** The split lowers global complexity, lets each half specialize, allows several interfaces and authors for one engine, lets scripts drive the engine directly and shrinks the trusted code. A library that also ships a small exerciser program for each entry point is easier to learn and test, and a command-line tool that exposes a callable API is easier to embed.

**Do:**
```
engine.core.do_thing(params) -> result          # all domain rules
cli.main:  parse -> engine.core.do_thing -> print
gui.click: gather -> engine.core.do_thing -> render
engine.reports_progress(events)                  # so any driver can give feedback
```

**Don't:** Let business rules live in GUI event handlers or request handlers where only that one front end can reach them.

**Break it when:** The tool is tiny and will never have a second consumer, or feedback is so tight that the channel would carry nearly all internal state.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch11s06.html (Separated Engine and Interface pattern) ; http://www.catb.org/esr/writings/taoup/html/ch11s07.html (The Polyvalent-Program Pattern) ; http://www.catb.org/esr/writings/taoup/html/ch04s04.html (Libraries) ; http://www.catb.org/esr/writings/taoup/html/ch11s08.html (The Web Browser as a Universal Front End) ; http://www.catb.org/esr/writings/taoup/html/ch20s01.html (Essence and Accident in Unix Tradition). Book only.
