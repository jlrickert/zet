# E2e and Integration testing for go

Optionally run test with flags in [go](../1085). This is useful for end to end test and integration tests. Run into an example when looking at the [code][e2e-code] for [github mcp server](../1092).

```go
//go:build e2e

package e2e_test
```

[e2e-code]: https://github.com/github/github-mcp-server/blob/main/e2e/e2e_test.go
