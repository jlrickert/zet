# Trick: YAML based config management in Golang

The general strategy for managing configs in this codebase can be summarized as follows:

1. Versioned Configuration Structures:

   - The configuration format supports multiple versions.
   - Version 1 (ConfigV1) would be an initial version
   - Version 2 (ConfigV2) would be an updated version
   - Previous versions should be automatically migrated to an updated version
   - An alias of the latest config should be set the newest types

2. Conversion and Parsing:

   - When loading config data, the version is first detected by unmarshaling into a map.
   - Based on the version, the data is unmarshaled into the appropriate struct (ConfigV1 or ConfigV2).
   - ConfigV1 can be converted to ConfigV2 via a conversion method that restructures environment data into the new format.
   - Unknown versions result in an error.

3. Loading Configuration from Files:

   - Configuration is loaded from a default location or a specified file path.
   - Functions exist to get the default config directory based on OS conventions (Unix-like or Windows).
   - Reading configuration returns raw file data, and parsing converts it into structured Config.
   - Errors are handled if files do not exist or if parsing fails.

4. Environment Variable Expansion:

   - Configuration strings and slices are recursively expanded with OS environment variables to support dynamic values.

5. Serialization:
   - Options to marshal current config back to YAML format are provided for inspection or saving.

## Examples

A general strategy for managing configs involves several key points:

1. Flexible Versioning: Support multiple config versions for backward compatibility and easy migration.
2. Structured Config Models: Define clear, typed structs representing config schema for versions.
3. Load and Parse: Implement reading config files from default/user-specified paths, and parsing YAML/JSON.
4. Conversion: Provide functions to convert old config versions to newer ones.
5. Accessors: Methods to retrieve projects, environments, or specific config values in a convenient way.
6. Environment Expansion: Support expanding environment variables in config strings.
7. Serialization: Ability to marshal config structs back to YAML/JSON.
8. Defaults and Fallbacks: Use sensible defaults if config values are missing.

Below are is an illustrative example from my [tapper](../0) project demonstrating key aspects of the configuration management strategy:

