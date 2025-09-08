# How to work on a multirepo setup for golang projects

Working on a multirepo set with [go](../1085) is relatively strait forward. In
your project use `go work` to add the current project and relative paths to
other packages on your local filesystem.

Below is an example

```bash
go work init
go work use .
go work use ../go-work
```
