# State the compatibility promise

**Rule:** Publish what counts as public API and what does not, use semantic versions, send fixes to the stable branch and breaking changes to the next major, and rank each breaking change in the upgrade guide by likelihood of impact.

**Why:** Maintainers can rename parameters or add an interface method freely, and adopters know what to review first. Minor and patch releases never break the covered surface.

**Do:**
```
promise: minor and patch never break ; not covered: argument names
fix -> stable branch ; compatible small feature -> stable branch ; breaking -> next major
upgrade guide: High / Medium / Low impact, old and new snippet
interface gained a method: flagged for implementers
```

**Don't:** Renaming public parameters in a patch release without a note.

**Break it when:** Pre-1.0 libraries; a security fix may need backports to older lines.

**Source:** https://laravel.com/docs/releases, https://laravel.com/docs/upgrade, https://laravel.com/docs/contributions ; code: docs only (not in the framework repo)
