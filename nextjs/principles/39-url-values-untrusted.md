# Treat URL values as untrusted and narrow them once

**Rule:** Treat path and query values as untrusted strings (possibly arrays or absent), validate and convert them to a narrower type once at the entry, send unknown values to not-found, check a parameter against a known list before using it to load content, and percent-encode data placed into a path.

**Why:** Anyone can type any URL, and repeated query keys yield arrays. A parameter used to build an import or file path lets an attacker choose what is loaded. Build-time validation covers only the branches the sample parameters exercised.

**Do:**
```
slug = params.slug
if slug not in known_slugs: not_found()
content = load("content/" + slug)
link = "/tag/" + percent_encode(tag)
```

**Don't:** Cast the raw value to a union type, build a module path from request input, or concatenate raw titles into URLs.

**Break it when:** The value only selects presentation (a sort order) and is echoed after proper escaping.

**Source:** https://nextjs.org/docs/app/api-reference/file-conventions/dynamic-routes, https://nextjs.org/docs/app/api-reference/file-conventions/page, https://nextjs.org/docs/app/guides/mdx, https://nextjs.org/docs/pages/building-your-application/routing/linking-and-navigating; docs only
