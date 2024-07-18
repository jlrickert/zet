# Improving CLS with blocking font loading

While working on improving page loading performance I ran into an issue where fonts where cause a large amount of cumulative layout shift. What I discovered was that changing `font-display` to `block` rather than `swap` significantly reduced it. The only downside was that it introduced a 60ms blocking to on the webpage.

Here where my results:

| Value | Performance score | FCP  | LCP  | TBT  | CLS   |
| ----- | ----------------- | ---- | ---- | ---- | ----- |
| block | 87                | 2.1s | 3.6s | 50ms | 0.023 |
| swap  | 76                | 2.4s | 3.6s | 0ms  | 0.217 |

Here is my results when throttling:

| Value | Performance score | FCP  | LCP  | TBT  | CLS   |
| ----- | ----------------- | ---- | ---- | ---- | ----- |
| block | 87                | 2.1s | 3.6s | 50ms | 0.023 |
| swap  | 76                | 2.4s | 3.6s | 0ms  | 0.217 |

This data was gathered using lighthouse on chrome.

For example, with swap there was a 0.023 This was all done using lighthouse and chrome.

This is an entry that I have in my `stylesheet.css` -- the font is a fake font.

```css
@font-face {
  font-family: "Cool Font Text";
  src: url("../fonts/My Cool Font.ttf") format("truetype");
  font-display: block;
}
```

Anything that I discovered was that CSS variables don't seem to work for setting the font-display. I am not sure why that would be the case. Here is an example.

```css
:root {
  --font-display-type: swap;
}
@font-face {
  font-family: "Cool Font Text";
  src: url("../fonts/My Cool Font.ttf") format("truetype");
  font-display: var(--font-display-type);
}
```

This would be more like if the `font-display` is set to block.

## See also

- [How to add custom fonts](../658)