```gitdiff
commit cf162e41c57851f7ba7872abb69ffe9340050d2f
Author: Jared Rickert <jaredrickert52@gmail.com>
Date:   Mon Aug 4 18:19:06 2025 -0500

    feat: add versioned KEG config management with env var expansion

    - Introduce ConfigV1 and ConfigV2 structs for KEG configuration versions
    - Implement parsing and conversion from V1 to V2 with version detection
    - Add recursive environment variable expansion for config fields and
      links
    - Provide unit tests for parsing, version handling, and env expansion
    - Add utility functions for config directory paths on different OSes
    - Initialize go.mod with yaml.v3 dependency for YAML parsing

diff --git a/go.mod b/go.mod
new file mode 100644
index 0000000..99b674b
--- /dev/null
+++ b/go.mod
@@ -0,0 +1,6 @@
+module github.com/jlrickert/tapper
+
+go 1.24.5
+
+require gopkg.in/yaml.v3 v3.0.1
+
diff --git a/go.sum b/go.sum
new file mode 100644
index 0000000..4bc0337
--- /dev/null
+++ b/go.sum
@@ -0,0 +1,3 @@
+gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod h1:Co6ibVJAznAaIkqp8huTwlJQCZ016jof/cbN4VW5Yz0=
+gopkg.in/yaml.v3 v3.0.1 h1:fxVm/GzAzEWqLHuvctI91KS9hhNmmWOoWu0XTYJS7CA=
+gopkg.in/yaml.v3 v3.0.1/go.mod h1:K4uyk7z7BCEPqu6E+C64Yfv1cQ7kz7rIZviUmN+EgEM=
diff --git a/pkg/keg/config.go b/pkg/keg/config.go
new file mode 100644
index 0000000..bd95a33
--- /dev/null
+++ b/pkg/keg/config.go
@@ -0,0 +1,182 @@
+package keg
+
+// Package config provides versioned configuration management for the KEG application.
+// It supports loading, parsing, converting, and accessing configuration data with
+// environment variable expansion and version migration.
+
+import (
+	"fmt"
+	"os"
+	"reflect"
+
+	"gopkg.in/yaml.v3"
+)
+
+const (
+	ConfigV1VersionString = "2023-01"
+	ConfigV2VersionString = "2025-07"
+)
+
+// ConfigV1 represents the initial version of the KEG configuration specification.
+type ConfigV1 struct {
+	// Kegv is the version of the specification.
+	Kegv string `yaml:"kegv"`
+
+	// Updated indicates when the keg was last indexed.
+	Updated string `yaml:"updated,omitempty"`
+
+	// Title is the title of the KEG worklog or project.
+	Title string `yaml:"title,omitempty"`
+
+	// URL is the main URL where the KEG can be found.
+	URL string `yaml:"url,omitempty"`
+
+	// Creator is the URL or identifier of the creator of the KEG.
+	Creator string `yaml:"creator,omitempty"`
+
+	// State indicates the current state of the KEG (e.g., living, archived).
+	State string `yaml:"state,omitempty"`
+
+	// Summary provides a brief description or summary of the KEG content.
+	Summary string `yaml:"summary,omitempty"`
+
+	// Indexes is a list of index entries that link to related files or nodes.
+	Indexes []IndexEntry `yaml:"indexes,omitempty"`
+}
+
+// ConfigV1 represents the initial version of the KEG configuration specification.
+type ConfigV2 struct {
+	// Kegv is the version of the specification.
+	Kegv string `yaml:"kegv"`
+
+	// Updated indicates when the keg was last indexed.
+	Updated string `yaml:"updated,omitempty"`
+
+	// Title is the title of the KEG worklog or project.
+	Title string `yaml:"title,omitempty"`
+
+	// URL is the main URL where the KEG can be found.
+	URL string `yaml:"url,omitempty"`
+
+	// Creator is the URL or identifier of the creator of the KEG.
+	Creator string `yaml:"creator,omitempty"`
+
+	// State indicates the current state of the KEG (e.g., living, archived).
+	State string `yaml:"state,omitempty"`
+
+	// Summary provides a brief description or summary of the KEG content.
+	Summary string `yaml:"summary,omitempty"`
+
+	// Links holds a list of LinkEntry objects representing related links or references in the configuration.
+	Links []LinkEntry `yaml:"links,omitempty"`
+
+	// Indexes is a list of index entries that link to related files or nodes.
+	Indexes []IndexEntry `yaml:"indexes,omitempty"`
+}
+
+type LinkEntry struct {
+	Alias string `json:"alias"` // Alias for the link
+	URL   string `json:"url"`   // URL of the link
+}
+
+type IndexEntry struct {
+	File    string `yaml:"file"`
+	Summary string `yaml:"summary"`
+}
+
+// Since there is no version 2 yet, ConfigV1 is the latest version
+type Config = ConfigV2
+
+func (c *ConfigV1) toV2() ConfigV2 {
+	return ConfigV2{
+		Kegv:    ConfigV2VersionString,
+		Updated: c.Updated,
+		Title:   c.Title,
+		URL:     c.URL,
+		Creator: c.Creator,
+		State:   c.State,
+		Summary: c.Summary,
+		Indexes: c.Indexes,
+		Links:   nil, // No links in v1, so empty slice or nil
+	}
+}
+
+// ParseConfigData parses raw YAML config data into the latest Config version.
+func ParseConfigData(data []byte) (Config, error) {
+	var configV2 ConfigV2
+
+	// Detect version by unmarshaling into a generic map
+	var raw map[string]any
+	if err := yaml.Unmarshal(data, &raw); err != nil {
+		return configV2, err
+	}
+
+	// Check for "kegv" version field
+	version, ok := raw["kegv"].(string)
+	if !ok {
+		return configV2, fmt.Errorf("missing or invalid kegv version field")
+	}
+
+	switch version {
+	case ConfigV1VersionString:
+		var configV1 ConfigV1
+		if err := yaml.Unmarshal(data, &configV1); err != nil {
+			return configV2, err
+		}
+		return configV1.toV2(), nil
+	case ConfigV2VersionString:
+		if err := yaml.Unmarshal(data, &configV2); err != nil {
+			return configV2, err
+		}
+	default:
+		return configV2, fmt.Errorf("unsupported config version: %s", version)
+	}
+
+	return configV2, nil
+}
+
+// expandEnvRecursively recursively expands environment variables in strings and string slices.
+func expandEnvRecursively(v reflect.Value) {
+	if !v.IsValid() {
+		return
+	}
+
+	switch v.Kind() {
+	case reflect.Ptr:
+		if !v.IsNil() {
+			expandEnvRecursively(v.Elem())
+		}
+	case reflect.Struct:
+		for i := 0; i < v.NumField(); i++ {
+			field := v.Field(i)
+			if field.CanSet() {
+				expandEnvRecursively(field)
+			}
+		}
+	case reflect.String:
+		if v.CanSet() {
+			expanded := os.ExpandEnv(v.String())
+			v.SetString(expanded)
+		}
+	case reflect.Slice:
+		if v.Type().Elem().Kind() == reflect.String {
+			for i := 0; i < v.Len(); i++ {
+				elem := v.Index(i)
+				if elem.CanSet() {
+					expanded := os.ExpandEnv(elem.String())
+					elem.SetString(expanded)
+				}
+			}
+		}
+	}
+}
+
+// ExpandEnv expands environment variables in the Config fields.
+func (c *Config) ExpandEnv() {
+	expandEnvRecursively(reflect.ValueOf(c).Elem())
+
+	// Additionally, expand environment variables in Links URLs if present
+	for i := range c.Links {
+		c.Links[i].URL = os.ExpandEnv(c.Links[i].URL)
+	}
+}
diff --git a/pkg/keg/config_test.go b/pkg/keg/config_test.go
new file mode 100644
index 0000000..1469198
--- /dev/null
+++ b/pkg/keg/config_test.go
@@ -0,0 +1,149 @@
+package keg
+
+import (
+	"os"
+	"testing"
+)
+
+func TestParseConfigDataV1(t *testing.T) {
+	v1Yaml := `
+kegv: "2023-01"
+updated: "2023-01-01"
+title: "Test KEG V1"
+url: "https://example.com"
+creator: "creator-id"
+state: "living"
+summary: "This is a test KEG V1 config"
+indexes:
+  - file: "index1.md"
+    summary: "Index 1 summary"
+  - file: "index2.md"
+    summary: "Index 2 summary"
+`
+
+	config, err := ParseConfigData([]byte(v1Yaml))
+	if err != nil {
+		t.Fatalf("ParseConfigData failed: %v", err)
+	}
+
+	if config.Kegv != ConfigV2VersionString {
+		t.Errorf("Expected Kegv to be %s, got %s", ConfigV2VersionString, config.Kegv)
+	}
+	if config.Title != "Test KEG V1" {
+		t.Errorf("Expected Title to be 'Test KEG V1', got %s", config.Title)
+	}
+	if len(config.Indexes) != 2 {
+		t.Errorf("Expected 2 indexes, got %d", len(config.Indexes))
+	}
+	if len(config.Links) != 0 {
+		t.Errorf("Expected Links to be nil or empty, got %v", config.Links)
+	}
+}
+
+func TestParseConfigDataV2(t *testing.T) {
+	v2Yaml := `
+kegv: "2025-07"
+updated: "2025-07-01"
+title: "Test KEG V2"
+url: "https://example.com/v2"
+creator: "creator-v2"
+state: "archived"
+summary: "This is a test KEG V2 config"
+links:
+  - alias: "home"
+    url: "https://home.example.com"
+  - alias: "docs"
+    url: "https://docs.example.com"
+indexes:
+  - file: "index1.md"
+    summary: "Index 1 summary"
+`
+
+	config, err := ParseConfigData([]byte(v2Yaml))
+	if err != nil {
+		t.Fatalf("ParseConfigData failed: %v", err)
+	}
+
+	if config.Kegv != ConfigV2VersionString {
+		t.Errorf("Expected Kegv to be %s, got %s", ConfigV2VersionString, config.Kegv)
+	}
+	if config.Title != "Test KEG V2" {
+		t.Errorf("Expected Title to be 'Test KEG V2', got %s", config.Title)
+	}
+	if len(config.Links) != 2 {
+		t.Errorf("Expected 2 links, got %d", len(config.Links))
+	}
+	if len(config.Indexes) != 1 {
+		t.Errorf("Expected 1 index, got %d", len(config.Indexes))
+	}
+}
+
+func TestExpandEnv(t *testing.T) {
+	os.Setenv("TEST_TITLE", "EnvTitle")
+	os.Setenv("TEST_URL", "https://env.url")
+
+	config := Config{
+		Kegv:    ConfigV2VersionString,
+		Title:   "${TEST_TITLE}",
+		URL:     "${TEST_URL}",
+		Creator: "creator",
+		State:   "living",
+		Summary: "summary",
+		Links: []LinkEntry{
+			{Alias: "alias1", URL: "${TEST_URL}"},
+		},
+		Indexes: []IndexEntry{
+			{File: "file1.md", Summary: "summary1"},
+		},
+	}
+
+	config.ExpandEnv()
+
+	if config.Title != "EnvTitle" {
+		t.Errorf("Expected Title to be 'EnvTitle', got %s", config.Title)
+	}
+	if config.URL != "https://env.url" {
+		t.Errorf("Expected URL to be 'https://env.url', got %s", config.URL)
+	}
+	if config.Links[0].URL != "https://env.url" {
+		t.Errorf("Expected Links[0].URL to be 'https://env.url', got %s", config.Links[0].URL)
+	}
+}
+
+func TestExpandEnvPartial(t *testing.T) {
+	os.Setenv("PARTIAL", "partial_value")
+
+	config := Config{
+		Kegv:  ConfigV2VersionString,
+		Title: "Title with ${PARTIAL}",
+	}
+
+	config.ExpandEnv()
+
+	if config.Title != "Title with partial_value" {
+		t.Errorf("Expected Title to be 'Title with partial_value', got %s", config.Title)
+	}
+}
+
+func TestParseConfigDataInvalidVersion(t *testing.T) {
+	invalidYaml := `
+kegv: "invalid-version"
+title: "Invalid version test"
+`
+
+	_, err := ParseConfigData([]byte(invalidYaml))
+	if err == nil {
+		t.Fatal("Expected error for unsupported config version, got nil")
+	}
+}
+
+func TestParseConfigDataMissingVersion(t *testing.T) {
+	missingVersionYaml := `
+title: "Missing version test"
+`
+
+	_, err := ParseConfigData([]byte(missingVersionYaml))
+	if err == nil {
+		t.Fatal("Expected error for missing version field, got nil")
+	}
+}
diff --git a/pkg/keg/keg.go b/pkg/keg/keg.go
new file mode 100644
index 0000000..fb5477d
--- /dev/null
+++ b/pkg/keg/keg.go
@@ -0,0 +1 @@
+package keg
```
