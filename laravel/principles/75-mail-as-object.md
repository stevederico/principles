# Mail is a renderable object

**Rule:** Model each email as one self-contained object holding its envelope, content and data, so it can be rendered and previewed without sending, declared queued on the class itself, tested for content, and given a plain-text body next to the HTML one.

**Why:** Sending mail slows the response, so a message class can mark itself as always queued even when the caller says send. Returning the object from a route shows the rendered design in a browser with no real recipient. Failures of a queued message reach a failure hook on the same object. Provider tags and metadata ride on the envelope.

**Do:**
```
class InvoicePaid(invoice): envelope(subject, to); content(html = "invoice", text = "invoice_text")
class InvoicePaid implements queued_by_default
route /preview: return InvoicePaid(find(1))         # shown in the browser, nothing sent
html = InvoicePaid(invoice).render()
test: assert mail.sees_in_html("Total"); assert mail.sees_in_text("Total")
```

**Don't:** Building the body inline at the send site, sending synchronously inside a request, or shipping only an HTML body.

**Break it when:** A one-off internal alert that no template will ever reuse.

**Source:** https://laravel.com/docs/mail ; code: src/Illuminate/Mail/Mailable.php, src/Illuminate/Mail/Mailer.php
