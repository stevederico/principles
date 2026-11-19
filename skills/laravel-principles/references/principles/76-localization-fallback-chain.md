# Translation fallback chain

**Rule:** Look a string up in the requested language, then in the fallback language, then return the key itself, never an empty string or a crash.

**Why:** A leaked key is easy to spot in the UI and in tests, while a blank hides the gap. The default text itself can serve as the key, so the fallback shows readable text. The fallback language is a named setting.

**Do:**
```
t("messages.welcome", locale = "fr")  ->  fr  ->  fallback_locale  ->  "messages.welcome"
locale.fallback = "en"
```

**Don't:** Returning an empty string or raising on a missing entry in production.

**Break it when:** A CI check that must fail on missing keys: add a strict mode in tests.

**Source:** https://laravel.com/docs/localization ; code: src/Illuminate/Translation/Translator.php
