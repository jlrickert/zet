# Docker compose service cli interactions

Chat GPT prompt

```
I need to be able to run one off commands with  wp-cli against the WordPress website that I have running. I would be using this as a test environment to test out `wp` before I do things agains a live environment. It would be ideal to be able to run `wp` inside of a container. There is a docker image called `wordpress:cli` that has `wp-cli` already installed.

Here is the docker compose file that I have so far:

# Contents of docker-compose.yaml file
version: '3.1'

services:
    wordpress:
        build:
            context: .
            dockerfile: wordpress.Dockerfile
        restart: always
        ports:
            - 8080:80
        depends_on:
            - db
        environment:
            WORDPRESS_DB_HOST: db
            WORDPRESS_DB_USER: exampleuser
            WORDPRESS_DB_PASSWORD: examplepass
            WORDPRESS_DB_NAME: exampledb
            WORDPRESS_DEBUG: true
        volumes:
            - ./internal:/var/www/html
            - ./packages/themes:/app/themes:ro
            - ./packages/plugins:/app/plugins:ro
            - ./config/uploads.ini:/usr/local/etc/php/conf.d/uploads.ini:ro

    db:
        image: mysql:5.7
        platform: linux/x86_64
        restart: always
        environment:
            MYSQL_DATABASE: exampledb
            MYSQL_USER: exampleuser
            MYSQL_PASSWORD: examplepass
            MYSQL_RANDOM_ROOT_PASSWORD: '1'
        volumes:
            - db:/var/lib/mysql

volumes:
    db:

# End of contents for docker compose-file

Lets say I have a bash script called `wp-script`.  I would like this to encapsulate the details of running wp. For example, I would like to run `./wp-script plugin install advanced-custom-fields --active`.  It may also be nice to have it automate a couple of things when first starting things up.
```

This is what I came up with

```bash
#!/bin/bash
# in hack

export PATH="${PWD}/scripts:${PATH}"
source "${PWD}/contrib/wp-completion.bash"
```

```bash
#!/bin/bash
# in scripts/wp

# Helper function to run wp-cli commands inside the WordPress container
function run_wp_command() {
	docker-compose exec -T wp-cli wp "$@"
}

# Check if the WordPress container is running, and if not, start it
function start_wordpress_container() {
	docker-compose up -d p-cliwordpress
}

# Check if any arguments are passed to the script
if [ $# -eq 0 ]; then
	echo "No wp-cli command provided. Usage: ./wp-script <wp-cli-command>"
	exit 1
fi

start_wordpress_container
run_wp_command "$@"
```

```bash
# in contrib/wp-completion.bash
# bash completion for the `wp` command

_wp_complete() {
	local OLD_IFS="$IFS"
	local cur=${COMP_WORDS[COMP_CWORD]}

	IFS=$'\n' # want to preserve spaces at the end
	local opts="$(wp cli completions --line="$COMP_LINE" --point="$COMP_POINT")"

	if [[ "$opts" =~ \<file\>\s* ]]; then
		COMPREPLY=($(compgen -f -- $cur))
	elif [[ $opts = "" ]]; then
		COMPREPLY=($(compgen -f -- $cur))
	else
		COMPREPLY=(${opts[*]})
	fi

	IFS="$OLD_IFS"
	return 0
}
complete -o nospace -F _wp_complete br8kthru-scripts wp
```

```yaml
version: '3.1'

services:
    wordpress:
        build:
            context: .
            dockerfile: wordpress.Dockerfile
        restart: always
        ports:
            - 8080:80
        depends_on:
            - db
        environment:
            WORDPRESS_DB_HOST: db
            WORDPRESS_DB_USER: exampleuser
            WORDPRESS_DB_PASSWORD: examplepass
            WORDPRESS_DB_NAME: exampledb
            WORDPRESS_DEBUG: true
        volumes:
            - ./internal:/var/www/html
            - ./packages/themes:/app/themes:ro
            - ./packages/plugins:/app/plugins:ro
            - ./config/uploads.ini:/usr/local/etc/php/conf.d/uploads.ini:ro
        networks:
            - wp-net

    wordpress-cli:
        image: wordpress:cli
        stop_signal: SIGINT
        depends_on:
            - db
            - wordpress
        links:
            - db
        environment:
            WORDPRESS_DB_HOST: db
            WORDPRESS_DB_USER: exampleuser
            WORDPRESS_DB_PASSWORD: examplepass
            WORDPRESS_DB_NAME: exampledb
            WORDPRESS_DEBUG: true
        volumes:
            - ./internal:/var/www/html
            - ./packages/media:/app/media:ro
            - ./packages/themes:/app/themes:ro
            - ./packages/plugins:/app/plugins:ro
        networks:
            - wp-net

    db:
        image: mysql:5.7
        platform: linux/x86_64
        restart: always
        environment:
            MYSQL_DATABASE: exampledb
            MYSQL_USER: exampleuser
            MYSQL_PASSWORD: examplepass
            MYSQL_RANDOM_ROOT_PASSWORD: '1'
        volumes:
            - db:/var/lib/mysql
        networks:
            - wp-net

volumes:
    db:

networks:
    wp-net: {}
```

    tags: #wordpress
