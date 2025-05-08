# Running neovim in an isolated docker context

Need a way to run [neovim](../619) using my configuration outside of my production neovim setup so I can configure things independently without breaking my current setup.

This is what I am thinking:

- Creating a dvim (docker nvim) command that work as if I am running something like vim or nvim on the command line. This will run neovim in docker.
- dvim will use a persistent state and data directory. State will be located at ~/.local/state/dvim and data will be located at ~/.local/share/dvim.
- For now only needs to run [MacOS](../654). Mac handles permissions differently.
- Version 0.11 or higher of neovim is required

## Patch

This patch introduces a Docker-based development environment for Neovim with local installation support. It allows for containerized builds and testing while enabling symlinking the configuration into your local Neovim setup. Importantly, the `dvim` script now utilizes and mounts **data** and **state** directories:

- **`DATA_DIR="${HOME}/.local/share/dvim"`:** This variable, set in `nvim/bin/dvim`, defines the path on the _host_ machine to the directory that will be mounted _inside_ the container as `/root/.local/share/nvim`. This directory is intended for storing persistent data, such as plugin data, language server information, and other files that should be preserved between container sessions.
- **`STATE_DIR="${HOME}/.local/state/dvim"`:** Similarly, this variable defines the path on the host to the directory mounted inside the container as `/root/.local/state/nvim`. This directory is for storing state information—things like session data, undo history, and other temporary files that are specific to the current working session. This will persist different changes and sessions

In summary, this patch enhances the dvim environment, allowing configurations to be used across the local build of Neovim while building Neovim into the container. This creates a containerization to use as a consistent build and includes the data, allowing saves across different containers. The symlinking creates a reference to test changes for Neovim across containers.

