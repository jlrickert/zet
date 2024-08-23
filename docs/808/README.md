# Security: possible PHP vulnerability vector

Recently, I discovered a [trick](../797) to make react like reusable components. One things that was interesting was that the `$data` argument was passed down to the file included implicitly.

Here is an example:

```php
<?php

function render_file($file, $message, style = '') {
  include "$name.php";
}

// Maybe some optional style we get from a user somewhere
$raw_style = ...;

echo render_file('example', "Some message", $raw_input);
```

```php
<?php
// in example.php

<?
<div style="<?= $style ?>">"<?= $message ?>"</div>;
```

In `example.php` `$style` will be available for use. In this case `$style` has not been sanitized.