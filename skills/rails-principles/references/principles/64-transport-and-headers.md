# Secure transport and headers on by default

**Rule:** Enforce HTTPS app-wide through one setting with explicit exemptions, redirect non-read requests with a status that preserves method and body, send protective headers on every response, and introduce a strict content policy in report-only mode first.

**Why:** Per-handler redirects are forgotten. A 301 turns a POST into a GET; 308 keeps both. A strict policy enforced blind breaks legacy pages, while report-only collects violations. A per-request nonce breaks conditional-GET caching.

**Do:**
```
force_ssl = true; exclude = [health_check_path]
redirect http -> https: 308 for non-GET and non-HEAD
default headers on (frame, content-type sniffing, referrer); override one resource to embed
csp: report_only = true -> collect violations -> fix -> enforce
```

**Don't:** Turn on a strict policy blind, disable the headers site-wide to fix one page, or sprinkle per-handler redirects.

**Break it when:** A TLS-terminating proxy already redirects (tell the app to assume SSL). Embedding by design needs a per-resource frame header.

**Source:** Guides: https://guides.rubyonrails.org/security.html (HTTP Security Headers, Content-Security-Policy Header, Reporting Violations, Adding a Nonce); https://guides.rubyonrails.org/upgrading_ruby_on_rails.html (Force SSL, Redirection to HTTPS from HTTP); https://guides.rubyonrails.org/5_2_release_notes.html (CSP DSL). Code: railties/lib/rails/application/default_middleware_stack.rb:20-29; actionpack/lib/action_dispatch/railtie.rb:41-46.
