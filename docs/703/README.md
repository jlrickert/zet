# Example fly out navigation menu in website development

An [example] may be found on the w3.org website

This type of menu have the following structure

```html
<nav aria-labelledby="menulabel" class="menu has-submenu closed">
  <h2 id="aria-labelledby" classname="hidden">Some text about the menu</h2>
  <ul>
    <li></li>
    <li><a href=aria-current="page">Some text</a></li>
    <li></li>
    ...
  </ul>
</nav
```

For styling each item should have the following things:

- visual and semantic element for current page
- may have indicator for already visited pages

[example]: https://www.w3.org/WAI/tutorials/menus/flyout/
