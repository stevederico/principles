# Ship a baseline that works without the script, then reveal enhancements

**Rule:** Build the basic function with markup and styles alone, hide enhanced controls by default, and reveal them only after the script confirms the capability exists.

**Why:** Old browsers and failed script loads are routine, and a button that does nothing is worse than no button.

**Do:**
```
css: .copy-button hidden ; .supported .copy-button visible
on connect: if capability_present(): add class "supported" to the root
form without script: plain submit and redirect still works
```

**Don't:** Show controls that need script and assume it loaded.

**Break it when:** The whole product is an app that cannot work without script; then show a clear no-script message.

**Source:** https://stimulus.hotwired.dev/handbook/designing-for-resilience. Docs only.
