# Opinionated error handling strategy in Go

Here are two short autocomplete prompts you can paste into an editor/AI
completion tool (plus example completions). Pick the one matching your Go
version.

Notes

- Use a package-level error created with `errors.New(...)` (shown below as
  `PACKAGE_ERR`).
- Function names and the internal operation are intentionally
  generic/placeholders — replace `YourFunc` / `doWork` / `Result` with names and
  concrete logic used in your project.

1. Quick Copilot-style prompt (works for Go 1.13+; wrap a package-level error
   with `%w` so `errors.Is(...)` works):

```text
Generate Go code that declares a package-level error var PACKAGE_ERR = errors.New("package error"), implements a function (e.g., func YourFunc(data []byte) (*Result, error)) which performs an operation and on error returns fmt.Errorf("%w: operation failed: %v", PACKAGE_ERR, err). Also show a caller that handles the returned error with errors.Is(err, PACKAGE_ERR) and prints or handles the underlying cause.
```

Example completion for that prompt:

```go
package example

import (
    "errors"
    "fmt"
)

var PACKAGE_ERR = errors.New("package error")

type Result struct {
    // fields...
}

func YourFunc(data []byte) (*Result, error) {
    var res Result
    if err := doWork(data, &res); err != nil {
        // wrap the package-level error so callers can detect this class of error
        return nil, fmt.Errorf("%w: operation failed: %v", PACKAGE_ERR, err)
    }
    return &res, nil
}

// Caller example
func DoSomething(data []byte) {
    res, err := YourFunc(data)
    if err != nil {
        if errors.Is(err, PACKAGE_ERR) {
            // handle this class of error specifically
            fmt.Println("operation error:", err)
            return
        }
        // other errors
        fmt.Println("other error:", err)
        return
    }
    _ = res
}

// doWork is a placeholder for whatever work you do in your package.
// Replace with concrete logic (e.g., json.Unmarshal, network call, DB op).
func doWork(data []byte, out *Result) error {
    // implementation omitted for example purposes
    return fmt.Errorf("underlying failure")
}
```

2. Copilot-style prompt for Go 1.20+ (use `errors.Join` to preserve both the
   package error and the original error so `errors.Is` can match the package
   error):

```text
Generate Go code that declares a package-level error var PACKAGE_ERR = errors.New("package error"), implements a function (e.g., func YourFunc(data []byte) (*Result, error)) which performs an operation and on error returns fmt.Errorf("operation failed: %w", errors.Join(PACKAGE_ERR, err)). Show a caller that uses errors.Is to check for PACKAGE_ERR as well as handling other errors.
```

Example completion for that prompt:

```go
package example

import (
    "errors"
    "fmt"
)

var PACKAGE_ERR = errors.New("package error")

type Result struct {
    // fields...
}

func YourFunc(data []byte) (*Result, error) {
    var res Result
    if err := doWork(data, &res); err != nil {
        // errors.Join preserves both PACKAGE_ERR and the underlying cause
        return nil, fmt.Errorf("operation failed: %w", errors.Join(PACKAGE_ERR, err))
    }
    return &res, nil
}

// Caller example
func DoSomething(data []byte) {
    res, err := YourFunc(data)
    if err != nil {
        if errors.Is(err, PACKAGE_ERR) {
            // detect the package-level error
            fmt.Println("operation error:", err)
            return
        }
        // other errors
        fmt.Println("other error:", err)
        return
    }
    _ = res
}

// doWork is a placeholder for whatever work you do in your package.
func doWork(data []byte, out *Result) error {
    // implementation omitted for example purposes
    return fmt.Errorf("underlying failure")
}
```
