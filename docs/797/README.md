# PHP Trick: react inspired reusable components

Vue, Svelte, and React inspired reusable components for PHP. Would be cool to figure out how to add context to this. 

```php
<?php
function render($name, $data) {
    include 'components/' . $name . '.php';
}

function require(boolean $condition, string $msg) {
  if ($condition) {
    $bt = debug_backtrace();
    $caller = array_shift($bt);
    log(['trace' => $caller, 'message' => $msg]); // custom log function here
    die();
  }
}
```

```php
<?php
// components/example.php

// component argument handling
$data = $data ?? [];
$msg = $data['msg'];

require($msg, "`$msg` is a required parameter");

// Custom logic

$my_message = upcase($msg) . '!';

// Draw html below
?>
<div><?= my_message ?></div>
```

```php
<?php
// General usage
?>

<div>
  <?= render('example', ['msg' => "hellow world"]) ?>
</div>
```

Some other possible improvements include:

- dynamic rendering

- hydration techniques

  Instead of rendering html data would be passed out as JSON or something to be rendered on the client instead.

- context