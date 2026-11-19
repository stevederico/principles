# Speed up navigation by keeping the client process alive

**Rule:** Intercept same-site navigation, fetch the next page and swap it in while scripts and styles stay loaded; hand everything out of scope (other origins, downloads, explicit opt-outs) to the browser, and fingerprint tracked assets so a changed set forces a full load.

**Why:** Full loads feel slow because styles and scripts reinitialise, not because HTML parses slowly. Gzipped HTML is only a little larger than data. Out-of-scope interception breaks downloads and other apps. Merging a new head over a running page after a deploy would run new code on top of old.

**Do:**
```
if origin differs or path outside root or file-like extension or element opted out: let browser handle
else: fetch html ; replace body ; keep runtime
asset url = name + content digest, flagged tracked
if tracked_signature(current) != tracked_signature(next): full reload
```

**Don't:** Assume you need a JSON API for app-like speed, or reuse one asset URL with different content.

**Break it when:** Server responses are slow (fix that first), or only page-specific styles change (mark them removable so deploys do not force reloads).

**Source:** https://turbo.hotwired.dev/handbook/drive ; https://stimulus.hotwired.dev/handbook/origin ; code: https://github.com/hotwired/turbo src/core/url.js, src/core/drive/page_renderer.js, src/core/drive/head_snapshot.js.
