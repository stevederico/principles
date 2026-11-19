# Drive deploys as an imperative script with a ladder of commands

**Rule:** Implement a deploy as an ordered list of explicit steps that each finish before the next starts, and ask the proxy to switch traffic with a call that returns when the switch is done. Offer narrower commands for narrower jobs and confirm destructive ones.

**Why:** The Kamal docs chose imperative steps over declarative reconciliation: a declarative proxy forced a request-then-poll pattern, and immutable labels made draining awkward. Blocking steps map one to one and keep failures local. A ladder (setup, deploy, redeploy) skips first-time work on routine ships, and removal or proxy reboot ask for confirmation by default with a flag for automation.

**Do:**
```
setup    = bootstrap + accessories + deploy
deploy   = login ; build_and_push ; pull ; ensure_proxy ; start_new ; proxy.deploy(new) ; stop_old ; prune
redeploy = deploy minus bootstrap, proxy start, prune, login
confirm("this causes downtime") unless --yes
```

**Don't:** Hand a desired-state document to a reconciler and poll to learn whether it finished, or repeat first-time work on every deploy.

**Break it when:** Hundreds of nodes with churn make a continuous reconciler the point.

**Source:** https://kamal-deploy.org/docs/upgrading/proxy-changes/ ; https://kamal-deploy.org/docs/commands/deploy/ ; https://kamal-deploy.org/docs/commands/redeploy/ ; https://kamal-deploy.org/docs/commands/remove/ ; code: https://github.com/basecamp/kamal lib/kamal/cli/main.rb, lib/kamal/cli/base.rb.
