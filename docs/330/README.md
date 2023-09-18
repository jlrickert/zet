# Testing in Go

Out of the box go has everything you need to get started with testing.

## File naming and package naming

In go tests are done by having test files in a package right next to the files
they are testing. For example, `math.go` would be tested by a file named.
`math_test.go`. The test files must of `_test` in their name. Having part of
their name associated with another file is optional. Typically, `math.go` will
be part of a package. We will call this package `my_math`. The type of test may
be selected based on the name of the package that test file is apart of. For
white box testing the package name in the test file needs to be the same as
file within the package. For example, `math.go` and `math_test.go` will have
the package name `my_math`. This is done with `package my_math` typically near
the top of the file. For black box testing append `_test` to the name of the
package in the test files.

- White box example

  ```go
  // math.go
  package math
  ...
  ```

  ```go
  // math_test.go
  package math
  ...
  ```

- Black box example

  ```go
  // math.go
  package math
  ...
  ```

  ```go
  package math_test
  // math
  package math_test
  ...
  ```

It is possible to have a the last example behave like the first by using
`import . math` syntax. This prevents cyclical shenanigans.

- [ ] TODO: verify cylcical shenanigans with `. import` synxax with tests.

By conventions typically each file will have an associated test file.

## Unit tests (WIP)

Unit tests functions start with _Test_. Example based tests start with _Example_.

## Test runners

Running the tests in go is relatively straight foreword. It is as simple as
running `go ./...` to run all the tests.

## Meta

    tags: #golang
