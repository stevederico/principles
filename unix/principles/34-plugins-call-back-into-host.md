# Build extensible hosts as service libraries that plugins call back into

**Rule:** To support extensions, expose the host's abilities as a documented library with known entry points, let plugins call back through it, and choose consciously between in-process extensions and separate helper processes.

**Why:** Plugins need a stable surface instead of access to internals. Embedded extensions are powerful and share context but can break each other, and the host carries a language runtime. Out-of-process helpers may use any language and cannot corrupt the host, but must speak its messaging interface, cannot share rich state, and may add start-up lag. Letting any event bind to any function keeps extensions from competing for a fixed set of triggers.

**Do:**
```
host.expose(api); plugin.entry_points = known_names; host.load(plugin)
registry.bind(event, handler)                    # many handlers, any event
trusted and tightly coupled -> embed;  untrusted or polyglot -> separate process
```

**Don't:** Let plugins poke at host internals, or reserve a small closed list of hooks for whoever registers first.

**Break it when:** The extension surface is tiny and a configuration file does the job.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch04s04.html (Libraries (plugin pattern)) ; http://www.catb.org/esr/writings/taoup/html/ch13s03.html (Identifying the Complexity Problems). Book only.
