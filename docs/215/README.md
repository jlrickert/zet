# Flexbox CSS attributes

There are a few CSS keywords that interacts with an element that has its display set to either `flex` or `inline-flex`.

- The main axis is horizontal (left to right) when `flex-direction` is `row`
- The main axis is vertical (up and down) when `flex-direction` is `column`

The following interacts across the main axis:

- `flex-basis`
- `flex-wrap`
- `flex-shrink`
- `max-width`
- `max-height`
- `min-width`
- `min-height`
- `justify-content`

The following work along the cross axis:

- if `flex-direction` is row (left and right) then height
- if `flex-direction` is column (up and down) then width
- `{min,max}-{width,height}`

The order of flex items may be specified using CSS rather than html by using the `order` property.
