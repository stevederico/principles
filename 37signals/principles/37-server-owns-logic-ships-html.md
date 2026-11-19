# Keep logic on the server and ship finished HTML

**Rule:** Do permissions, domain rules and rendering on the server and send ready-made pages or fragments, with a thin client that only inserts them; use a heavy client approach only for screens that need peak fidelity, such as calendars and rich editors.

**Why:** Mirroring logic on both sides of a JSON boundary doubles the work. Compressed HTML is only slightly larger than data and saves all client fetch-and-render code. One set of views serves web and native shells, and changes ship without store review. Isolating the rich widget keeps the rest simple.

**Do:**
```
on request: check permission, load model, render template -> html
client: insert html where told ; no business rules
default = server html + small enhancements ; exceptions = isolated rich widgets
native shell: loads server pages by default, native only where interaction demands
```

**Don't:** Return raw data and rebuild the same view, validation and permission checks in a client app, or adopt the heaviest architecture everywhere because one screen needs it.

**Break it when:** Most screens are rich and real-time, or the screen is a self-contained editor or drawing surface.

**Source:** https://turbo.hotwired.dev/handbook/introduction ; https://stimulus.hotwired.dev/handbook/origin ; https://turbo.hotwired.dev/handbook/native ; https://github.com/hotwired/stimulus README.md. Docs only (the code transports and applies HTML: turbo src/core/streams/stream_actions.js).
