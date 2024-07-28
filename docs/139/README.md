# How to setup bbPress forums in WordPress

Word press that has a plugin for creating forums. In order to use forums the theme has to have support for it. For more details read the post at bbPress about [theme compatibility]. A default theme that has support is `twentytwentyone`.

To get started copy over `plugins/bbpress/templates/default` to `themes/`

```bash
cp plugins/bbpress/templates/default/bbpress themes/YOUR_THEME/bbpress
cp plugins/bbpress/templates/default/css/ themes/YOUR_THEME/css
cp plugins/bbpress/templates/default/js themes/YOUR_THEME/js
cp plugins/bbpress/templates/default/extras/ themes/YOUR_THEME/
cp plugins/bbpress/templates/default/bbpress-functions.php themes/bbpress-function.php
```

If you don't want `css` and `js` at the root of your theme modify `bbpress-functions.php`

[theme compatibility]: https://codex.bbpress.org/themes/theme-compatibility/
