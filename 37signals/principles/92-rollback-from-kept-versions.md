# Keep recent releases on each host so rollback needs no download

**Rule:** Retain a bounded count of previous containers and images per host, and make rollback mean "start an old one", never rebuild or re-pull; never let the retained count drop below one.

**Why:** Rolling back picks a retained version, stops the current one and starts the old image, with nothing from the registry. Where docs disagree, the code rules: the rollback page speaks of age (three days), but the prune page, config overview and code all prune by count and default to keeping the last five.

**Do:**
```
rollback(version): if not container_exists(version): fail("not available")
                   start(version) ; stop(current)
prune(): keep newest N containers and their images   # N >= 1, default 5
```

**Don't:** Prune so aggressively that the last good version is gone before the bug is noticed.

**Break it when:** Disk is tiny; lower N but never to zero.

**Source:** https://kamal-deploy.org/docs/commands/rollback/ ; https://kamal-deploy.org/docs/commands/prune/ ; https://kamal-deploy.org/docs/configuration/overview/ ; code: https://github.com/basecamp/kamal lib/kamal/configuration.rb, lib/kamal/cli/prune.rb, lib/kamal/commands/prune.rb.
