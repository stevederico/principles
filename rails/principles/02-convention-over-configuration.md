# Convention over configuration

**Rule:** Pick one default for every common decision, derive names from a single source, and ask for settings only when someone deviates.

**Why:** Each choice costs time and gives every project a different answer. A shared default removes the decision. Conventions can also switch features on by name, at the price of reserved names.

**Do:**
```
class Post                -> table "posts", key "post_id"
action "index"            -> template "index", layout of its controller
controller names plural, model names singular, file name = type name
reserved column names (id, type, version, created_at, updated_at, *_count) trigger built-in features
overrides allowed, kept small: table_name = "legacy_posts"
```

**Don't:** Ship a framework whose first hour is a config file, or let a name silently collide with a built-in (the code raises when an attribute name shadows a framework method).

**Break it when:** The default truly does not fit. Allow the override, but remember it leaks into helper tools (test fixtures must be told about a custom table name).

**Source:** Doctrine: https://rubyonrails.org/doctrine (Convention over Configuration). Guides: https://guides.rubyonrails.org/active_record_basics.html (Naming Conventions, Schema Conventions, Overriding the Naming Conventions); https://guides.rubyonrails.org/active_support_core_extensions.html (Inflections); https://guides.rubyonrails.org/layouts_and_rendering.html (Conventional Rendering, Automatic Layout Selection); https://guides.rubyonrails.org/action_controller_overview.html (Naming Conventions). Code: activerecord/lib/active_record/attribute_methods.rb:236-240; railties/lib/rails/application/finisher.rb:17-29.
