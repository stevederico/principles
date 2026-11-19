# Never lock data in

**Rule:** Make signup light, cancelling one visible action, and all of a user's content exportable in an open format at any time, with feeds and interfaces that let it flow out.

**Why:** Control over data builds trust, and trapping users is unfair. Third parties can build add-ons that become the reason to use the product, and people can follow changes without logging in.

**Do:**
```
signup: minimal fields, free way to try
cancel: one visible link, no questions
export: all user content, open format, any time
expose: per-user feed, authenticated interface, export
billing: no long contract, no setup fee
```

**Don't:** Seal data inside the app, bury cancellation, or gate a trial behind a call or form.

**Break it when:** Data is sensitive or contractually restricted (expose only to its owner), or abuse controls require extra signup checks.

**Source:** https://basecamp.com/gettingreal/12.2-easy-on-easy-off ; https://basecamp.com/gettingreal/12.3-silly-rabbit-tricks-are-for-kids ; https://basecamp.com/gettingreal/10.5-open-doors. Docs only.
