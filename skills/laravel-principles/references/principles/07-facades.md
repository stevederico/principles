# Facades

**Rule:** Offer short static-looking access to container services, where the call resolves the real service from the container and can be swapped in tests.

**Why:** Plain injection is wordy for simple calls; a facade keeps call sites short while the container still decides what runs. Swapping replaces both the cached instance and the binding, so injected users and facade users see the same fake. Facades and function-style helpers are equivalent.

**Do:**
```
Cache.get("key")          # looks static
# really: container.make(Cache).get("key")
Cache.fake()              # tests swap the service
Cache.swap(double)
```

**Don't:** Hiding a fixed singleton behind the short name, or letting one class quietly use a dozen facades (no constructor grows to warn you).

**Break it when:** A class collects many facades: split it, or inject explicitly so its size shows. Reusable packages that run outside the host framework depend on interfaces from a contracts package and boot a host app in their tests.

**Source:** https://laravel.com/docs/facades, https://laravel.com/docs/contracts, https://laravel.com/docs/packages, https://laravel.com/docs/mocking ; code: src/Illuminate/Support/Facades/Facade.php
