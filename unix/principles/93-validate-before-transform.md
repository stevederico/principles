# Validate structured input before transforming it

**Rule:** Run structured input through a validating step against an explicit schema before the transform stage, and fail there with located errors.

**Why:** Transformation back ends get confused by broken structure, whereas a validating front end rejects bad input early and passes a clean event stream onward. The schema and style rules are hidden inputs that must be tracked beside the visible source.

**Do:**
```
events = validate(source, schema) or fail_with_location()
output = transform(events, style)
```

**Don't:** Let the transform stage discover structural errors halfway and emit garbled output.

**Break it when:** The input is trusted output of your own pipeline and the check costs more than it saves.

**Source:** http://www.catb.org/esr/writings/taoup/html/ch18s05.html (Document Type Definitions). Book only.
