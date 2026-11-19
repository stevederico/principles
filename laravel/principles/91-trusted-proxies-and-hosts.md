# Trusted proxies and hosts

**Rule:** Trust forwarded scheme, host and client-address headers only from an explicit list of proxies, accept only allowlisted Host values, and treat the client address as informational.

**Why:** Anyone can send these headers. The Host header builds absolute URLs, so a forged one points a reset email at an attacker's domain. Behind a TLS-terminating balancer the app must trust the balancer's headers or it builds insecure links.

**Do:**
```
trusted_proxies = ["10.0.0.0/8"]      # "*" only for dev tunnels, or when direct access is blocked
trusted_hosts = ["^example\\.com$"]   # subdomains optional
absolute_url(path): use config.app_url or the checked host
client_ip: logging only, never an access decision
```

**Don't:** Trusting every proxy on an app exposed directly to the internet, or interpolating the raw Host header into mailed links.

**Break it when:** Cloud balancers with unknown addresses: trust all only if the network blocks direct access. A web server in front already enforces hostnames.

**Source:** https://laravel.com/docs/requests, https://laravel.com/docs/passwords, https://laravel.com/docs/sail ; code: src/Illuminate/Http/Middleware/TrustProxies.php, src/Illuminate/Http/Middleware/TrustHosts.php
