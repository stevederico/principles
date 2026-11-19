# After a successful change, redirect; render in place only for errors

**Rule:** Answer a successful state-changing form with a redirect to a readable page, render the response directly only for client-error and server-error statuses, and block a second submit while one is in flight.

**Why:** A page rendered from a POST leaves the address on the action, so a reload repeats or breaks it. Error statuses are safe to render in place. Disabling the submitter and marking the region busy with a standard attribute prevents duplicate side effects and gives styling and assistive tools a hook.

**Do:**
```
on success: respond 303 -> show_page
on validation failure: 422 + form html ; on crash: 500 + error page
request start: submitter.disabled = true ; mark region busy
request end (success, failure or error): restore both
```

**Don't:** Return a rendered page with success status from a POST, or rely on users not double-clicking.

**Break it when:** The reply is a set of stream fragments that update the page without navigation, or the server de-duplicates by idempotency key (still show the busy state).

**Source:** https://turbo.hotwired.dev/handbook/drive (Redirecting after a form submission) ; https://turbo.hotwired.dev/reference/attributes ; code: https://github.com/hotwired/turbo src/core/drive/form_submission.js, src/core/drive/navigator.js.
