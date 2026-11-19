# Split pages into fragments by change rate and audience

**Rule:** Carve parts that expire on different schedules or serve different audiences into addressable fragments with their own URL and cache key, optionally loaded lazily; let one URL work both embedded and as a full page, and treat a reply lacking the expected fragment as an error.

**Why:** A composite page expires when any piece does and mixes shared with personal content. Separate fragments cache longer, render in parallel and map to native screens. The same code can edit in place or on its own page. Silent mismatches are hard to debug, so the client reports them, with an explicit full-page takeover for legitimate cases like an expired session.

**Do:**
```
page = shell + fragment(inbox, url_a, lazy) + fragment(sidebar, url_b)
client sends the wanted fragment id ; extract the same id from the response
absent: raise and show a message ; login page declares "always full reload"
```

**Don't:** Create dozens of fragments that pop in after first paint, embed per-user data in a page you want cached whole, or swallow a missing fragment.

**Break it when:** Segments are tiny, always change together, or are critical to first paint.

**Source:** https://turbo.hotwired.dev/handbook/frames ; https://turbo.hotwired.dev/handbook/introduction ; https://stimulus.hotwired.dev/handbook/working-with-external-resources ; code: https://github.com/hotwired/turbo src/core/frames/frame_controller.js.
