# Change many hosts in groups, and keep every upgrade reversible

**Rule:** Limit how many hosts change at once and pause between groups; pull a host out of its external balancer before restarting its proxy; for a breaking tool upgrade, step through a last old-line release that can downgrade, validate the new config per environment first, and make upgrade and downgrade safe to rerun.

**Why:** A proxy reboot causes a short outage per host, so rolling plus pre and post hooks gives zero downtime. Rerunnable steps against already-converted hosts make partial failures recoverable.

**Do:**
```
for group in slices(hosts, limit): pre_hook(group) ; update(group) ; post_hook(group) ; sleep(wait)
validate(new_config, each environment) ; upgrade(rolling) ; on trouble: downgrade()
route to targets by stable container names on a user-defined network, not by IP
```

**Don't:** Restart every proxy at once behind one balancer, flip all hosts with no way back, or store container IPs in routing.

**Break it when:** A single host, a maintenance window with traffic stopped, or a disposable environment (rebuild instead).

**Source:** https://kamal-deploy.org/docs/configuration/booting/ ; https://kamal-deploy.org/docs/commands/proxy/ ; https://kamal-deploy.org/docs/upgrading/overview/ ; https://kamal-deploy.org/docs/upgrading/network-changes/ ; code: https://github.com/basecamp/kamal lib/kamal/cli/app.rb, lib/kamal/cli/main.rb.
