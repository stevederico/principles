# Escape by default

**Rule:** Make escaping the default syntax for template output and give raw output a different, visibly dangerous syntax.

**Why:** The safe path costs nothing, so a hole needs an explicit decision, and reviewers can search for the raw form. A trusted-HTML value type is not escaped a second time.

**Do:**
```
Hello, escape(name)            # safe form is the default syntax
Hello, raw(trusted_html)        # different, visibly dangerous form, easy to grep
rendered = TrustedHtml(markdown_from_own_pipeline)
```

**Don't:** Building output by string concatenation, or making raw the default and asking people to remember to escape.

**Break it when:** A fragment you produced yourself and trust: wrap it in the trusted type once, at its source.

**Source:** https://laravel.com/docs/blade ; code: src/Illuminate/View/Compilers/BladeCompiler.php, src/Illuminate/View/Compilers/Concerns/CompilesEchos.php, src/Illuminate/Support/helpers.php
