# Jekyll theme **hacker** google analytics issue

The theme **[hacker]** is a theme that hasn't been touch in over a year. This is when the deprecated google analytics was still the go to. To migrate the theme to use newer GA4 the file `_includes/head-custom-google-analytics.html` may be overridden.

Create the file with the following content:

```js
{% if site.google_analytics %}
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id={{ site.google_analytics }}"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', '{{ site.google_analytics }}');
</script>
{% endif %}
```

This is an open [issue] on the [hacker] theme.

[hacker]: https://github.com/pages-themes/hacker
[issue]: https://github.com/pages-themes/hacker/issues/144
