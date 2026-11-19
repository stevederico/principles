# Sync clients with one refresh signal, echo suppression and debounce

**Rule:** Broadcast a single "refresh" signal and let each client re-fetch its own view; ignore signals caused by the client's own requests and collapse bursts.

**Why:** One signal avoids computing per-client diffs, ignoring self-caused signals avoids double renders, and debouncing avoids re-fetch storms.

**Do:**
```
every request carries a request id ; client remembers the last 20 ids
on refresh(id): ignore if id recent, or a visit or submit is in flight, or url differs
else: schedule re-fetch, debounced ~150 ms, keep scroll
```

**Don't:** Push full model diffs to every client, or refresh the page that started the change.

**Break it when:** Fragments are huge and identical for all clients; pushing the fragment may be cheaper.

**Source:** https://turbo.hotwired.dev/handbook/page_refreshes ; https://turbo.hotwired.dev/reference/streams ; code: https://github.com/hotwired/turbo src/core/session.js, src/http/fetch.js, src/core/drive/limited_set.js.
