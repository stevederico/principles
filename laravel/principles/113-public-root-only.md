# Serve only the public directory

**Rule:** Point the web server at one dedicated public folder, route all other requests to a single entry script, and deny dotfiles and direct execution of other scripts.

**Why:** Config, env files and source sit above the public folder, and serving the project root exposes them.

**Do:**
```
document_root = <app>/public
route * -> public/index
deny dotfiles except .well-known
deny direct execution of scripts other than index
```

**Don't:** Moving the entry script to the project root, or serving the project from a subfolder of the web root.

**Break it when:** Shared hosting: use a rewrite that still maps only the public folder.

**Source:** https://laravel.com/docs/deployment, https://laravel.com/docs/installation ; code: src/Illuminate/Foundation/Console/ServeCommand.php
