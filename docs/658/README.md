# How to add custom fonts to a website

## Generic fonts

Generic fonts include `serif`, `sans-serif`, `cursive`, `fantasy`, `monospace`.

## Custom fonts

Example using [arial](../659) font. Usually pointless because most OS ship with it already.

```css
@font-face {
  font-family: "Arial";
  src:
    url("fonts/Arial.woff2") format("woff2"),
    url("fonts/Arial.woff") format("woff"),
    url("fonts/Arial.ttf") format("truetype");
  font-weight: normal;
  font-style: normal;
  font-display: block;
}
```

Example usage with sans-serif as the backup

```css
body {
  font-family: "Arial", sans-serif;
}

h1,
p {
  font-family: "Arial", sans-serif;
}
```

## Font formats

- woff2 (recomended)
- woff (oldish)
- ttf (old school compatibility)

## Font weights and styles

### Dynamic fonts

Only need to create 1 font face for different weights and styles. Need to figure out if weight and stretch are implicit.

```css
@font-face {
  font-family: "MyVariableFont";
  src:
    url("fonts/MyVariableFont.woff2") format("woff2"),
    url("fonts/MyVariableFont.woff") format("woff"),
    url("fonts/MyVariableFont.ttf") format("truetype");
  font-weight: 100 900; /* Defines the range of weights */
  font-stretch: 50% 100%; /* Defines the range of widths */
  font-display: swap; /* Optional but recommended */
}
```

Also known as OpenType Font variations.

| Axis Name    | CSS Value |
| ------------ | --------- |
| Weight       | wght      |
| Width        | wdth      |
| Slant        | slnt      |
| Optical Size | opsz      |
| Italics      | ital      |

See googles [variable font docs] for more information.

[variable font docs]: https://fonts.google.com/knowledge/unknown/introducing_variable_fonts

## performance

Research `font-display: swap` and `font-display: block`.

## Performance

- See [improving cls with blocking font loading](../565)
