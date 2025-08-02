# Trick: Embedding version information in go binaries

Handy trick in [go](../1085) that I found while looking through the source code of [mods] to embed version information. It uses [cobra].

[mods]: https://github.com/charmbracelet/mods

```go
// Build vars.
var (
	//nolint: gochecknoglobals
	Version   = ""
	CommitSHA = ""
)

func buildVersion() {
	if len(CommitSHA) >= sha1short {
		vt := rootCmd.VersionTemplate()
		rootCmd.SetVersionTemplate(vt[:len(vt)-1] + " (" + CommitSHA[0:7] + ")\n")
	}
	if Version == "" {
		if info, ok := debug.ReadBuildInfo(); ok && info.Main.Sum != "" {
			Version = info.Main.Version
		} else {
			Version = "unknown (built from source)"
		}
	}
	rootCmd.Version = Version
}
```
