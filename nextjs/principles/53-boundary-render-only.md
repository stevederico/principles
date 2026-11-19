# Boundaries see render failures, not handler failures

**Rule:** Catch errors in event handlers and async callbacks explicitly and store them in state to render a fallback, because a render boundary only wraps rendering; rethrow inside a transition when you want the nearest boundary to take over.

**Why:** Handlers run after render and are outside the boundary's reach, and a client-thrown value passes through unchanged and may not even be an error object.

**Do:**
```
on_click():
  try: do_work()
  catch e: set_error_state(narrow(e))
render(): if error_state: fallback
```

**Don't:** Let handler exceptions go unhandled assuming a boundary exists, or read fields of a caught value without narrowing it.

**Break it when:** You want the failure to replace the region; throw it from within a transition.

**Source:** https://nextjs.org/docs/app/getting-started/error-handling, https://nextjs.org/docs/pages/building-your-application/configuring/error-handling; docs only
