# Make the plain request path work first; live updates are an upgrade

**Rule:** Build each flow with ordinary request and redirect, then add stream updates on top; let the client state which response forms it accepts and let the server choose.

**Why:** Sockets drop on bad networks and some clients cannot use them. One endpoint can then serve the enhanced client, a plain browser and a native shell without parallel API routes.

**Do:**
```
client: for state-changing requests, accept += "stream-type"
server: match accept
    stream-type -> reply with fragments
    html        -> redirect to the page
```

**Don't:** Make a critical step succeed only when a pushed message arrives, or create a parallel route per client kind.

**Break it when:** The feature is inherently live (presence); degrade by hiding it. A statically known client may use a dedicated endpoint if cheaper.

**Source:** https://turbo.hotwired.dev/handbook/streams (Progressively enhance, Streaming from HTTP responses) ; code: https://github.com/hotwired/turbo src/core/drive/form_submission.js.
