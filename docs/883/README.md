# SPEC: dotz package manager

`dotz` is mean to be a `dotfiles` package manager designed to combine multiple dotfiles together. An example would be a set of dotfiles for work and personal use. The way that it will work is that there will be multiple repos tracked with git. Each repo will contain a bunch of packages.

## Dotfile repos

Each repo contains a `packages` directory that contains a `package.json`. Do note that `package.json` has nothing to do with the node echo system. I am just abusing some pre-existing tools that make use of the file `package.json`. A future version may switch to something like `dotz.yaml`.

`package.json` contains version info for the package that it resides in.

### Example personal repo

Example that includes the packages `chezmoi`, `go`, `shell`, and `yq`. These are mostly installers. `chezmoi` is unique in that it installs chezmoi as well as apply it to the system. The rest are just packages that installs `go`, `yq` to a custom location for the user.

```
❯ tree ~/repos/personal/dotfiles
.
├── package.json
├── packages
│   ├── chezmoi
│   │   ├── CHANGELOG.md
│   │   ├── README.md
│   │   ├── build
│   │   ├── install.sh
│   │   ├── home
│   │   │   ├── ...
│   │   │   └── ...
│   │   └── package.json
│   ├── go
│   │   ├── install.sh
│   │   ├── remove.sh
│   │   └── package.json
│   └── yq
│       ├── install.sh
│       ├── remove.sh
│       └── package.json
├── pnpm-lock.yaml
└── pnpm-workspace.yaml
```

### Example work repo

The work `dotfile` repo contains an installer for a custom program and some configuration.

```
❯ tree ~/repos/work/dotfiles
.
├── package.json
├── packages
│   └─── work-shell
│       ├── install.sh
│       ├── config.yaml
│       └── package.json
├── pnpm-lock.yaml
└── pnpm-workspace.yaml
```

## Configuration

The configuration will contain where to find packages and what packages to install

## Configuration example

The configuration needs to specify repos to include for where to look for packages

```
> cat ~/.config/dotz/config.yaml repos:
repos:
  - name: work
    url: file:~/repos/work/dotfiles
  - name: personal
    url: file:~/repos/personal/dotfiles
  - name: personal
    url: https://github.com/example-user/dotfiles.git
packages:
  - chezmoi==^0.8.1
  - ecw-shell==^0.113.4
  - personal:yq==^0.4.2
```

## CLI design

Rough output of `dotz help`:

```bash
NAME:
  dotz - dotfiles package manager

COMMANDS
  config  - manage configuration
  add     - add a package or packages
  remove  - remove a package or packages
  install - install package
  fetch   - fetch a list of packages.  Mainly used updating packages
  search  - search for packages
```

Rough output of `dotz help config`:

```bash
COMMANDS
  edit   - open config in $EDITOR
  set    - set a configuration variable
  get    - get a configuration variable
  yq     - wrapper around yq with the config file
```

Rough output of `dotz install`:

```bash
NAME
  install - install packages
DESCRIPTION
  Installs a list of packages. If there is no arguments packages found in the configuration are installed. Packages passed through the command line will install the package and either update or add a package to the config file
```

## Architecture

Add and removing a package will respectably add or remove the packages from the config file

When installing a packages are vendored into a state directory. A vendored copy either consists of symbolically linking the package or a copy of the contents tracked by a git tag. This could be implemented using the `git archive` feature that is part of `git`. Once all packages are vendored the install.sh file will be called in all packages.
