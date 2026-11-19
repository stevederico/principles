# Packages ship overridable defaults

**Rule:** A reusable package ships working defaults (config, views, strings, models, routes), merges its config beneath what the host app sets, looks for resources in an app-owned location before its own, and exposes named swap points so the host never edits or forks package files.

**Why:** Edits inside an installed dependency vanish on update, and a full copy freezes old defaults. The config merge is one level deep only, so a partly overridden nested block loses its missing sub-keys, and closures in config break config caching. Package resources live under the package's own namespace so names never collide, and tagged groups let a host copy out only the part it wants.

**Do:**
```
register(): merge_config(package_defaults, beneath = app_config["courier"])   # data only, no functions
render("courier::dashboard"): look in app/views/vendor/courier/, then in the package
translations: app/lang/vendor/courier/fr = { welcome: "Salut" }   # only the changed keys, merged over the original
publish(tag = "courier-config")        # copies only the config
package.use_client_model(MyClient); package.ignore_default_routes()
```

**Don't:** Hard-coding concrete classes inside the package, telling users to edit vendor files, publishing every asset at once, or assuming a deep merge.

**Break it when:** A template or rule that must not be customized (token validation, security-sensitive screens): load it from the package only.

**Source:** https://laravel.com/docs/packages, https://laravel.com/docs/localization, https://laravel.com/docs/passport ; code: src/Illuminate/Support/ServiceProvider.php, src/Illuminate/Translation/FileLoader.php
