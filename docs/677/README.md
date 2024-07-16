# Techniques for handling scrolling

[Website development](../657) trick to show the basics for handling scrolling.

Example snippet for making content scrollable:

```html
<div class="container">
  <div class="content">...</div>
</div>
```

```css
.container {
  max-height: 300px;
  overflow: auto;
}

.content {
  height: 1000px;
}
```
