# Normalize input at the edge

**Rule:** Trim strings and turn empty strings into null in one early layer before validation, exempting only fields whose raw bytes matter, and read input through typed getters that refuse garbage.

**Why:** Validators and handlers then see one canonical shape. A plain cast turns "abc" into 0; a strict getter returns the default instead. Date and id parsers throw on malformed input, so validate first. After empty-to-null, optional fields must be declared nullable, and format rules skip empty values unless the rule itself implies presence.

**Do:**
```
global layers: trim(except password fields), empty_to_null
per_page = input.integer("per_page", default = 15, strict = true)     # "abc" gives 15
validate(input, {birthday: nullable date})
birthday = input.date("birthday")                                     # safe after validation
```

**Don't:** Re-trimming in each handler, trusting a language cast, or calling a throwing parser on unvalidated input.

**Break it when:** Whitespace-sensitive fields (code snippets, markdown): skip normalization for that route.

**Source:** https://laravel.com/docs/requests, https://laravel.com/docs/validation, https://laravel.com/docs/middleware ; code: src/Illuminate/Foundation/Http/Middleware/TrimStrings.php, src/Illuminate/Support/Traits/InteractsWithData.php, src/Illuminate/Validation/Validator.php
