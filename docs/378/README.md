# Web authentication strategies

## Cross Site Request Forgery CSRF

This is when a bad actor sends a request to your backend. If bad.com makes a
post to your website then your cookie will be used to authenticate. To prevent
this require a _X-Request-By_ header to exist. Bad actors are unable to set the
header.

## See also

- https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html
