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

## performance

Research `font-display: swap` and `font-display: block`.

## Performance

- See [improving cls with blocking font loading](../565)