```gitdiff
commit 5aa9a9772de05d30a33c664a683f53914b5fd186
Author: Jared Rickert <jaredrickert52@gmail.com>
Date:   Sun May 4 23:55:31 2025 -0500

    feat: Enable containerized neovim development and local installation

    Introduce a Docker setup for neovim, alongside an installation script
    that allows for local configuration.

    The Docker setup provides an isolated environment for building and
    testing neovim configurations. The installation script then symlinks the
    configuration for use in the local environment. This ensures consistency
    between development and production and simplifies configuration
    management. A .gitignore file is included to ignore temporary files.

diff --git a/.gitignore b/.gitignore
index c3364e8..b56e869 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,3 +9,4 @@ venv
 home/.config/nvim/plugin/packer_compiled.lua
 vault.key
 home/.config/gh/hosts.yml
+tmp
diff --git a/nvim/Dockerfile b/nvim/Dockerfile
new file mode 100644
index 0000000..3c50884
--- /dev/null
+++ b/nvim/Dockerfile
@@ -0,0 +1,57 @@
+# Use the latest Ubuntu image as the base.  This provides a stable and up-to-date environment.
+FROM ubuntu:latest
+
+# Set noninteractive mode to avoid prompts during package installation.
+ARG DEBIAN_FRONTEND=noninteractive
+
+# Update the package lists and install necessary dependencies. See
+# https://github.com/nvim-lua/kickstart.nvim?tab=readme-ov-file#Install-Recipes
+# for ubuntu
+RUN apt-get update && \
+	apt-get install -y --no-install-recommends \
+	build-essential \
+	cmake \
+	curl \
+	fd-find \
+	fontconfig \
+	gcc \
+	git \
+	luarocks \
+	make \
+	pkg-config \
+	python3 \
+	python3-pip \
+	ripgrep \
+	software-properties-common \
+	unzip \
+	wget \
+	xclip
+
+# Install stylua
+RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ./rustup.sh && \
+	bash ./rustup.sh -y && \
+	rm ./rustup.sh
+RUN . /root/.cargo/env && cargo install stylua --features luajit
+
+# Add the Neovim PPA to get the latest version.  This is the recommended way to install Neovim on Ubuntu.
+RUN add-apt-repository ppa:neovim-ppa/unstable && \
+	apt-get update
+
+# Install Neovim.
+RUN apt-get install -y neovim
+
+# Install Node.js and npm (optional, but often needed for plugins).  Use the
+# NodeSource repository for a more up-to-date version.
+# Probably used for TypeScript
+RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
+	apt-get install -y nodejs
+
+# Install Ruby and gem (optional, but often needed for plugins).
+# No clue if I use this at all
+# RUN apt-get install -y ruby ruby-dev
+
+# Copy over the neovim configuration
+COPY ./src /root/.config/nvim
+
+# Define the entry point command.  This is the command that will be executed when the container starts.
+ENTRYPOINT ["nvim"]
diff --git a/nvim/bin/dvim b/nvim/bin/dvim
new file mode 100755
index 0000000..3739eea
--- /dev/null
+++ b/nvim/bin/dvim
@@ -0,0 +1,45 @@
+#!/usr/bin/env bash
+
+set -o errexit  # exit if non-zero status code is returned
+set -o nounset  # exit if undefined variable is used
+set -o pipefail # exit if no-zero status code is returned in a pipeline
+
+declare NOCOLOR=
+[[ -t 1 ]] || NOCOLOR=y
+declare RED='[38;2;255;0;0m'
+declare RESET='[0m'
+
+if [[ -n "$NOCOLOR" ]]; then
+	RED=
+	RESET=
+fi
+
+SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
+PROJECT_DIR="$(cd "${SCRIPT_DIR}" && git rev-parse --show-toplevel)"
+CONFIG_DIR="${PROJECT_DIR}/nvim/src"
+CONFIG_DIR="${PROJECT_DIR}/nvim/old-src"
+DATA_DIR="${HOME}/.local/share/dvim"
+STATE_DIR="${HOME}/.local/state/dvim"
+
+# Define the Docker image to use.
+IMAGE_NAME="dvim:latest" # Or a more specific Ubuntu version
+
+# Check if Docker is installed.
+if ! command -v docker &>/dev/null; then
+	echo "${RED}Error: Docker is not installed. Please install Docker.${RESET}"
+	exit 1
+fi
+
+# Check if the image exists, and set it up if it doesn't.
+if ! docker image inspect "${IMAGE_NAME}" &>/dev/null; then
+	../setup.sh
+fi
+
+docker run -it \
+	--volume "${DATA_DIR}:/root/.local/share/nvim" \
+	--volume "${STATE_DIR}:/root/.local/state/nvim" \
+	--volume "${CONFIG_DIR}:/root/.config/nvim" \
+	--volume "${PWD}:/mnt/volume" \
+	--workdir "/mnt/volume" \
+	"${IMAGE_NAME}" \
+	"$@"
diff --git a/nvim/install.sh b/nvim/install.sh
new file mode 100755
index 0000000..93a18ca
--- /dev/null
+++ b/nvim/install.sh
@@ -0,0 +1,42 @@
+#!/usr/bin/env bash
+# Installs nvim configuration by symlink
+
+declare NOCOLOR=
+[[ -t 1 ]] || NOCOLOR=y
+declare GREEN='[38;2;0;255;0m'
+declare RESET='[0m'
+
+if [[ -n "${NOCOLOR}" ]]; then
+	GREEN=
+	RESET=
+fi
+
+SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
+SOURCE_DIR="${SCRIPT_DIR}/src"
+TARGET_DIR="${HOME}/.config/nvim"
+BACKUP_DIR="${HOME}/.local/state/dotfiles/backups"
+BACKUP_FILE="${BACKUP_DIR}/nvim" # Backup file name will be just "nvim"
+
+# Check if the target directory already exists.
+if [ -e "${TARGET_DIR}" ]; then
+	# If it exists, check if it's a symlink.
+	if [ -L "${TARGET_DIR}" ]; then
+		# If it's a symlink, check if it points to the correct directory.
+		if [ "$(readlink "${TARGET_DIR}")" = "${SOURCE_DIR}" ]; then
+			echo "${GREEN}Symlink already exists and points to the correct directory: ${TARGET_DIR} -> ${SOURCE_DIR}${RESET}"
+			exit 0 # Exit successfully if the symlink is already correct.
+		else
+			# If it's a symlink but points to the wrong directory, remove it.
+			echo "${GREEN}Removing existing symlink: ${TARGET_DIR}${GREEN}"
+			rm "${TARGET_DIR}"
+		fi
+	else
+		# If it's not a symlink (i.e., it's a regular directory or file), back it up.
+		echo "${GREEN}Backing up existing directory/file: ${TARGET_DIR} to ${BACKUP_FILE}${RESET}"
+		mv "${TARGET_DIR}" "${BACKUP_FILE}"
+	fi
+fi
+
+# Create the symlink.
+echo "${GREEN}Creating symlink: ${TARGET_DIR} -> ${SOURCE_DIR}${RESET}"
+ln -s "${SCRIPT_DIR}" "${TARGET_DIR}"
diff --git a/nvim/setup.sh b/nvim/setup.sh
new file mode 100755
index 0000000..287f120
--- /dev/null
+++ b/nvim/setup.sh
@@ -0,0 +1,48 @@
+#!/usr/bin/env bash
+
+# Script to build the Neovim Docker image.
+
+set -o errexit  # exit if non-zero status code is returned
+set -o nounset  # exit if undefined variable is used
+set -o pipefail # exit if no-zero status code is returned in a pipeline
+
+declare NOCOLOR=
+[[ -t 1 ]] || NOCOLOR=y
+declare RED='[38;2;255;0;0m'
+declare GREEN='[38;2;0;255;0m'
+declare RESET='[0m'
+
+if [[ -n "$NOCOLOR" ]]; then
+	RED=
+	GREEN=
+	RESET=
+fi
+
+SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
+cd "${SCRIPT_DIR}"
+
+# Define the Docker image name.
+IMAGE_NAME="dvim"
+
+# Define the Dockerfile path.
+DOCKERFILE_PATH="./Dockerfile"
+
+# Check if Docker is installed.
+if ! command -v docker &>/dev/null; then
+	echo "${RED}Error: Docker is not installed. Please install Docker.${RESET}"
+	exit 1
+fi
+
+# Check if the Dockerfile exists.
+if [ ! -f "${DOCKERFILE_PATH}" ]; then
+	echo "${RED}Error: Dockerfile not found at: ${DOCKERFILE_PATH}${RESET}"
+	exit 1
+fi
+
+# Build the Docker image.
+echo "${GREEN}Building Docker image: ${IMAGE_NAME}${RESET}"
+if ! docker build -t "${IMAGE_NAME}" -f "${DOCKERFILE_PATH}" .; then
+	:
+fi
+
+echo "${GREEN}Docker image built successfully: ${IMAGE_NAME}${RESET}"
diff --git a/nvim/src/.editorconfig b/nvim/src/.editorconfig
new file mode 100644
index 0000000..26aa98e
--- /dev/null
+++ b/nvim/src/.editorconfig
@@ -0,0 +1,15 @@
+[*]
+indent_style = tab
+indent_size = 4
+end_of_line = lf
+charset = utf-8
+trim_trailing_whitespace = true
+insert_final_newline = true
+
+[*.md]
+indent_style = space
+tab_width = 2
+
+[{*.yaml,*.yml}]
+indent_style = space
+tab_width = 2
diff --git a/nvim/src/init.lua b/nvim/src/init.lua
new file mode 100644
index 0000000..59af8cb
--- /dev/null
+++ b/nvim/src/init.lua
@@ -0,0 +1 @@
+require("jlrickert")
diff --git a/nvim/src/lua/jlrickert/init.lua b/nvim/src/lua/jlrickert/init.lua
new file mode 100644
index 0000000..e69de29
diff --git a/nvim/src/stylua.toml b/nvim/src/stylua.toml
new file mode 100644
index 0000000..331b288
--- /dev/null
+++ b/nvim/src/stylua.toml
@@ -0,0 +1,3 @@
+indent_type = "Tabs"
+indent_width = 4
+quote_style = "AutoPreferDouble"
```

## Dump

- Ubuntu setup found at <https://github.com/nvim-lua/kickstart.nvim?tab=readme-ov-file#Install-Recipes>

```lua
-- Set data directory
vim.opt.runtimepath:prepend(vim.fn.expand("~/.local/share/nvim"))
-- Set state directory
vim.opt.directory = vim.fn.expand("~/.local/state/nvim//") -- Note the double-slash
vim.opt.swapfile = true
```