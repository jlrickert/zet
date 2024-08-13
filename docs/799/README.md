# `foreach` mutation weirdness in PHP

Ran into some odd code in a PHP code base. Here is the example with the things in interest:

```php
class Example {
  private $val_array = [];
  public function do_thing() {
    $sorted = [ ... ];
    foreach ($sorted as $this->val_array) {
    }
  }
}
```
