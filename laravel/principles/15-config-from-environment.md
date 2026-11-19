# Config from the environment

**Rule:** Read environment values in one config layer only. Code reads config, never the raw environment.

**Why:** Secrets and per-machine values stay out of source. Config can be cached, defaulted, and tested. Code never depends on where it runs.

**Do:**
```
# config/mail
host: env("MAIL_HOST", "localhost")

# anywhere else
config("mail.host")
```

**Don't:** Call `env("API_KEY")` deep in business code, or commit secrets.

**Break it when:** Never for secrets. Defaults may live in config.

**Source:** Laravel docs, configuration.
