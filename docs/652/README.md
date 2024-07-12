# Reusable Mariadb SQL scripts on the CLI

This is a tricky that I have been playing around with for managing [Mariadb](../654) databases.

```sql
SELECT * FROM seo_301s WHERE redir_url = @redir_url;
```

```bash
#!/usr/bin/env bash
REDIR_URL=$1

mysql -h localhost -u devel -p -D devdb -e "set @redir_url='${REDIR_URL}'; source ./query.sql"
```
