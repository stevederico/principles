# Put dependencies in the image and all state under one mount

**Rule:** Bake the runtime and libraries into one image so a plain server with a container engine and an SSH key can run it; run web, workers, cache and TLS from that image, keep every piece of state under one volume path, migrate at start, and back up with the database's online backup interface. Build on the target architecture.

**Why:** No per-host language versions: add a fresh machine and it provisions itself. Files copied while the database is being written are not consistent, so restore removes the log files. Emulated builds on a different architecture are slow.

**Do:**
```
server prep = install container engine if missing ; everything else = image
entrypoint: db prepare ; start server
pre-backup hook: online backup -> storage/backups/<db>
restore hook: copy snapshot over db ; delete -wal and -shm
run as non-root ; pin the image tag by major, minor and patch
if local arch != target arch and a remote builder exists: build there
```

**Don't:** Provision runtimes and packages per host by hand, tar a live database, or emulate in CI forever.

**Break it when:** Kernel features or hardware access need host setup (use a docker-setup hook), or you use a managed database.

**Source:** https://kamal-deploy.org/ ; https://kamal-deploy.org/docs/configuration/builder-examples/ ; https://github.com/basecamp/once-campfire docs/self-hosting.md, script/admin/prepare-backup, bin/start-app, Dockerfile ; https://github.com/basecamp/writebook script/admin/prepare-backup.
