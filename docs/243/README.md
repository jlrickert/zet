# How to create a new category for blocks

When creating a new block it belongs to a category. It may only be registed to
an available category. If the category doesn't exist it will be set to the
uncategorized category.

Some reasons that you may want to create a new category is to have blocks be
found under an organizations own category.

Here are the default categories

- design
- uncategorized

## Facts

- In `block.json` category needs to be set to a valid category

```php
function my_block_plugin_block_init()
{
    register_block_type(__DIR__ . '/build/blocks', array());
    add_filter('block_categories_all', function ($categories) {
        return array_merge(
            array(
                array(
                    'slug' => 'org',
                    'title' => __('My organization', 'my-plug')
                )
            ),
            $categories
        );
    });
}
add_action('init', 'my_plugin_block_init');
```

    tags: #php #wordpress
