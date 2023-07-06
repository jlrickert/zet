# How to load custom CSS for a WordPress block

This will load the `style.css` file globally.

```php
if (!function_exists('mytheme_styles')) {
    function mytheme_styles()
    {
        // Register theme stylesheet.  This associates mytheme_style with the
        //style sheet ./style.css.
        $theme_version = wp_get_theme()->get('Version');
        $version_string = is_string($theme_version) ? $theme_version : false;
        wp_register_style(
            'mytheme-style',
            get_template_directory_uri() . '/style.css',
            array(),
            $version_string // adds postfix ?ver=x.x to the css file
        );

        // This adds the stylesheet associated with mytheme_style to the website
        wp_enqueue_style('mytheme-style');
    }
}
```

This will load custom CSS for the generated content.

```php
function mytheme_setup() {
	/*
	 * Load additional block styles.
	 */
	$styled_blocks = ['latest-comments'];
	foreach ( $styled_blocks as $block_name ) {
		$args = array(
			'handle' => "mytheme-$block_name",
			'src'    => get_theme_file_uri("assets/css/blocks/$block_name.css"),
			$args['path'] = get_theme_file_path("assets/css/blocks/$block_name.css"),
		);
		wp_enqueue_block_style("core/$block_name", $args);
	}
}
add_action('after_setup_theme', 'mytheme_setup');
```

This will load the styles inline:

```
/**
 * Attach extra styles to multiple blocks.
 * Taken from https://make.wordpress.org/core/2021/07/01/block-styles-loading-enhancements-in-wordpress-5-8/
 */
function mytheme_enqueue_block_styles()
{
    // An array of blocks.
    $styled_blocks = ["paragraph", "navigation"];

    foreach ($styled_blocks as $block_name) {
        // Get the stylesheet handle. This is backwards-compatible and checks the
        // availability of the `wp_should_load_separate_core_block_assets` function,
        // and whether we want to load separate styles per-block or not.
        $handle = (function_exists('wp_should_load_separate_core_block_assets') &&
            wp_should_load_separate_core_block_assets()
        ) ? "wp-block-$block_name" : 'wp-block-library';

        // Get the styles.
        $path = "assets/css/blocks/$block_name.css"
        $styles = file_get_contents(get_theme_file_path($path));

        // Add frontend styles.
        wp_add_inline_style($handle, $styles);

        // Add editor styles.
        add_editor_style($path);
        $editor_path = "assets/css/blocks/$block_name-editor.css"
        if (file_exists(get_theme_file_path($editor_path))) {
            add_editor_style($editor_path);
        }
    }
}
// Add frontend styles.
add_action('wp_enqueue_scripts', 'mytheme_enqueue_block_styles');
// Add editor styles.
add_action('admin_init', 'mytheme_enqueue_block_styles');
```

[reference]: https://developer.wordpress.org/themes/basics/including-css-javascript/#including-css-for-block-styles
