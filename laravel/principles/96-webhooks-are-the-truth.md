# Webhooks are the truth

**Rule:** Keep a local copy of billing state updated only from signed provider webhooks, gate features on that copy, and never mark an order paid because the user reached a success URL.

**Why:** Payments can settle later and users can close the tab, so the redirect proves nothing. The webhook route has no session, so it is exempt from forgery checks but must verify a shared-secret signature. Cancellation is an end date with a grace period, and amounts travel as integers in the smallest currency unit.

**Do:**
```
checkout = provider.checkout(price).custom_data({order_id: order.id})     # round-trip your own id
on_return: show "processing"
POST /billing/webhook: verify_signature(secret) else reject; Order.find(payload.order_id).update(status = "paid")
cancel(): ends_at = period_end ; subscribed(): ends_at is null or ends_at > now
charge(1000)         # ten units of currency, as integer cents
```

**Don't:** Trusting the success redirect, skipping signature checks, or flipping an active flag off at the cancel click.

**Break it when:** One-off payments may also fetch the payment on return, checking it belongs to this customer and succeeded, before fulfilling.

**Source:** https://laravel.com/docs/billing, https://laravel.com/docs/cashier-paddle, https://laravel.com/docs/csrf ; code: docs only (not in the framework repo)
