# Classify content by what it varies on

**Rule:** For every piece of content ask what its output depends on (nothing, a shared lookup, the session, the URL, the live request) and deliver it accordingly: build it into the shell, cache it, or stream it behind a fallback.

**Why:** Content that varies by nothing can be built once and served from a CDN; content that varies by request must wait for the request, and forcing it into the shell either freezes one visitor's view for everyone or blocks the whole page. Matching delivery to variance keeps most of the page instant and pays server cost only for the hole.

**Do:**
```
page:
  header()                                  # varies by nothing: in the shell
  cached(posts, lifetime = hours)           # shared lookup: in the shell
  cached(lookup, key = session_value)       # per session: key by the value, read it outside
  boundary(fallback = skeleton):
    user_prefs()                            # per request: streamed
```

**Don't:** Read request data at the top of the page so the whole route becomes per-request, or leave a request-time read with no fallback boundary.

**Break it when:** The whole page is personalized and shows nothing useful without the request; render it per request and accept the cost.

**Source:** https://nextjs.org/docs/app/getting-started/caching, https://nextjs.org/docs/app/guides/public-static-pages, https://nextjs.org/docs/app/guides/adopting-partial-prefetching; docs only
