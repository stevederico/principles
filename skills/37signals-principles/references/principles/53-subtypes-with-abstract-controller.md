# Model closed sets of variants as subtypes with a shared base controller

**Rule:** For a small fixed set of variants (open, closed and direct rooms; page, section, picture), use subtype classes and give each a thin controller that supplies two hooks on a shared base.

**Why:** Shared lifecycle (create, edit, trash, position) lives once and the variant only says how to build itself and which params it accepts. A variant that relaxes permission must narrow its scope at the same time.

**Do:**
```
base LeafablesController: create update destroy show ; hooks new_leafable, leafable_params  # raise if unset
PagesController: new_leafable = Page.new(params) ; leafable_params = permit(body)
rooms: open <-> closed conversion allowed ; direct never converts (validation)
```

**Don't:** Use a type column and a case statement inside one controller.

**Break it when:** Variants differ in most of their behavior.

**Source:** https://github.com/basecamp/writebook app/models/leaf.rb, app/models/leafable.rb, app/controllers/leafables_controller.rb, app/controllers/pages_controller.rb ; https://github.com/basecamp/once-campfire app/models/room.rb, app/controllers/rooms/closeds_controller.rb.
