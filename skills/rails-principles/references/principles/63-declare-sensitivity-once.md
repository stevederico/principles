# Declare sensitivity once

**Rule:** Mark a field sensitive where it is defined, so storage encryption, log and console masking follow from that one declaration, and default to the strongest mode with a named opt-in for the weaker one that enables a feature.

**Why:** Application-level encryption keeps backups, logs and the console from leaking plaintext, and it shows in code what is sensitive. Randomized encryption resists analysis but cannot be searched; deterministic allows equality search and unique indexes but leaks equality.

**Do:**
```
model Author:
  sensitive note                       # random, not searchable
  sensitive email, deterministic       # searchable by exact match, leaks equality
result: stored encrypted; shown as [FILTERED] in logs, params, inspect output
log_filter = substrings [passw, secret, token, _key, ssn, cvv]    # one fragment covers many names
```

**Don't:** Encrypt in one place and leak plaintext through logs and error pages elsewhere, make everything deterministic "just in case", or rely on each developer to scrub by hand.

**Break it when:** The field is not sensitive (encryption costs storage and querying), or it is a lookup key you must query. Relax masking only in local development.

**Source:** Guides: https://guides.rubyonrails.org/active_record_encryption.html (Why Encrypt Data at the Application Level?, Querying Encrypted Data, Filtering Params Named as Encrypted Attributes); https://guides.rubyonrails.org/action_controller_advanced_topics.html (Log Filtering); https://guides.rubyonrails.org/6_0_release_notes.html (hide sensitive data in inspect). Code: activerecord/lib/active_record/encryption/scheme.rb:60-64; activerecord/lib/active_record/encryption/auto_filtered_parameters.rb; railties/lib/rails/generators/rails/app/templates/config/initializers/filter_parameter_logging.rb.tt:6-8.
