# The host rules embedded modules

**Rule:** A reusable module embedded in an application extends the host and never overrides it. Where both define something the host wins, the module prefixes everything it owns, its schema changes enter the host's own history, and host classes are named, not hard-coded.

**Why:** The host is the final authority, and a module that shares names or tables with it breaks hosts that call things differently.

**Do:**
```
view lookup: host/views/blog/index first, then module/views/blog/index
module "blog": table blog_articles; route helper blog.articles_path; asset blog/style.css
install-migrations: copy module scripts into the host timeline, noted "from blog"
module config: author_class_name = "Person"      # a string
module code:   resolve(config.author_class_name) # at call time, never at load
tool templates: app copy shadows the built-in; a replacement falls back for the rest
```

**Don't:** Ship generic names from a shared module, let a module run its own migrations out of band, or fork a whole tool to change one template.

**Break it when:** The module is a platform that owns the product (an admin app of its own): isolate it fully and say so. Extending host tables with a mixin is also fine.

**Source:** Guides: https://guides.rubyonrails.org/engines.html (What are Engines?, Overriding Views, Copying the Migrations, Configuring the Engine to Use a Custom Class); https://guides.rubyonrails.org/generators.html (Overriding Generator Templates, Overriding Generators with Fallbacks). Code: railties/lib/rails/engine.rb:452-480,710-714; activerecord/lib/active_record/migration.rb:1117-1146; railties/lib/rails/generators/base.rb:283.
