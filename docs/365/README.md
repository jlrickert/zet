# How to setup email using AWS SES

Key steps

- Add domain identity to SES

  This required adding a bunch records to my domain.

  | Type  | Host                                                       | Value                                               |
  | ----- | ---------------------------------------------------------- | --------------------------------------------------- |
  | CNAME | `sezfk4ez22cadvefqym5pmg5ujegny6l._domainkey.jlrickert.me` | sezfk4ez22cadvefqym5pmg5ujegny6l.dkim.amazonses.com |
  | CNAME | `wjtfakigt77fmbrwsxa3secddck6ftpt._domainkey.jlrickert.me` | wjtfakigt77fmbrwsxa3secddck6ftpt.dkim.amazonses.com |
  | CNAME | `kor7wuwb44fz3koljtxzkxx6y4nwmw2p._domainkey.jlrickert.me` | kor7wuwb44fz3koljtxzkxx6y4nwmw2p.dkim.amazonses.com |

  One thing to note here is that on Namecheap .jlrickert.me is appended to the
  Host value.

- Use the code _from aws-lambda-ses-forwarder_. I think I ended up using node
  version 12.

## See also

- https://blog.agood.cloud/posts/2019/02/03/setting-up-email-via-ses-and-gmail/
- https://github.com/arithmetric/aws-lambda-ses-forwarder
- https://codethump.com/tutorials/send-receive-domain-email-aws-setup/