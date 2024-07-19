# Issue: Rounded borders for a table header

`border-radius` doesn't work when the display is `table-header-group`. This is the default value for a `thead` which is the thing that I want to style. Wrapping a `thead` in a div doesn't work as it is not a valid tag with a table. It automatically gets removed in the DOM when you try to add it.

Problems with changing the display to something else (untested):

- Breaks behavior of `rowspan` and `colspan` attributes on `th` tags

See the official [spec] for `thead`.

[spec]: https://html.spec.whatwg.org/multipage/tables.html#the-thead-element
