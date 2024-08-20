# Modern software configuration management specification Unix systems

Configuration management for software is a common problem that is encountered. Typically, all configuration values should have some sort of value defined. This means that some defaults would need to be specified. Each configuration can be thought of as a list of pairs of paths and a value that may either be in a config file or a variable file. A config file is typically a config file that save some where in version control. Typically variables are set programmatically.

This is the typical precedence from least to greatest:

- Program defaults

  Program defaults are the hard coded defaults in the program

- System configuration (`/etc/program/program.yaml`)

  System configuration is the configuration that should be used for all users.

- System variables (`/var/program/vars.yaml`)

  This is the system overrides that should be used for all users

- User configuration (`${XDG_CONFIG_HOME}/program/program.yaml`)

  User configuration is the configuration that should be used

- User variables (`${XDG_STATE_HOME}/program/vars.yaml`)
- Environmental variables
- cli parameters
