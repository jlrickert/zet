# Patch: homelab email admin@jlrickert.me

I setup email on 2025-08-23 on my [homelab](../578) so I have a working setup for experimentation.

Here is my current setup:

- [CloudFlare](../1114) for DNS
- [iCloud custom domain for email storage](../1115) Email storage for custom domains is offered if you subscribe. Its like 1$ per month
- [AWS SES](../1112) for sending and receiving email programmatically. See [SES setup for credentials](keg:priv/764)

## Patch

Pay for the iCloud subscriptions and setup custom domain. Apple has some setup magic with [CloudFlare](../1114) which makes it seamless.

> [!NOTE]
>
> The import magic will override conflicting things

Setup `app.mail` with iCloud. Just use `admin@jlrickert.me` credentials

---

References

- [AWS SES](../1112)
- [homelab](../578)
- [iCloud](../1115)
- [CloudFlare](../1114)
