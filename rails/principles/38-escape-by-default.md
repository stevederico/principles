# Escape by default, trust by explicit mark

**Rule:** Treat every string as unsafe for output, escape on insertion, and let only a deliberate, named call mark a value as trusted. Any transformation drops the mark, and user markup passes through an allow-list sanitizer.

**Why:** Safety then follows the data, not the developer's memory. The mark is only an assertion: it escapes nothing. Appending untrusted text to trusted text escapes the untrusted part. Sanitizing at render time also covers rows written before the rules changed.

**Do:**
```
output(title)                      # escaped
output(raw(cms_template))          # explicit, searchable
trusted + untrusted -> trusted + escaped(untrusted)
trim(trusted) -> untrusted again
output(sanitize(user_html))        # only allowed tags and attributes survive
text key "welcome_html" is markup; "welcome" is text; interpolated values escaped either way
rich_text.plain_text: NOT html safe
```

**Don't:** Call the trust marker on user input "to fix the display", strip a deny-list of bad tags, or store editor HTML and echo it.

**Break it when:** You built the markup yourself or ran it through a vetted allow-list sanitizer. Keep the marker call in one helper so it can be audited.

**Source:** Guides: https://guides.rubyonrails.org/active_support_core_extensions.html (Output Safety); https://guides.rubyonrails.org/security.html (Cross-Site Scripting countermeasures); https://guides.rubyonrails.org/action_view_helpers.html (Sanitization); https://guides.rubyonrails.org/i18n.html (Using Safe HTML Translations); https://guides.rubyonrails.org/action_text_overview.html (Rendering Rich Text Content). Code: activesupport/lib/active_support/core_ext/string/output_safety.rb:8-28,113; actionview/lib/action_view/helpers/sanitize_helper.rb:143-149; actiontext/lib/action_text/content.rb:120-132.
