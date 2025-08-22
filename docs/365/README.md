# How to setup email using AWS SES

Key steps

- Add domain identity to SES

  This required adding a bunch records to my domain.

  | Type  | Host                                            | Value                               |
  | ----- | ----------------------------------------------- | ----------------------------------- |
  | CNAME | `[REDACTED_TOKEN]._domainkey.[REDACTED_DOMAIN]` | [REDACTED_TOKEN].dkim.amazonses.com |
  | CNAME | `[REDACTED_TOKEN]._domainkey.[REDACTED_DOMAIN]` | [REDACTED_TOKEN].dkim.amazonses.com |
  | CNAME | `[REDACTED_TOKEN]._domainkey.[REDACTED_DOMAIN]` | [REDACTED_TOKEN].dkim.amazonses.com |

  One thing to note here is that on Namecheap .jlrickert.me is appended to the Host value.

- Use the code _from aws-lambda-ses-forwarder_. I think I ended up using node version 12.

## See also

- https://blog.agood.cloud/posts/2019/02/03/setting-up-email-via-ses-and-gmail/
- https://github.com/arithmetric/aws-lambda-ses-forwarder
- https://codethump.com/tutorials/send-receive-domain-email-aws-setup/
