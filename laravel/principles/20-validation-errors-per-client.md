# Validation errors per client

**Rule:** Failed validation raises one typed error holding the messages, and a single edge layer turns it into redirect-back-with-errors for browser forms or a 422 JSON body for API clients.

**Why:** Handlers never branch on client type, and one backend can serve a browser UI and a JSON client. Flashed old input leaves out password fields. Emailed links should point at named routes you promise to keep.

**Do:**
```
validate(input, rules)        # raises ValidationError(errors, status 422)
error layer:
  if client expects json: respond 422 {message, errors: {"users.0.email": [...]}}
  else: redirect_back(); flash(errors); flash(old_input without secrets)
protected action without a recent password: browser gets redirect, json client gets 423
```

**Don't:** Returning error arrays from handlers so each picks its own shape, or sending HTML to a client that asked for JSON.

**Break it when:** A flow needs a different redirect target or error bag: override it on the input object. A pure API answers JSON only.

**Source:** https://laravel.com/docs/validation, https://laravel.com/docs/fortify, https://laravel.com/docs/authentication ; code: src/Illuminate/Foundation/Exceptions/Handler.php, src/Illuminate/Validation/ValidationException.php, src/Illuminate/Auth/Middleware/RequirePassword.php
