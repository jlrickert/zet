# Spin up PostgreSQL cluster on k8s

Learned from Rob a way to spin up a [PostgreSQL](../1109) cluster on [k8s](../769) very quickly. This used to not be recommended but now is.

```yaml
---
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: grafana-cnpg
  namespace: grafana
spec:
  instances: 3
  storage:
    #storageClass: dcnas-volumes size: 1Gi bootstrap: initdb:
    database: grafana
    owner: admin
    secret:
      name: grafana-db-creds
```

---

Related:

See [YAML notes](../900)
