# Keep routes small, shallow and named

**Rule:** Nest a URL under its parent one level at most, expose only the actions a resource uses, and build every link from a route name or a record, never from string pieces.

**Why:** Deep nesting makes every helper take three objects. Unused routes cost memory and attack surface. A named helper lets a route move without touching each link, and a record lets the framework derive the path.

**Do:**
```
GET  /articles/5/comments      # collection needs the parent
GET  /comments/9               # member: its own id identifies it
resources photos, only: [index, show]
link("Ad", path_for(magazine, ad));  link("Logout", logout_path)
redirect(old -> new, status = 302)  while testing;  301 only when final
```

**Don't:** Build /publishers/1/magazines/2/photos/3, accept all seven actions "just in case", or concatenate "/magazines/" + id. A permanent redirect is cached by browsers, so do not ship one you may reverse.

**Break it when:** Ids are unique only within the parent (the parent is then part of identity); linking outside the app; a canonical short URL is a public contract; a true permanent move.

**Source:** Guides: https://guides.rubyonrails.org/routing.html (Limits to Nesting, Shallow Nesting, Restricting the Routes Created, Listing Unused Routes, Generating Paths and URLs from Code, Redirection); https://guides.rubyonrails.org/2_2_release_notes.html (Shallow Route Nesting). Code: railties/lib/rails/commands/routes/routes_command.rb:11-16; actionpack/lib/action_dispatch/routing/redirection.rb:176,225.
