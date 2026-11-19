# Fetch user-chosen URLs only through a guarded, pinned, bounded client

**Rule:** For any outbound request whose destination an ordinary user picks, resolve the host once, reject non-public addresses, pin the connection to that address, bypass proxies, re-check every redirect, cap body size and per-request time, and put one overall deadline on the operation.

**Why:** DNS rebinding and slow-drip responses defeat checks on the URL string alone; each reason is explained in a code comment. When only an administrator picks the destination (webhooks), the exposure differs.

**Do:**
```
ip = resolve_public(host)                    # raise if private
connect(host, pinned_ip = ip, proxy = none, timeout = 7 s, retries = 0)
loop up to 10 redirects: resolve and check each target again
read body in chunks ; abort past 5 MB ; require status and content type
timeout(10 s) { whole operation }
```

**Don't:** Validate the URL string and then let the library resolve it again.

**Break it when:** Only a trusted administrator chooses the destination.

**Source:** https://github.com/basecamp/once-campfire app/models/opengraph/fetch.rb, lib/restricted_http/private_network_guard.rb, app/controllers/unfurl_links_controller.rb, app/models/webhook.rb, SECURITY.md.
