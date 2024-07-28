# Overview of a classic theme in WordPress

A classic theme is a more code centric way to create a theme. Although block themes might be the recommended approach, a classic approach may be preferred when you need more customization.

The only 2 required files are `index.php` and `style.css`.

When the client or user sends a request to the site for an html page it uses the query string to determine what template to use.

```
http://example.com/$THING1/$CATEGORY/$SLUG
```

Template hierarchy

| File           | Description                                    |
| -------------- | ---------------------------------------------- | --- |
| `index.php`    | Required file. Default if no template is found |
| `404.php`      |                                                |     |
| `category.php` |

Please note that this is still a work in progress.
