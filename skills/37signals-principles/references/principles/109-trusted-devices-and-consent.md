# Keep code and secrets on trusted devices, and impersonate only with consent

**Rule:** Allow code checkouts, stored secrets and internal access only from centrally configured devices (encryption, firewall, patches, remote wipe); treat unmanaged devices as untrusted; use a customer-impersonation tool only after the customer explicitly permits it.

**Why:** Knowing a device is safe is what lets you grant it access to sensitive systems, and a lost device must be wiped. Customers expect confidentiality even from the company, so a tool's power calls for matching restraint.

**Do:**
```
trusted = managed baseline or hardened image ; untrusted: no code, no secrets, no VPN
onboard and offboard credentials through a password manager ; internal access via VPN
impersonate(customer) only if customer_granted_permission(ticket) ; log reason
```

**Don't:** Keep personal data on a work machine or secrets on a personal one, or sign in as a customer "just to check".

**Break it when:** Low-sensitivity apps on unmanaged devices; never for secrets.

**Source:** https://github.com/basecamp/handbook/blob/main/managing-work-devices.md ; https://github.com/basecamp/handbook/blob/main/our-internal-systems.md. Docs only.
