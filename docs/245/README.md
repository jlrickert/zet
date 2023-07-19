# How to add a new post type in WordPress

See the [documentation] on `register_post_type` for more information. Here is
an example for registering an event post type.

```php
if (!function_exists('my_plugin_create_events_posttype')) {
    function my_plugin_create_events_posttype()
    {
        register_post_type(
            'events',
            array(
                'labels' => array('name' => __('Events', 'my_plugin'), 'singular_name' => __('Event', 'my_plugin')),
                'public' => true,
                'has_archive' => true,
                'rewrite' => array('slug' => 'movies'),
                'show_in_rest' => true,
                /* 'supports' => array(), */
                'capabilities' => array(),
            ),
        );
    }
}

add_action('init', 'my_plugin_create_events_posttype');
```

This will create an editable

[documentation]: https://developer.wordpress.org/reference/functions/register_post_type/

    tags: #wordpress
