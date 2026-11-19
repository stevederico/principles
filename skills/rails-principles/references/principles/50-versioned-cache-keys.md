# Stable cache keys with a version

**Rule:** Name a cached value by a stable key and store a separate version (the data's last-changed stamp) with it. A read with a different version is a miss, and the rewrite replaces the same slot. For nested caches, make a child change bump its parent's stamp.

**Why:** No invalidation code and no stale reads, and one slot per thing instead of a dead entry per edit. A timestamp inside the key leaves unused keys until the store evicts them. The outer fragment does not include inner keys: it stays fresh only because the child touches the parent.

**Do:**
```
key     = "post/" + post.id                 # stable
version = post.updated_at
cache.fetch(key, version): render(post)     # stored version != version -> miss, overwrite
comment.parent = post, touch_parent_on_change  # editing a comment moves post.updated_at
fragment key also includes a digest of the template text
collection: key = query identity; version = count + max(updated_at)
```

**Don't:** Delete entries by hand after every write, nest caches without the touch link, put the timestamp in the key where the store can version, or set layout content from inside a cached fragment (a hit replays only the output).

**Break it when:** The store cannot keep a version beside the value (then put it in the key), or output changes without the stamp moving (helper code, another value): bump a hand-managed prefix like "v2" or fold the value into the version.

**Source:** Guides: https://guides.rubyonrails.org/caching_with_rails.html (Low-Level Caching, Fragment Caching, Russian Doll Caching, External Dependencies); https://guides.rubyonrails.org/5_2_release_notes.html (recyclable cache keys); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (Active Storage variant processor). Code: activerecord/lib/active_record/integration.rb:20-24,83-135; activesupport/lib/active_support/cache.rb:467,507-523; actionview/lib/action_view/helpers/cache_helper.rb:25-50,233-250; activerecord/lib/active_record/associations/builder/belongs_to.rb:24,92-94.
