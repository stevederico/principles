# One broken item must not break the page

**Rule:** Wrap per-item rendering and side-processing so a failure renders a placeholder or nothing, reports the error, and lets the rest of the page and request through.

**Why:** One unrenderable message would otherwise take down every page that shows it. A bot that times out posts a chat reply instead of an error, and a failing link preview returns no content.

**Do:**
```
render_item(m): on error -> report(m.id, error) ; render "unrenderable"
presentation(m): on error -> report ; ""
webhook timeout -> post reply "did not respond within 7 seconds"
unfurl deadline -> log ; return nothing
```

**Don't:** Let an exception in a collection partial return a server error for the whole page.

**Break it when:** The failure signals data corruption you must stop on.

**Source:** https://github.com/basecamp/once-campfire app/helpers/messages_helper.rb, app/models/webhook.rb, app/controllers/unfurl_links_controller.rb, app/models/message/attachment.rb.
