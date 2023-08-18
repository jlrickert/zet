# Pacman cheatsheet and usage patterns

| Command                        | Description                                                             |
| ------------------------------ | ----------------------------------------------------------------------- |
| `pacman -R [...package_name]`  | remove a package(s)                                                     |
| `pacman -S [...package_name]`  | install a package(s)                                                    |
| `pacman -Rs [...package_name]` | remove a package(s) and its dependencies not required by other packages |
| `pacman -Qdtq \| pacman -Rs -` | Auto remove unused dependencies                                         |
| `pacman -Syu`                  | upgrade packages                                                        |
| `pacman -Ss [...package_name]` | search for packages                                                     |
| `pacman -Qs [...package_name]` | search for installed packages                                           |
| `pacman -F [...package_name]`  | search for packages in remote packages                                  |
| `pacman -Qo [package]`         | find what package a file belongs too                                    |
| `pacman -Ql [package]`         | find what files are in a package                                        |
| `pacman -Qo file`              | find package a file a package belongs too                               |
| `pactree ??`                   | list dependencies of a package                                          |
| `pacman -U [package]`          | install a local package                                                 |

## See also

- https://itsfoss.com/pacman-command/
