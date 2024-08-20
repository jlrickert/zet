# Opinionated way to to organize application data

Typically, there are 4 locations: data, config, state, and cache. Data refers to application data that may be shared between systems. State is machine-specific data, such as logs. Cache is non-essential data that is also machine-specific. Configuration encompasses user settings for the application. Typically, configuration cascades from the distribution down to the user level.

In summary:

- data: Non configuration application data. Safe to synchronize.
- state: Machine specific local state of application. Not safe to synchronize.
- config: Configuration synchronized between systems
- cache: Non essentials data. Typically, performance related.

## Distribution

- data:
  - Linux: `/usr/share/ApplicationName`
  - Windows: `C:\ProgramData\ApplicationName`
  - macOS: `/Library/ApplicationName/ApplicationName`
- config:
  - Linux: `/etc`
  - Windows: `C:\ProgramData\ApplicationName\Config`
  - macOS: `/Library/Application Support/ApplicationName/State`
- state:
  - Linux: `/var`
  - Windows: `C:\ProgramData\ApplicationName\State`
  - macOS: `/Library/Application Support/ApplicationName/Config`
- cache:
  - Linux: `/var/cache`
  - Windows: `C:\ProgramData\ApplicationName\Cache`
  - macOS: `/Library/Caches/ApplicationName`

## System

- data:
  - Linux: `/usr/local/share/ApplicationName`
- config:
  - Linux: `/usr/local/etc`
- state:
  - Linux: `/var`
- cache:
  - Linux: `/var/cache`

## User

- data:
  - Linux: `$XDG_DATA_HOME/ApplicationName`
  - Windows: `%APPDATA%\ApplicationName`
  - macOS: `~/Library/ApplicationName/ApplicationName`
- state:
  - Linux: `$XDG_STATE_HOME/ApplicationName`
  - macOS: `~/Library/Application Support/ApplicationName/State`
  - Windows: `%LOCALAPPDATA%\ApplicationName\State`
- config:
  - Linux: `$XDG_CONFIG_HOME/ApplicationName`
  - Windows: `%APPDATA%\ApplicationName\Config`
  - macOS: `~/Library/Application Support/ApplicationName/Config`
- cache:
  - Linux: `$XDG_CACHE_HOME/ApplicationName`
  - Windows: `%LOCALAPPDATA%\ApplicationName\Cache`
  - macOS: `~/Library/Caches/ApplicationName`

## See also

- [Unix based program configuration](../323)
