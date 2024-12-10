# Using environment variables to populate YAML configurations

To avoid storing sensitive information directly in a YAML configuration file, you can leverage environment variables to dynamically replace placeholders before the file is used. One effective way to achieve this is by piping the contents of the YAML file through `envsubst`. Secret environment variables can be defined in a shell script and sourced before processing the YAML file.

## Example

This proof of concept demonstrates the approach:

```yaml
# config.yaml
username: ${USER_NAME}
password: ${USER_PASSWORD}
```

```bash
# secrets.sh
export USER_NAME=myusername
export USER_PASSWORD=mypassword
```

```bash
# Usage in a script
source secrets.sh
cat config.yaml | envsubst | yq '.'
```
