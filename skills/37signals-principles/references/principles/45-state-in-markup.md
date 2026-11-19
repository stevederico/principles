# Keep UI state in the markup and render from one change callback

**Rule:** Store component state as typed attributes on its element, treat the behavior object as disposable, and render in a handler that runs once at start and after every change; keep only low-stakes personal state on the device and save drafts automatically.

**Why:** HTML from any source (first load, fragment, cache restore) then comes alive with the right state and no init step. A single render-from-state function replaces scattered manual refreshes, and live edits to the attribute update the view. Per-device preferences need no schema or write path.

**Do:**
```
values = { index: number default 0 }          # converted at one boundary, safe default when absent
on_index_changed(new, old): render(new)       # fires at init and on each write
device: cookie or local storage for sidebar state, reading position, unsent text draft
autosave form every few seconds and on leaving
```

**Don't:** Hold the only copy of state in an object a swap destroys, or call render by hand after each assignment.

**Break it when:** The state is large, derived or secret (keep it server-side), it is a handle to a timer or socket (release it on detach), or it must follow the user across devices.

**Source:** https://stimulus.hotwired.dev/handbook/managing-state ; https://stimulus.hotwired.dev/reference/values ; code: https://github.com/hotwired/stimulus src/core/value_observer.ts ; https://github.com/basecamp/writebook app/javascript/controllers/autosave_controller.js, app/javascript/helpers/reading_progress_helpers.js.
