# Match cache lifetime to the strictest audience, and version long-cached URLs

**Rule:** Use public shared caching only for content that is public, and browser-private caching otherwise; give long-lived assets a version in the URL so they cache hard yet change with the content; keep redirects path-only.

**Why:** A shared cache would keep serving a book's images after it was unpublished, and a redirect with a host taken from the request can be poisoned in a shared cache.

**Do:**
```
avatar = /users/<signed_id>/avatar?v=<updated_at> ; etag + max-age 30 min + stale-while-revalidate
published upload: public 1 year ; unpublished: private 5 minutes
redirect Location = path only
```

**Don't:** Send `public, max-age=1 year` on authorized content.

**Break it when:** The content is immutable and public.

**Source:** https://github.com/basecamp/writebook config/initializers/active_storage.rb, app/controllers/action_text/markdown/uploads_controller.rb ; https://github.com/basecamp/once-campfire app/controllers/users/avatars_controller.rb, config/routes.rb.
