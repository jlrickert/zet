# Proper way to read user input when using Go

TLDR: Use Scanner

Learned from [robs](../80) stream.

```go
import (
    "os"
    "bufio"
    "log"
)

func main() {
    scanner := bufio.NewScanner(os.Stdin)
    log.Println("Your name?")
    scanner.Scan()
    name := scanner.Text()
    log.Println(`Hi %s` + name)
}
```

## Other things to note

`ReadString` is not cross platform for example.

    tags: #go #cli
