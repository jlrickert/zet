# How to include CSS in a block theme for WordPress

Lets say you want to include the style sheet `custom.css`. It could be
at the root of your theme or in `assets/css/custom.css` This may be
added included with the use of `functions.php`. Add the following:

```php
// functions.php
if (!function_exists('your_theme_setup')) {
    function your_theme_setup()
    {
        // Allows adding custom styles in the block editor
        add_theme_support('wp-block-styles');

        // Allows using the custom.css for previewing in the block
        // editor
        add_editor_style('assets/css/custom.css');
    }
}

add_action('after_setup_theme', 'your_theme_setup');

if (!function_exists('your_theme_styles')) {
    function your_theme_styles()
    {
        // Register theme stylesheet.  This associates your_theme_style with the
        //style sheet ./style.css.
        $theme_version = wp_get_theme()->get('Version');
        $version_string = is_string($theme_version) ? $theme_version : false;
        wp_register_style(
            'your_theme_style',
            get_template_directory_uri() . '/style.css',
            array(),
            $version_string // adds postfix ?ver=x.x to the css file
        );

        // This adds the stylesheet associated with your_theme_style to the website
        wp_enqueue_style('your_theme_style');
    }
}

add_action('wp_enqueue_scripts', 'your_theme_styles');
```

A more fine grained approach is to include block styles.

```php
function myfirsttheme_setup() {
	/*
	 * Load additional block styles.
	 */
	$styled_blocks = ['latest-comments'];
	foreach ( $styled_blocks as $block_name ) {
		$args = array(
			'handle' => "myfirsttheme-$block_name",
			'src'    => get_theme_file_uri( "assets/css/blocks/$block_name.css" ),
			$args['path'] = get_theme_file_path( "assets/css/blocks/$block_name.css" ),
		);
		wp_enqueue_block_style( "core/$block_name", $args );
	}
}
add_action( 'after_setup_theme', 'myfirsttheme_setup' );
```

This is take right from the [documentation].

[documentation]: https://developer.wordpress.org/themes/basics/including-css-javascript/#including-css-for-block-styles

    tags: #wordpress #webdev
