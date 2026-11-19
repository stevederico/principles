# Content hash in file names, cache forever

**Rule:** Name each static asset after a hash of its contents and serve it with a far-future cache lifetime. A changed file gets a new name, so a stale copy cannot be served. A manifest maps source names to hashed names.

**Why:** The name guarantees freshness, so a one-year lifetime is safe. Templates never hard-code hashed names, and query-string versions that some proxies ignore are not needed.

**Do:**
```
build: for file in assets: out = name + "-" + hash(contents) + ext; manifest[name+ext] = out
template: link(asset_path("app.css"))          # resolved through the manifest
server: Cache-Control: public, max-age=31536000   for /assets/*
```

**Don't:** Cache stable names like app.css for a year, or set long lifetimes on non-hashed files.

**Break it when:** A file must keep a stable URL (a source map referenced by name, a public link): exempt it from far-future caching.

**Source:** Guide: https://guides.rubyonrails.org/asset_pipeline.html (What is the Asset Pipeline?, Referencing Assets, Caching Headers, The Cache-Control Header, Bypassing the Fingerprinting Step). Code: railties/lib/rails/generators/rails/app/templates/config/environments/production.rb.tt:25 (one-year header). The hashing step lives in a separate gem not in this tree, so it is docs only.
