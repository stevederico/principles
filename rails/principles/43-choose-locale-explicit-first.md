# Choose the locale explicit-first, resolve text specific-to-general

**Rule:** Pick the language from the most explicit source first (URL, then domain, then saved preference), fall back to implied signals (header, then cookie), use IP geolocation last, and validate against the supported list. Look up messages from the most specific entry to the most general.

**Why:** Implied guesses are fallbacks. A locale visible in the URL means a shared link shows the same language. A specific-to-general chain lets a subtype have its own wording without defining every message everywhere.

**Do:**
```
locale = url or domain or user.saved or accept_header or default
if locale not in supported: locale = default
keys = ["models.Admin.attributes.name.blank", "models.Admin.blank",
        "models.User.attributes.name.blank",  "models.User.blank",
        "messages.blank", "attributes.name.blank"]
first_present(keys)
```

**Don't:** Infer language from IP alone, apply a stored value unvalidated, or hard-code wording at the validation site.

**Break it when:** One language and region; then one default message set suffices.

**Source:** Guide: https://guides.rubyonrails.org/i18n.html (Setting the Locale from a Request Parameter, from a URL Path, from the Domain Name, from User Preferences, Choosing an Implied Locale, Error Message Scopes). Code: activemodel/lib/active_model/error.rb:69-109. Locale selection is docs only (controller examples).
