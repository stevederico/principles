# Sanitize by allowlist in layers sharing one list, and use hashes for CSP

**Rule:** Sanitize untrusted rich content by allowlist of tags and attributes kept in one place used by every layer, re-sanitize at output, and allow the few inline scripts by content hash rather than per-request nonce so rendered HTML stays cacheable.

**Why:** A message passes three layers that each build on one constant; the scrubber starts from a vetted attribute set, and the iframe table feeds both the scrubber and the policy. Hashes change only at deploy so cached HTML stays valid; "self" is too wide when uploads share the origin.

**Do:**
```
ALLOWED_TAGS, ALLOWED_ATTRS in one module
filters = [strip_disallowed_tags, scrub_attributes(allowlist)] ; sanitize again before auto-linking
search snippets: allow only <mark>
script_src = asset_dir_urls + sha256(importmap_json) + sha256(entry_import)
env switch DISABLE_CONTENT_SECURITY_POLICY for operators
```

**Don't:** Blocklist script tags, define the list separately for editor, render and policy, or add nonces to pages you intend to cache.

**Break it when:** Authors are fully trusted and content is never shown to others, or pages are never cached and need dynamic inline scripts.

**Source:** https://github.com/basecamp/once-campfire app/helpers/content_filters.rb, app/controllers/concerns/inline_script_hashes.rb, config/initializers/content_security_policy.rb ; https://github.com/basecamp/writebook app/models/html_scrubber.rb, app/models/embed_provider.rb.
