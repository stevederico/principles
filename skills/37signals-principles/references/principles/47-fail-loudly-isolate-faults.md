# Fail loudly on missing parts, and isolate faults at the boundary

**Rule:** Accessing a required element, reference or style hook that is absent should raise a precise message; optional ones are guarded by an existence check. Wrap every call from the framework into application code so one failure is logged with context and does not stop the rest.

**Why:** A silent null spreads and fails later and elsewhere; a message naming the component and the missing part is actionable. One broken handler should not prevent other components from attaching. A replaceable handler lets teams route errors to their tracker.

**Do:**
```
require(target "results") -> raises "Missing target results for search"
if has(target "results"): use it
try call(component.method)
catch e: handle_error(e, "invoking action X", { id, element, event })   # log + global hook
in tests: re-raise to fail fast
```

**Don't:** Return null for a required part, or let one exception abort the whole attach pass.

**Break it when:** Absence is normal; model it with the existence check, not by catching errors.

**Source:** https://stimulus.hotwired.dev/reference/targets ; https://stimulus.hotwired.dev/reference/outlets ; https://stimulus.hotwired.dev/handbook/installing (Error handling) ; code: https://github.com/hotwired/stimulus src/core/target_properties.ts, src/core/application.ts, src/core/binding.ts.
