# Config from the environment

**Rule:** Read environment values only inside config files, and all other code reads config, and config values stay plain serializable data.

**Why:** Secrets stay out of source. Deploy-time config caching skips loading the env file, so a raw env read elsewhere returns nothing in production. The cache command also rejects values it cannot serialize, such as functions.

**Do:**
```
# config/mail
host: env("MAIL_HOST", "localhost")
# everywhere else
config("mail.host")
# browser bundles see only env vars with a public prefix
# committing env files: encrypt the values, keep the names readable for review
```

**Don't:** env("API_KEY") inside a service (works locally, empty after caching), functions or live objects in config, a plain secrets file in the repo.

**Break it when:** Bootstrap code that runs before config exists may read env directly. In local development skip config caching so edits apply at once.

**Source:** https://laravel.com/docs/configuration, https://laravel.com/docs/deployment, https://laravel.com/docs/helpers, https://laravel.com/docs/packages, https://laravel.com/docs/vite ; code: src/Illuminate/Foundation/Bootstrap/LoadEnvironmentVariables.php, src/Illuminate/Foundation/Console/ConfigCacheCommand.php
