# Issue: Rounded borders for a table header

`border-radius` doesn't work when the display is `table-header-group` or `table-cell`. This is the default value for a `thead` which is the thing that I want to style. Wrapping a `thead` in a div doesn't work as it is not a valid tag with a table. It automatically gets removed in the DOM when you try to add it.

Problems with changing the display to something else (untested):

- Breaks behavior of `rowspan` and `colspan` attributes on `th` tags

See the official [spec] for `thead`.

[spec]: https://html.spec.whatwg.org/multipage/tables.html#the-thead-element

## Example

```html
<table>
  <thead>
    <tr>
      <th rowspan="2">Student ID</th>
      <th colspan="2">Student</th>
      <th rowspan="2">Major</th>
      <th rowspan="2">Credits</th>
    </tr>
    <tr>
      <th>First name</th>
      <th>Last name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>3741255</td>
      <td>Martha</td>
      <td>Jones</td>
      <td>Computer Science</td>
      <td>240</td>
    </tr>
    <tr>
      <td>3971244</td>
      <td>Victor</td>
      <td>Nim</td>
      <td>Russian Literature</td>
      <td>220</td>
    </tr>
    <tr>
      <td>4100332</td>
      <td>Alexandra</td>
      <td>Petrov</td>
      <td>Astrophysics</td>
      <td>260</td>
    </tr>
  </tbody>
</table>
```

```css
thead {
  display: flex;
  border: 2px solid black;
  border-radius: 20px;
  border-bottom: 2px solid rgb(160 160 160);
  background-color: #2c5e77;
  color: #fff;
}

table {
  border-collapse: collapse;
  border: 2px solid rgb(140 140 140);
  font-family: sans-serif;
  font-size: 0.8rem;
  letter-spacing: 1px;
}

tbody {
  background-color: #e4f0f5;
}

th,
td {
  border: 1px solid rgb(160 160 160);
  padding: 8px 10px;
}

tbody > tr > td:last-of-type {
  text-align: center;
}
```

## Things tried

Styling `th` items directly with borders utilizing the `:last-of-type` and `:first-of-type` [selectors](../538).
