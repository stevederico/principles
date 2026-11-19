# Form requests

**Rule:** Validate input before the handler body in one declared place, use a dedicated input object (authorize, rules, messages, after-checks) once the rules grow, and give the handler only the validated data.

**Why:** The handler stays short and the rules are easy to find. Resolution runs prepare, then authorize, then validate, so an unauthorized caller learns nothing about fields and triggers no lookups. Only the validated output is guaranteed checked: raw input stays reachable, arrays without key lists let nested keys through, and unknown fields fail only if you switch that on.

**Do:**
```
class CreatePostInput:
  prepare(input): normalize
  authorize(user): user.can("create", Post)              # runs first, failure means 403
  rules: title: required string max 255 ; author: array{name, username}
  after(validator): checks that need extra state add errors
  fail_on_unknown_fields: true
handler.create(input): Post.create(input.validated())    # never request.all()
```

**Don't:** Reading raw request data after validating, or an array rule with no allowed keys.

**Break it when:** A one- or two-field handler: inline validation is the documented common form. Webhook-style open payloads turn the unknown-field switch off for that route.

**Source:** https://laravel.com/docs/validation, https://laravel.com/docs/precognition ; code: src/Illuminate/Validation/ValidatesWhenResolvedTrait.php, src/Illuminate/Foundation/Http/FormRequest.php, src/Illuminate/Validation/Validator.php
