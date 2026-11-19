# Send HTML, not JSON

**Rule:** Render pages on the server and send finished HTML. Update parts of the page by swapping fragments, not by shipping data and rebuilding it in the browser.

**Why:** Less code, one place for logic, fast first load, and no duplicate models on client and server.

**Do:**
```
click "Like" -> request -> server returns the new <like-button> HTML
browser swaps that one element
```

**Don't:** Build a JSON API plus a full client app for a page that mostly shows lists and forms.

**Break it when:** The UI is highly interactive (editors, canvases, offline). Use client logic there only.

**Source:** Rails practice, Hotwire.
