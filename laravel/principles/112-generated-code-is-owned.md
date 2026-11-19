# Generated code is owned code

**Rule:** Have scaffolding copy its output into the app as ordinary editable files instead of hiding it in a dependency, accept that the generated part has no upgrade path, and let teams customize the generator's templates.

**Why:** Auth screens and boilerplate always need tailoring, and ownership beats fighting a library. Copied templates mean later generations use your edits.

**Do:**
```
new_app --kit=react            # copies routes, controllers, views into the project
publish_templates()            # later generations use your copies
```

**Don't:** Expecting to pull upstream updates into a scaffold, or generating code at runtime from a hidden package.

**Break it when:** Security-critical logic that must be patched centrally belongs in a versioned library.

**Source:** https://laravel.com/docs/starter-kits, https://laravel.com/docs/artisan ; code: src/Illuminate/Foundation/Console/StubPublishCommand.php
