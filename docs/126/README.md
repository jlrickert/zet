# Golang development loop with multi repos

Version 1.18 of [go](../1085) has workspace feature. This allows using a `go.work` file to use override the location of the source of dependencies.

- Create a repo
- Create a module
- Include dependencies

Files related to the project

- `go.work`
- `go.mod`

- Create a new project with

  `go.mod init domain.com/name`

- Fetch all dependencies

  `go get .`

## Tutorial dump

The tutorial runs everything relative to a workspace `directory`.

Files and their contents once everything has been modified.

- `hello/hello.go`

  ```go
  package main

  import (
      "fmt"

      "golang.org/x/example/hello/reverse"
  )

  func main() {
      fmt.Println(reverse.String("Hello"))
  }
  ```

- `hello/go.mod` Contains the package name and the `example/hello` dependency.

- `example/go.work` is where the magic happens

  ```go
  go 1.18
  use (
      ./hello
      ./example/hello
  )
  ```

- `example/hello/reverse`

  ```go
  package reverse

  import "strconv"

  // Int returns the decimal reversal of the integer i.
  func Int(i int) int {
      i, _ = strconv.Atoi(String(strconv.Itoa(i)))
      return i
  }
  ```

- `example/go.mod`

  ```go
  module golang.org/x/example/hello
  go 1.19
  ```

One thing that I have figure out is that I am able to change the working directory to `workspace/hello` rather than `workspace`. This is accomplished by modifying the `go.work` file to the following:

```go
go 1.18
use (
    .
    ../example/hello
)
```

Found with this setup is that I can change the root directory that I want to work out of.

## See also

- [Go workspace tutorial](https://go.dev/doc/tutorial/workspaces)
