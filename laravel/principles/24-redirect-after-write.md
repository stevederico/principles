# Redirect after a write

**Rule:** After a successful form post redirect to a named route and flash a message that lives for exactly the next request; on validation failure redirect back with the input, and never pass user-supplied input to a redirect that leaves your domain without an allowlist.

**Why:** Reloading the result page does not resubmit the form, and flash data ages out on its own: it lives for the next request, can be kept one more, or shown only now. The external-redirect helper performs no checking, so feeding it a request value is an open redirect.

**Do:**
```
on success: redirect(route("dashboard")).flash("status", "Saved")      # gone after the next request
on invalid:  redirect_back().with_input(request)
keep(["status"])    # one more request
if host(next) in allowed_hosts: redirect_away(next) else redirect(route("home"))
```

**Don't:** Rendering the result page straight from the post, storing notices as plain session keys you must remember to delete, or `redirect_away(request.next)`.

**Break it when:** API endpoints and XHR apps: return the resource and a status code, with messages in the body.

**Source:** https://laravel.com/docs/responses, https://laravel.com/docs/session ; code: src/Illuminate/Routing/Redirector.php, src/Illuminate/Session/Store.php
