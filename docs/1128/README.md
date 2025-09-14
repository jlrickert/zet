# Patch: Add logging with Grafana Loki - 2025-09-14

I added centralized logging on my [homelab](../578) on 2025-09-14.

## Notes / considerations

- Web access as at <http://cloud9.int.jlrickert.me:3000/>

## Application server setup

In docker-compose.yml

```yaml
version: "3.3"

networks:
    loki:

services:
    loki:
        image: grafana/loki:latest
        ports:
            - "3100:3100"
        command: -config.file=/etc/loki/local-config.yaml
        networks:
            - loki

    promtail:
        image: grafana/promtail:latest
        volumes:
            - /var/log:/var/log
        command: -config.file=/etc/promtail/config.yml
        networks:
            - loki

    grafana:
        environment:
            - GF_PATHS_PROVISIONING=/etc/grafana/provisioning
            - GF_AUTH_ANONYMOUS_ENABLED=true
            - GF_AUTH_ANONYMOUS_ORG_ROLE=Admin
            - GF_FEATURE_TOGGLES_ENABLE=alertingSimplifiedRouting,alertingQueryAndExpressionsStepMode
        entrypoint:
            - sh
            - -euc
            - |
                  mkdir -p /etc/grafana/provisioning/datasources
                  cat <<EOF > /etc/grafana/provisioning/datasources/ds.yaml
                  apiVersion: 1
                  datasources:
                  - name: Loki
                    type: loki
                    access: proxy
                    orgId: 1
                    url: http://loki:3100
                    basicAuth: false
                    isDefault: true
                    version: 1
                    editable: false
                  EOF
                  /run.sh
        image: grafana/grafana:latest
        ports:
            - "3000:3000"
        networks:
            - loki
```

In `loki-config.yml`

```yaml
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096
  log_level: debug
  grpc_server_max_concurrent_streams: 1000

common:
  instance_addr: 127.0.0.1
  path_prefix: /tmp/loki
  storage:
    filesystem:
      chunks_directory: /tmp/loki/chunks
      rules_directory: /tmp/loki/rules
  replication_factor: 1
  ring:
    kvstore:
      store: inmemory

query_range:
  results_cache:
    cache:
      embedded_cache:
        enabled: true
        max_size_mb: 100

limits_config:
  metric_aggregation_enabled: true

schema_config:
  configs:
    - from: 2020-10-24
      store: tsdb
      object_store: filesystem
      schema: v13
      index:
        prefix: index_
        period: 24h

pattern_ingester:
  enabled: true
  metric_aggregation:
    loki_address: localhost:3100

ruler:
  alertmanager_url: http://localhost:9093

frontend:
  encoding: protobuf

# By default, Loki will send anonymous, but uniquely-identifiable usage and configuration
# analytics to Grafana Labs. These statistics are sent to https://stats.grafana.org/
#
# Statistics help us better understand how Loki is used, and they show us performance
# levels for most users. This helps us prioritize features and documentation.
# For more information on what's sent, look at
# https://github.com/grafana/loki/blob/main/pkg/analytics/stats.go
# Refer to the buildReport method to see what goes into a report.
#
# If you would like to disable reporting, uncomment the following lines:
analytics:
  reporting_enabled: false
jlrickert@cloud9:~/grafana$ cat loki-config.yml
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096
  log_level: debug
  grpc_server_max_concurrent_streams: 1000

common:
  instance_addr: 127.0.0.1
  path_prefix: /tmp/loki
  storage:
    filesystem:
      chunks_directory: /tmp/loki/chunks
      rules_directory: /tmp/loki/rules
  replication_factor: 1
  ring:
    kvstore:
      store: inmemory

query_range:
  results_cache:
    cache:
      embedded_cache:
        enabled: true
        max_size_mb: 100

limits_config:
  metric_aggregation_enabled: true

schema_config:
  configs:
    - from: 2020-10-24
      store: tsdb
      object_store: filesystem
      schema: v13
      index:
        prefix: index_
        period: 24h

pattern_ingester:
  enabled: true
  metric_aggregation:
    loki_address: localhost:3100

ruler:
  alertmanager_url: http://localhost:9093

frontend:
  encoding: protobuf

# By default, Loki will send anonymous, but uniquely-identifiable usage and configuration
# analytics to Grafana Labs. These statistics are sent to https://stats.grafana.org/
#
# Statistics help us better understand how Loki is used, and they show us performance
# levels for most users. This helps us prioritize features and documentation.
# For more information on what's sent, look at
# https://github.com/grafana/loki/blob/main/pkg/analytics/stats.go
# Refer to the buildReport method to see what goes into a report.
#
# If you would like to disable reporting, uncomment the following lines:
analytics:
  reporting_enabled: false
```

