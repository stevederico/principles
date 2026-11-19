# Majestic monolith

**Rule:** Start with one deployable app and one codebase. Reuse infrastructure you already run before adding services. Split only when a measurement demands it.

**Why:** Services add network calls, versioning and deploy coordination. Rails 8 backs queue, cache and pub-sub with the application database, to avoid a broker, a cache server and their upkeep.

**Do:**
```
one repo, one codebase, one deploy unit
queue, cache, pub-sub use the database you already operate (a separate schema is fine)
first split: the same code booted as a standalone worker or socket server
extract a real service only when one module needs its own scale, security boundary, or team
```

**Don't:** Add a message broker, cache server and search server on day one for scale you do not have, or assume "one app" means "one database".

**Break it when:** Parts have very different load, a hard security boundary, or separate owners, and you measured it.

**Source:** Doctrine/practice: "The Majestic Monolith" (DHH). Guides: https://guides.rubyonrails.org/8_0_release_notes.html (Solid Queue, Solid Cache, Solid Cable); https://guides.rubyonrails.org/action_cable_overview.html (Running Standalone Cable Servers); https://guides.rubyonrails.org/active_record_multiple_databases.html (Overview). Code: railties/lib/rails/generators/rails/app/templates/Gemfile.tt:14-24; activerecord/lib/active_record/tasks/database_tasks.rb:254-271.
