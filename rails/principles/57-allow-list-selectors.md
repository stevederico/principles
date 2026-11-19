# Allow-list every client-chosen selector

**Rule:** Anything a client can use to choose a host, locale, redirect target, file path, format, origin or deserialization type must be checked against an explicit list.

**Why:** These are quiet routes for DNS rebinding, header attacks, open redirects, path traversal and object-injection exploits. An off-site redirect from your own domain is phishing with your name on it.

**Do:**
```
first wrapper: if request.host not in allowed_hosts: 403   (exempt /up); wide hosts only in development
locale = requested if in [en, fr] else raise
redirect(target): internal only unless target.host in allowed_redirect_hosts
file = canonical(join(base, name)); require parent(file) == base; store as <id>, not <user name>
socket origin in allowed_origins
stored data may only decode into [Symbol, Date]
```

**Don't:** Reflect headers or params into hosts, redirects, paths or object types, or leave production hosts unset behind a proxy.

**Break it when:** Development; multi-tenant apps with many hosts (validate against the tenant table); an intentional external redirect with a validated host and the explicit flag.

**Source:** Guides: https://guides.rubyonrails.org/security.html (DNS Rebinding and Host Header Attacks, Redirection, File Uploads, File Downloads); https://guides.rubyonrails.org/configuring.html (config.hosts, enforce_available_locales, allowed_redirect_hosts, yaml_column_permitted_classes); https://guides.rubyonrails.org/action_cable_overview.html (Allowed Request Origins); https://guides.rubyonrails.org/6_0_release_notes.html. Code: actionpack/lib/action_dispatch/middleware/host_authorization.rb:5-13,136-148; actionpack/lib/action_controller/metal/redirecting.rb:30,117-125,155-204,273-295; actioncable/lib/action_cable/engine.rb:48.
