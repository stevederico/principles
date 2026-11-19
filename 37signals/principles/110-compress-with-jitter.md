# Compress by default with size jitter, and guard authenticated traffic on request

**Rule:** Compress responses for speed, add random length jitter to blunt length-based attacks on secrets, and offer a strict mode that skips compression for authenticated traffic; ship secure defaults with named switches for each relaxation and one documented precedence between config sources.

**Why:** Compressing a response that mixes secrets with attacker-influenced text can leak secrets through its length. The default favors speed with baseline protection; strict mode removes the side channel at the cost of bandwidth, and checks response signals (set-cookie, private, no-store, vary on cookie) as well as request ones. Self-hosters sit behind odd proxies, so every relaxation needs a name.

**Do:**
```
compress(response, min_size = 1 KB, skip already-compressed types, jitter = 32 bytes)
if strict and (request has cookie, authorization or token, or response is private): do not compress
force_ssl unless DISABLE_SSL ; embed policy = env table or account table or permissive    # never merged
```

**Don't:** Compress secret-bearing pages with no mitigation, or merge config sources silently in part.

**Break it when:** Responses never contain secrets, bandwidth cost outweighs the risk, or a setting is a safety invariant with no legitimate relaxation.

**Source:** https://github.com/basecamp/thruster README.md (BREACH mitigation), CHANGELOG.md, internal/compression_handler.go, internal/compression_guard_handler.go ; https://github.com/basecamp/once-campfire config/environments/production.rb ; https://github.com/basecamp/writebook app/models/embed_provider.rb.
