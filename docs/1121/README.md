# Opinionated way to build cli programs with GO

## Project structure

- cmd/project_name
- pkg/project_name

  Core library for the program

- pkg/project_name/cmd

  Cobra tree

- pkg/other_lib

  Some other library. I often times do monorepo things

## Command tree structure

## Configuration managment

Configuration priorities

- **CLI:** from cli
- **ENV:** from env
- **Local config:** usually in the git repo or cwd
- **User config:** usually in $HOME/.config
- **Global config:** usually from /etc/

## Testing

## Prompt

```markdown
Use the following prompt to drive an “autocomplete / refactor” code generator
(or LLM) so it produces or updates code that follows the patterns and test
fixtures we’ve iterated on. Provide values for the placeholders (PACKAGE_PATH
and PACKAGE_NAME) before running the generator.

High-level intent

- Produce or minimally refactor a small Go package that implements:
  - Cobra-based CLI wiring (root + serve + version commands)
  - Minimal JSON/YAML config loader (no viper)
  - slog-based logging helpers
  - An application type with Run(ctx)
  - A hermetic test fixture for command integration tests that can set env,
    args, stdin, capture stdout/stderr, and create temp config files
- Tests must be deterministic, self-contained, and pass with go test ./...
- Allowed external dependency: github.com/spf13/cobra only and gopkg.in/yaml.v3.
  Everything else must be stdlib (including log/slog).
- If existing files are supplied, treat them as the starting point and refactor
  conservatively (preserve exported APIs where possible). Add only the files or
  edits needed to satisfy the requirements below.

Placeholders to fill before generation

- PACKAGE_PATH — top-level module import path (e.g., github.com/me/myrepo)
- PACKAGE_NAME — package name for non-main files (e.g., myapp). The generator
  should use PACKAGE_NAME at the top of all package files.

Files to produce or update (exact file names)

- cmd/myapp/main.go
- pkg/config.go
- pkg/logging.go
- pkg/app.go
- pkg/cmd/root.go
- pkg/cmd/serve.go (example)
- pkg/cmd/version.go
- pkg/cmd/testutil.go
- pkg/cmd/root_test.go

Strict functional requirements and behaviors

1. Config loader (pkg/config.go)

- Type: Config { LogLevel string `json:"log_level"`; Foo string `json:"foo"` }.
- Function: LoadFromEnvOrFile(path string) (\*Config, error)
  - If path != "" read JSON file into Config (error if file missing/unreadable).
  - Defaults: LogLevel="info", Foo="bar".
  - Override with env vars: LOG_LEVEL or MYAPP_LOG_LEVEL -> LogLevel; FOO or
    MYAPP_FOO -> Foo.
  - Return fully populated Config.

2. Logging (pkg/logging.go)

- Use stdlib log/slog.
- Provide NewLogger(level string) *slog.Logger and NewDiscard() *slog.Logger.
- parseLevel helper should map common strings to slog.Level
  (debug/info/warn/error) and default to info.

3. Application (pkg/app.go)

- Type App with cfg *Config and log *slog.Logger (or minimal wrapper matching
  pattern).
- New(cfg *AppConfig, logger *slog.Logger) \*App where AppConfig { Foo string }
  (or compatible).
- Run(ctx context.Context) error logs running + cfg.Foo and returns nil.

4. Cobra wiring (pkg/cmd/root.go, serve.go, version.go)

- NewRootCmd(cfg *PACKAGE_NAME.Config, logger *slog.Logger) \*cobra.Command:
  - Root must define persistent flags:
    - --config, -c string: optional JSON config file path
    - --log-level, -l string: overrides log level (empty default to detect
      override)
    - --foo string: overrides Foo
  - PersistentPreRunE must:
    - If --config provided, call LoadFromEnvOrFile(path), copy into cfg
      (overwrite fields).
    - Apply --log-level and --foo flag overrides onto cfg (flags take
      precedence).
    - Recreate the application instance using the effective cfg and make it
      available to subcommands.
  - Example subcommands:
    - serve: newServeCmd(app *app.App, logger *slog.Logger) \*cobra.Command
      - Reads a single first line from stdin if present (use cmd.InOrStdin()).
      - If firstLine != "" print "stdin: <firstLine>" to stdout (use
        cmd.OutOrStdout()).
      - Obtain application via appGetter(); if nil return error "application not
        initialized".
      - Call application.Run(ctx) and on success print "started".
    - version: prints effective config:
      - Output exactly: version: 1.0 log_level: <cfg.LogLevel> foo: <cfg.Foo>
      - Use cmd.OutOrStdout() for writing.
  - Root must set default outputs to bytes.Buffer so tests can capture
    (root.SetOut(&bytes.Buffer{}); root.SetErr(&bytes.Buffer{})).

5. Flags precedence & config file override

- Precedence: flags > env vars > config file defaults.
- --config reloads config from the provided path; then other flags still
  override after reload.
- If the file is missing, LoadFromEnvOrFile must return an error and
  PersistentPreRunE should propagate it.

6. Test utilities (pkg/cmd/testhelpers_test.go)

- Provide RunCommand(root \*cobra.Command, env map[string]string, args []string,
  stdin string) (stdout, stderr string, err error)
  - Temporarily set each env var in env map, recording previous values and
    restoring them after run.
  - Set cmd.SetOut and cmd.SetErr to buffers and cmd.SetIn to provided stdin
    (strings.NewReader).
  - Use root.SetArgs(args) and root.ExecuteC() to run command (avoid os.Exit).
  - Return captured stdout/stderr and error.
- Provide a Fixture type with convenience methods:
  - NewFixture(t *testing.T) *Fixture: constructs a fixture with t.TempDir(),
    base config cfg := &Config{LogLevel:"debug", Foo:"test"}, logger :=
    NewDiscard(), root := NewRootCmd(cfg, logger), Env map initialized empty.
    Tests should call defer f.Teardown().
  - (f *Fixture) WithEnv(key, val string) *Fixture to set env for fixture.
  - (f \*Fixture) WithConfigFile(content string) (path string, err error) writes
    content to temp file in fixture TempDir and returns path.
  - (f \*Fixture) Run(args []string, stdin string) (stdout, stderr string, err
    error) — uses RunCommand with fixture.Env merged in.
  - (f \*Fixture) Teardown() — placeholder (no-op is fine).
- Fixture must use t.TempDir() so temporary files are cleaned up.

7. Tests (pkg/cmd/root_test.go)

- Use standard testing package only.
- Use fixture.NewFixture in each test and defer f.Teardown().
- Tests to include (each as a separate TestXxx):
  - TestServeCommand_PrintStarted_NoStdin:
    - f.WithEnv("HOME","/tmp") optionally.
    - stdout, stderr, err := f.Run([]string{"serve"}, "")
    - Assert err==nil and stdout contains "started".
  - TestServeCommand_ReadsStdinAndPrints:
    - stdin := "hello-from-stdin\n"
    - stdout, stderr, err := f.Run([]string{"serve"}, stdin)
    - Assert err==nil and stdout contains "stdin: hello-from-stdin" and
      "started".
  - TestFlagsOverrideConfig:
    - f.Run([]string{"--foo","overridden","--log-level","debug","version"}, "")
    - Assert stdout contains "foo: overridden" and "log_level: debug".
  - TestConfigFlagLoadsFile:
    - cfgPath, \_ := f.WithConfigFile(`{"log_level":"debug","foo":"fromfile"}`)
    - stdout, stderr, err := f.Run([]string{"--config", cfgPath, "version"}, "")
    - Assert stdout contains "foo: fromfile" and "log_level: debug".
- Tests must use only stdlib and cobra (no testify).
- Use t.Fatalf/fatal when assertions fail.

8. Stdin behavior

- Commands must use cmd.InOrStdin() and cmd.OutOrStdout() (not
  os.Stdin/os.Stdout) to allow test harness to inject readers/writers.
- readFirstLine helper should read up to newline and trim trailing
  newline/carriage return characters.

9. Error handling

- Read config file must return a descriptive error when missing/unreadable.
- PersistentPreRunE must return errors from config loading/flag parsing so tests
  can detect them.

10. Style & constraints

- Keep code idiomatic and well-commented.
- Avoid global mutable state; pass cfg and logger into NewRootCmd and into
  app.New.
- Tests must be hermetic: fixture Run must restore env after each invocation.
- Do not add any other external dependencies besides github.com/spf13/cobra.
- Generator must produce only the files listed (no extra files). If refactoring
  existing code, modify only these files.
- Top of each file must use the provided PACKAGE_NAME (or "main" for
  cmd/myapp/main.go).
- Use go:build or other build directives only if necessary.

Autocompletion / refactor behavior (apply when the generator is given existing
code)

- If existing files are present:
  - Parse and analyze them and reuse definitions (struct names, function names)
    when compatible.
  - Preserve exported APIs where possible. When a breaking change is
    unavoidable, document it in comments clearly.
  - Keep existing comments; when replacing a function, include the original
    comment text in the new code (migrating comments).
  - Make minimal non-breaking edits to satisfy the above tests and APIs.
- If there is no existing content, generate complete new implementations for all
  files above.

Output required from the generator

- The final response must contain only the full contents of each file (separated
  by clear file headers or the generator’s normal multi-file output format), and
  must compile and have tests that pass with go test ./... (given placeholder
  PACKAGE_PATH and PACKAGE_NAME are substituted correctly).
- If the generator couldn't implement some requirement, it must explicitly list
  which requirement it could not satisfy and why.

Example minimal scenario (for reference only — generator need not echo this)

- Running TestConfigFlagLoadsFile should create a temp JSON config file, supply
  --config <path>, and version command should print config values from that file
  (and other flags should still override).
```