In `promtail-config.yml`

```yaml
server:
    http_listen_port: 9080
    grpc_listen_port: 0

positions:
    filename: /tmp/positions.yaml

clients:
    - url: http://loki:3100/loki/api/v1/push

scrape_configs:
    - job_name: system
      static_configs:
          - targets:
                - localhost
            labels:
                job: varlogs
                __path__: /var/log/*log
```

In `/etc/systemd/system/grafana.service`:

```config
[Unit]
Description=Grafana Docker Compose
Requires=docker.service
After=docker.service network-online.target
Wants=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/jlrickert/grafana
ExecStart=/usr/bin/docker compose up -d
ExecStop=/usr/bin/docker compose down
TimeoutStartSec=120
TimeoutStopSec=60

[Install]
WantedBy=multi-user.target
```

Create the files and run the following

```bash
sudo systemctl daemon-reload
sudo systemctl enable grafana.service
sudo systemctl start grafana.service
```

### Log forwarding on MacOSX

I forward a bunch of logs from my [mac](../583)

#### Installation

Followed [installation docs][docs-install]

```bash
brew tap grafana/grafana
brew install grafana/grafana/alloy
```

### Configuration

Followed [configuration docs][docs-configure] to configure.

Configuration build loop is as follows:

```bash
ed /opt/homebrew/etc/ally/config.alloy # edit config
brew services restart grafana/grafana/alloy
```

Debug logs may be followed with `tail -f $(brew --prefix)/var/log/alloy.err.log`

Configuration in `/opt/homebrew/etc/alloy/config.alloy`

```hcl
logging {
  level = "debug"
  format = "logfmt"
}

livedebugging {
  enabled = true
}

local.file_match "local_files" {
  path_targets = [
    {
      "__path__" = "/Users/jlrickert/.local/state/github-mcp-server/log.json",
      "service" = "github-mcp-server",
      "hostname" = constants.hostname,
    },
    {
      "__path__" = "/Users/jlrickert/.local/state/mcpfs/log.json",
      "service" = "fileserver-mcp-server",
      "hostname" = constants.hostname,
    },
  ]
  sync_period  = "5s"
}

loki.source.file "log_scrape" {
  targets    = local.file_match.local_files.targets
  forward_to = [loki.write.local.receiver]
  tail_from_end = true
}

loki.write "local" {
  endpoint {
    url = "http://cloud9.int.jlrickert.me:3100/loki/api/v1/push"
  }
}
```

The following is also mentioned but doesn't seem to do anything

```bash
brew edit grafana/grafana/alloy # doesn't seem to work
brew reinstall --formula  grafana/grafana/alloy
brew services restart  grafana/grafana/alloy
```

[docs-install]: https://grafana.com/docs/alloy/latest/set-up/install/macos/
[docs-configure]: https://grafana.com/docs/alloy/latest/configure/macos/

## Time log

- 2025-09-13 18:00 (2.00h) Setup Grafana and Loki Setup this up while co working
  with [msptech](../762) so not the most productive
- 2025-09-14 12:57 (1.00h) Figured out a working example

---

References

- <https://grafana.com/docs/alloy/latest/reference/components/local/local.file_match/>
