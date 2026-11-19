# Give stateful dependencies their own lifecycle

**Rule:** Databases, caches and search engines are deployed and upgraded by explicit commands, never by the app deploy; accept that they are not zero-downtime, keep their data in host-mounted directories, and bind their ports to a private interface.

**Why:** Accessories are not updated on deploy and not proxied, and rebooting one means downtime. Only setup boots them; a plain deploy never touches them.

**Do:**
```
setup():  boot_accessories() ; deploy()
deploy(): app only
upgrade_accessory(): edit image ; reboot(name)       # explicit, with a downtime warning
publish_port("127.0.0.1:3306:3306")
```

**Don't:** Restart the database every time the app ships, or bind it to all interfaces by accident.

**Break it when:** The dependency is stateless and cheap to recreate.

**Source:** https://kamal-deploy.org/docs/commands/accessory/ ; https://kamal-deploy.org/docs/configuration/accessories/ ; code: https://github.com/basecamp/kamal lib/kamal/cli/main.rb.
