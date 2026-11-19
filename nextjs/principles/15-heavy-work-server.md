# Keep heavy transformation on the server, load the rest on demand

**Rule:** Run libraries that only turn data into markup (syntax highlighting, markdown, chart rendering) on the server and ship the result; defer large client-only code to a dynamic load triggered by the action that needs it, with a literal, narrow path.

**Why:** Otherwise the browser downloads and runs a whole library to produce static HTML. A literal path lets the bundler preload the chunk, and a narrow directory prefix both limits what is included and keeps external input from reaching other files.

**Do:**
```
server: html = highlight(code)               # browser gets markup only
client: on_click(): chart = load("charts/" + name)   # fixed prefix, narrow folder
```

**Don't:** Build the import path from a variable at the root, call the lazy wrapper inside render, or place a transformation-only library in an interactive unit.

**Break it when:** The component is above the fold on every page, or content is edited live in the browser.

**Source:** https://nextjs.org/docs/app/guides/package-bundling, https://nextjs.org/docs/app/guides/lazy-loading, https://nextjs.org/docs/app/getting-started/images; code: packages/next/src/shared/lib/dynamic.tsx
