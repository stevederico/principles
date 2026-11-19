# Translate whole sentences, derive the keys

**Rule:** Put the entire phrase, its punctuation and the position of each variable in the translation entry. Code passes values and counts, never glues fragments or assumes plural shape. Derive keys from where the text lives, and make missing text visible.

**Why:** A currency symbol placed in code is right for one locale and wrong for another. Plural forms differ by language. A key built from template path or mailer and action means authors write a short relative key, and gaps are easy to find.

**Do:**
```
nl: product_price = "EUR {price}"      es: product_price = "{price} EUR"
t("product_price", price = 100)        t("inbox", count = n)    # picks zero, one, other
in view books/index:  t(".title")  ->  key books.index.title
mail subject key: user_mailer.welcome.subject
missing text: visible marker plus log in dev; raise in tests (opt in)
```

**Don't:** `t("currency") + price`, an if on count == 1 in code, or a silent blank for missing text.

**Break it when:** The text is never shown in more than one language. Shared text gets a global key.

**Source:** Guides: https://guides.rubyonrails.org/i18n.html (Passing Variables to Translations, Pluralization, "Lazy" Lookup, Action Mailer E-Mail Subjects, Handling Missing Translations). Code: actionview/lib/action_view/helpers/translation_helper.rb:16,44-48,94-106,146-165; actionmailer/lib/action_mailer/base.rb:948-951. The i18n library itself is an external gem not in this tree; raising in tests is only "a good idea" in the guide and commented out in generated configs.
