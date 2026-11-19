# Let a thin edge terminate TLS, protect slow clients and serve files

**Rule:** Start the edge before the app and answer with a friendly bad-gateway page while it boots; issue certificates only for an allowlist of hosts on durable storage; trust forwarded headers only when another proxy sits in front; set read, write and idle timeouts; let the app authorize and the edge stream the file; configure each app's proxy settings at deploy time.

**Why:** Users see "starting", not a raw error. Issuing for any Host header lets others burn your quota; clients can forge forwarding headers when you terminate TLS yourself. Timeouts (30, 30 and 60 seconds) limit slow-client resource use. Freeing app workers from streaming large files keeps authorization in the app. Per-app settings sent at deploy let many apps share one proxy without restarts.

**Do:**
```
start(edge) ; start(app) ; backend unreachable -> 502 with static html
allowed = parse(TLS_DOMAIN) ; http redirect only if host in allowed else 421
trust_forwarded = not (we terminate TLS) ; else overwrite forwarded-for, host, proto, request id
app: check_auth ; respond(header x-sendfile = path) ; edge serves the file, removes the header
proxy.deploy(app, host, health_path, timeouts)
```

**Don't:** Issue for arbitrary hosts, keep certificates on ephemeral disk, pass client-sent forwarding headers through, or bake per-app timeouts into one shared proxy's startup flags.

**Break it when:** A load balancer holds traffic until health checks pass, a CDN terminates TLS, files are not on a disk shared with the edge, or streams are long-lived (exempt them and keep them flushable).

**Source:** https://github.com/basecamp/thruster README.md, CHANGELOG.md, internal/server.go, internal/config.go, internal/sendfile_handler.go, internal/proxy_handler.go ; https://kamal-deploy.org/docs/configuration/proxy/.
