# Anchor a platform on a few unifying abstractions

**Rule:** Build the system around one or two central ideas, such as a uniform byte-stream handle and one adjustable namespace, so that the same interface serves local and remote peers and every service.

**Why:** Style across applications follows the unifying idea in the base; without one you get an incoherent pile that forces relearning every few years. Separate mechanisms for same-machine and cross-machine communication, or for each kind of resource, fragment the system, while one stream abstraction lets software ignore where its peer lives. Under new pressure, first stretch the basic abstractions before adding layers.

**Do:**
```
every resource -> same handle type (open, read, write, close)
connect(address) -> stream            # same code for local and remote peer
adapter: translate(service_protocol) -> handle interface
```

**Don't:** Add a new concept and namespace for every new resource, or build a second communication path for the local case.

**Break it when:** A resource has semantics the shared abstraction cannot express; expose the difference in the handle type, not the namespace. A measured local fast path can hide behind the same interface.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch03s01.html (What Is the Operating System's Unifying Idea?) ; http://www.catb.org/esr/writings/taoup/html/plan9.html (Plan 9: The Way the Future Was) ; http://www.catb.org/esr/writings/taoup/html/ch20s01.html (Essence and Accident in Unix Tradition) ; http://www.catb.org/esr/writings/taoup/html/ch20s03.html (Unix Has Too Many Different Kinds of Names). Book only.
