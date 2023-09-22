# Hugo theme development loop

New hugo version have support for go modules, I am using v0.118.2+extended. This
allows your personal website and the them to be in different repositories. Lets
say for example you have your site and a bunch of themes. Your site is
`github.com/username/personal-website` and your theme is in
`github.com/username/hugo-awesome-theme`. Typically, I will have the 2
repositories in `~/repos/github.com/username`.

- In personal website

  `personal-website/go.mod` Will have something like this.

  ```go
  module github.com/username/personal-website

  go 1.21.1

  require github.com/username/hugo-awesome-theme v0.0.0-20230921164428-3ebbd579323d // indirect
  ```

  `personal-website/go.work` Will have

  ```g
  go 1.21.1

  use .
  use ../hugo-awesome-theme
  ```

- In awesome theme

  `hugo-awesome-theme/go.mod` Will have

Run the server in the `personal-website` directory with the following:

```sh
HUGO_MODULE_WORKSPACE="${PWD}/go.work" hugo server --watch
```

Go is ran from the `workspace` directory.

## See also

- [Golang development loop](../126?T)
- [Golang workspace example](../126)

## Meta

    tags: #golang
