# Fetch third-party assets at build and serve them yourself

**Rule:** Download external fonts during the build, emit them as content-hashed static files served from your own origin, apply them where used, and generate a size-adjusted fallback face so swapping causes no layout shift.

**Why:** Removes runtime third-party requests (privacy and latency), allows long caching under hashed names, and the fallback metrics reduce shift while the web font loads. Preload scope follows where the font is declared, so declare each family once and import it.

**Do:**
```
build: font = load_font(family, subsets) -> emit static/media/<hash>.woff2
fonts file: declare once, export; apply at the element that needs it
```

**Don't:** Link a third-party stylesheet at runtime, instantiate one font in many files, or ship a full weight set when a variable font covers it.

**Break it when:** A provider licence forbids self-hosting, or exact brand rendering forbids a fallback.

**Source:** https://nextjs.org/docs/app/getting-started/fonts, https://nextjs.org/docs/app/api-reference/components/font; code: packages/next/src/build/webpack/loaders/next-font-loader/index.ts, packages/next/src/build/webpack/loaders/next-font-loader/postcss-next-font.ts
