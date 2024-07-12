# Issue: stupid MacOSX permissions crap

[MacOSX](../654) handles permissions in a _special_ way. I ran into this issue on previous projects as well as well as my [dotfiles](../625). On mac the UID and GUI are below 1000. On Linux user accounts need to be 1000 or greater.

The problem that I had is that I wanted the home directory mounted to `/home/${username}` to have the same uid and guid as the created user.

## WIP solution

### dockerfile

`add-user.sh`:

```bash
#!/bin/bash

# Get the UID, GID, and USERNAME from environment variables (passed during docker run)
USER_ID=${LOCAL_UID:-1000}
GROUP_ID=${LOCAL_GID:-1000}
USERNAME=${USERNAME:-user}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID, USERNAME: $USERNAME"

# Create a group with the specified GID
groupadd --gid "${GROUP_ID}" "${USERNAME}"

# Create a user with the specified UID, GID, and username
useradd --shell /bin/bash --uid "${USER_ID}" --gid "${GROUP_ID}" --non-unique --create-home "${USERNAME}"

echo "$USERNAME ALL=(ALL:ALL) NOPASSWD:ALL" > "/tmp/${USERNAME}_sudo"
visudo -cf "/tmp/${USERNAME}_sudo" && cat "/tmp/${USERNAME}_sudo" >> /etc/sudoers
rm "/tmp/${USERNAME}_sudo"

# Change ownership of the working directory
chown -R "${USERNAME}:${USERNAME}" "/home/${USERNAME}"

# Switch to the new user
exec su - "${USERNAME}" -c "cd /home/${USERNAME}; exec /bin/bash"
```

`dockerfile`:

```dockerfile
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y sudo locales \
	&& rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

COPY ./lib/add-user.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/add-user.sh

ENTRYPOINT [ "/usr/local/bin/add-user.sh" ]
```

### Build script

```bash
#!/usr/bin/env bash

set -o errexit  # exit if non-zero status code is returned
set -o nounset  # exit if undefined variable is used
set -o pipefail # exit if no-zero status code is returned in a pipeline

SCRIPT_DIR=$(dirname "$(realpath "$0")")
PROJECT_DIR=$(realpath "$SCRIPT_DIR/..")

USER_ID=$(id -u)
GROUP_ID=$(id -g)
USERNAME=$(id -un)

cd "${PROJECT_DIR}"
docker build -t dotfiles-ubuntu -f Dockerfile.ubuntu .
```

### Run script

```bash
#!/usr/bin/env bash

set -o errexit  # exit if non-zero status code is returned
set -o nounset  # exit if undefined variable is used
set -o pipefail # exit if no-zero status code is returned in a pipeline

SCRIPT_DIR=$(dirname "$(realpath "$0")")
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")

USER_ID=$(id -u)
GROUP_ID=$(id -g)
USERNAME=$(id -un)

docker run -it --rm \
	--mount "type=bind,source=${PROJECT_ROOT},target=/home/${USERNAME}/.local/share/dotfiles" \
	--workdir "/home/${USER}" \
	--env "LOCAL_UID=${USER_ID}" \
	--env "LOCAL_GID=${GROUP_ID}" \
	--env "USERNAME=${USERNAME}" \
	dotfiles-ubuntu "$@"
```
