# Version every release by its source commit and stamp it on responses

**Rule:** Name each release by the source revision, build from a clean checkout of it, mark a dirty-tree build visibly, and let every response carry the running version and revision in headers.

**Why:** Only committed files are built by default; using the working tree is an explicit setting that adds an "uncommitted" random suffix, and no repository means no derived version. Headers let operators and bug reports name the exact build without logging in.

**Do:**
```
version = vcs.revision() ; if working-tree build and dirty: version += "_uncommitted_" + random()
build(clone_of(version))
before each request: headers["X-Version"] = app_version ; headers["X-Rev"] = git_revision    # from build args
```

**Don't:** Tag with "latest" only, ship uncommitted edits under a clean-looking revision, or show the version only on an admin page.

**Break it when:** Generated inputs outside version control are required (set the context, accept the suffix), or disclosing the version is a policy risk.

**Source:** https://kamal-deploy.org/docs/configuration/builders/ ; code: https://github.com/basecamp/kamal lib/kamal/configuration.rb ; https://github.com/basecamp/once-campfire app/controllers/concerns/version_headers.rb ; https://github.com/basecamp/writebook Dockerfile.
