# Send HTML, not JSON

**Rule:** Render pages on the server and send finished HTML. Update parts of the page by swapping server-rendered fragments, and keep client code for what markup cannot do.

**Why:** Less code, one home for logic, fast first load, and no duplicate model on client and server. Behavior hooks sit in markup attributes, not inline scripts.

**Do:**
```
click "Like" -> request -> server returns the new like-button markup
browser swaps that one element
client script only modifies markup you already have
```

**Don't:** Build a JSON API plus a full client app for a page that mostly shows lists and forms.

**Break it when:** The UI is highly interactive (editors, canvases, offline) or you serve native clients: use client logic or a JSON profile there.

**Source:** Guides: https://guides.rubyonrails.org/working_with_javascript_in_rails.html (Introduction); https://guides.rubyonrails.org/using_hotwire_with_rails.html; https://guides.rubyonrails.org/3_0_release_notes.html (Unobtrusive JavaScript); https://guides.rubyonrails.org/getting_started.html (Hotwire); https://guides.rubyonrails.org/api_app.html. Docs only for the stance; the 422/303 status handling is in principle 33.
