# User text is data

**Rule:** Pass user text to templates as data, never as template text, and escape for the exact output format: script contexts need a dedicated encoder, and Markdown needs its own escaping or a sanitizer.

**Why:** An inline template string is compiled and run, so injected text can execute. Plain JSON inside a script tag can be broken out of. HTML escaping does not stop link syntax in Markdown, and raw HTML in Markdown is an XSS path.

**Do:**
```
render("Hello, escape(name)", {name: user_input})        # data in variables
var app = encode_for_script(data)                       # encoder for script context
render_markdown(user_text, html_input = "strip", allow_unsafe_links = false)
mail_markdown.secure_encoding(on)                       # escapes link and image syntax in data
```

**Don't:** render("Hello, " + user_input), or json output dropped raw into markup.

**Break it when:** Templates written by trusted staff, or fully trusted author content.

**Source:** https://laravel.com/docs/blade, https://laravel.com/docs/mail, https://laravel.com/docs/strings ; code: src/Illuminate/Support/Js.php, src/Illuminate/Mail/Markdown.php
