# How to get started developing themes and plugins with WordPress

WordPress can be hosted and developed locally on you machine.  It
consists of 4 things: content, themes, plugins, and the core.


Use this docker compose file

```
bash
version: "3.1"

services:
  wordpress:
    image: wordpress
    restart: always
    ports:
      - 8080:80
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: exampleuser
      WORDPRESS_DB_PASSWORD: examplepass
      WORDPRESS_DB_NAME: exampledb
    volumes:
      - .:/var/www/html/wp-content

  db:
    image: mysql:5.7
    platform: linux/x86_64
    restart: always
    environment:
      MYSQL_DATABASE: exampledb
      MYSQL_USER: exampleuser
      MYSQL_PASSWORD: examplepass
      MYSQL_RANDOM_ROOT_PASSWORD: "1"
    volumes:
      - db:/var/lib/mysql

volumes:
  db:
```

Running `docker-compose up` with docker compose file will spin up a new
WordPress site.  It will create a themes and plugins directory.  It
gives you a few starter plugins and themes to use.

```bash
docker-compose up
```

See also:

- VSCode setup for php and WordPress development

Meta:

    tags: #wordpress #php #javascript
