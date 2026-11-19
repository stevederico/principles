# No build step by default

**Rule:** Ship front-end code as plain modules with a map of file names, and add a bundler or transpiler only when a named need appears.

**Why:** No runtime or build tool means less setup, fewer failure modes and faster feedback. HTTP/2 reduced the case for bundling. Third-party packages are downloaded once into the repo and pinned.

**Do:**
```
default: source files -> content-hash names -> serve; map: pin "application"
add package: download into vendor/, record the pin, commit it
opt-in: source -> bundler -> build/ folder -> the same hash-and-serve step
bundler only for: TypeScript or JSX, CSS-in-JS loaders, tree-shaking, no HTTP/2
```

**Don't:** Start with a bundler and a Node toolchain "in case", or load packages live from a CDN with no pin.

**Break it when:** One of the named needs is true on day one.

**Source:** Guides: https://guides.rubyonrails.org/asset_pipeline.html (What is the Asset Pipeline?, When Should You Use A JavaScript Import Map?, When Should You Bundle JavaScript?); https://guides.rubyonrails.org/working_with_javascript_in_rails.html (Choosing Between an Import Map and a JavaScript Bundler). Code: railties/lib/rails/generators/rails/app/app_generator.rb:319; railties/lib/rails/generators/app_base.rb:300,503-527. The pipeline gem itself is not in this source tree.
