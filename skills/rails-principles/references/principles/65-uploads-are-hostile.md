# Uploaded files are hostile

**Rule:** A hard-to-guess or expiring URL is a convenience, not access control. Serve uploads as downloads unless the type is on a short inline allow-list, hand out one stable app URL that redirects to a short-lived storage URL, and never give user input to a file processor.

**Why:** The built-in file routes are public and skip your filters; an expiring link works for anyone holding it until it expires. Uploaded markup served inline runs in your origin, many-range requests are a denial-of-service lever, and user-supplied transform options are command injection.

**Do:**
```
disable built-in public file routes; GET /account/logo -> require login, check owner,
  redirect to a storage URL expiring in 5 minutes
serve(blob): if blob.type in inline_allowed: inline else attachment
range request: reject more than one range
variant(name from a fixed list)                      # not user-supplied options
at boot: block risky image loaders; if the tool cannot be secured -> abort start
```

**Don't:** Trust the declared content type, embed raw storage URLs in stored content, treat "nobody can guess the signed id" as permission, or log a warning and carry on when safety is unavailable.

**Break it when:** Content is public and yours (mark the storage public on purpose). A CDN must cache the bytes: use proxy mode so the app serves them with cache headers.

**Source:** Guides: https://guides.rubyonrails.org/active_storage_overview.html (Authenticated Controllers, Expiring URLs, Redirect Mode, Proxy Mode, Image Variants, ImageMagick Security Policy, Disabled Vips Image Loaders and Savers); https://guides.rubyonrails.org/configuring.html (content_types_allowed_inline, service_urls_expire_in, streaming_max_ranges). Code: activestorage/lib/active_storage.rb:358,366; activestorage/app/models/active_storage/blob/servable.rb:16; activestorage/lib/active_storage/engine.rb:54; activestorage/config/routes.rb:84.
