# One resource, many representations

**Rule:** Serve HTML, JSON, PDF or markdown of a resource from one address, chosen by requested format. The handler loads the data once, each format has its own template, and an unavailable format is an explicit error.

**Why:** URLs stay identical and no parallel endpoint grows per format. The PDF is "just another representation" of the same record.

**Do:**
```
index: books = all_books()            # no format logic here
templates: index.html, index.json, index.pdf, index.html+mobile
GET /clients/1.pdf  -> pdf template
format not in the allowed list -> 406
record supplies its own markdown: page.to_markdown()
```

**Don't:** Branch on format inside the handler to build strings, add a download_pdf action per format, or write inline markup in handlers.

**Break it when:** One format only, or a heavy report with its own lifecycle (model the report as its own resource), or a public API with separate versioning.

**Source:** Guides: https://guides.rubyonrails.org/layouts_and_rendering.html (Multi-Format Responses, Template Variants); https://guides.rubyonrails.org/action_controller_advanced_topics.html (RESTful Downloads); https://guides.rubyonrails.org/8_1_release_notes.html (Markdown Rendering). Code: actionpack/lib/action_controller/metal/mime_responds.rb:224; actionpack/lib/action_controller/metal/implicit_render.rb:35-53; actionpack/lib/action_controller/metal/renderers.rb:219-222.
