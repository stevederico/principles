# Stable hooks for browser tests

**Rule:** In browser tests select elements by a dedicated test-only attribute instead of layout classes or position, and wrap each page and each reusable widget in a small object whose verbs the tests call.

**Why:** Styling changes break selectors that mirror the layout, while a dedicated hook survives a redesign. When a date picker changes, one component object changes instead of dozens of tests, and a page object's built-in check confirms the test landed on the right screen.

**Do:**
```
markup: button with test-id = "login-button"
test: click("@login-button")
page LoginPage: url "/login"; assert path == url; element email = "input[name=email]"
component DatePicker: root ".date-picker"; select_date(y, m, d)
test: visit(LoginPage); within(DatePicker, select_date(2026, 1, 30))
```

**Don't:** Long structural selectors, or copying click-by-click steps into every test.

**Break it when:** Accessibility tests, where selecting by visible label or role is the point; a flow used once, where inline is clearer.

**Source:** https://laravel.com/docs/dusk ; code: docs only
