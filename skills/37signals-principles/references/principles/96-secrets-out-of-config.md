# Keep secrets out of config files and command lines

**Rule:** Name secrets in config, resolve them on demand from a secrets source at run time, ship them to the host as an owner-only file, and keep that source out of version control.

**Why:** Values come from a dotenv-style file with substitution or password-manager helpers and are written to an env file on the host rather than inlined in the run command. Secrets lost their separate generate-and-store lifecycle in the upgrade guide.

**Do:**
```
config: env.secret = ["DB_PASSWORD"]
secrets file: DB_PASSWORD = fetch_from_vault("db")     # evaluated when needed
deploy: upload(env_file, mode = owner_only) ; run(container, env_file)
```

**Don't:** Commit the secrets file, template secrets into the main config, or pass them as inline arguments.

**Break it when:** The value is not sensitive (use the clear section).

**Source:** https://kamal-deploy.org/docs/configuration/environment-variables/ ; https://kamal-deploy.org/docs/upgrading/secrets-changes/ ; code: https://github.com/basecamp/kamal lib/kamal/cli/app/boot.rb.
