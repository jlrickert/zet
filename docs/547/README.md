# CSS image sizing strategies

- Force image into a box that keeps aspect ratio where

- `object-fit`

## Full width, limited height, OK with image cutoff

Facts:

- Don't know the size of the image.
- Image should be the full width of the viewport
- Image should remain in a good aspect ratio
- Don't care if the image gets cutoff

```html
<div class="container">
  <a><img /></>
  <div class="block.bottomleft"><p>some content</p></div>
</div>
```

```css
.container {
  position: relative;
  width: 100%;
}
.container img {
  width: 100%;
  height: auto;
  max-height: 400px;
  object-fit: cover;
}
.container .block {
  position: absolute;
  padding: 10px
  left: 0;
  top: 0;
}
.container .block.bottomleft {
  top: unset;
  right: unset;
  padding: 5px;
  margin: 5%; /* keeps distance from edges a minimum of 20px */
}
```
