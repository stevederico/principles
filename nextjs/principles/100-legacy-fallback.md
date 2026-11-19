# Fall back to the old tool for custom setups, and fail loudly on conflicts

**Rule:** When swapping a default compiler or bundler, detect a project's custom configuration for the old tool and keep using the old tool there, or fail the build with explicit exits (use the new one anyway, migrate, opt out) when both configurations exist; remember a custom config for a feature with defaults switches the defaults off entirely.

**Why:** A transform invisible to users beats a flag day, and silently ignoring a user's config breaks custom plugins. A plugin may inject the old config without the team knowing. Defining a custom config replaces built-in defaults, so restate what you still need.

**Do:**
```
if project has legacy_tool_config:
  keep legacy_tool  (or error with three exits when the new one is forced)
custom config present -> copy forward every default you still want
```

**Don't:** Quietly drop the user's config after a swap, or add one plugin and expect the defaults to keep running.

**Break it when:** The legacy path is removed in a later major after a long warning.

**Source:** https://nextjs.org/docs/app/guides/upgrading/version-16, https://nextjs.org/docs/pages/guides/upgrading/version-12, https://nextjs.org/docs/architecture/nextjs-compiler, https://nextjs.org/docs/pages/guides/post-css; code: packages/next/src/build/webpack-config.ts
