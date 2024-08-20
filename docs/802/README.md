# SPEC: Data organization in Knutjs

High level details on how [Knutjs](../609) will organize its data. I intent to following an [opinionated](../801) way which I believe is best practice.

Configuration for Knut will be in `~/.config/knut/config.yaml` or `~/.config/knut/json.yaml` on Linux or MacOSX if `XDG` variables are set.

Here are the default locations

| Key    | Windows                     | Linux                   | Macosx                                      |
| ------ | --------------------------- | ----------------------- | ------------------------------------------- |
| Data   | `%APPDATA%\knut`            | `$XDG_DATA_HOME/knut`   | `~/Library/knut/knut`                       |
| State  | `%LOCALAPPDATA%\knut\State` | `$XDG_STATE_HOME/knut`  | `~/Library/Application Support/knut/State`  |
| Config | `%APPDATA%\knut\Config`     | `$XDG_CONFIG_HOME/knut` | `~/Library/Application Support/knut/Config` |
| Cache  | `%LOCALAPPDATA%\knut\Cache` | `$XDG_CACHE_HOME/knut`  | `~/Library/Caches/knut`                     |

If XDG variables do exist they will take precedence.

- Data will contain the kegs
- State will contain logs
- Config will contain the configuration for Knut
- Cache will contain data related to
