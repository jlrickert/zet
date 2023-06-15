# Overview of a block theme in WordPress

A block theme is the newer and recommended way to get started when
building out a theme for WordPress. Classic theme should be used when
the site gets really complicated (this is an assumption that needs to be
verified). A fresh WordPress install will have 2 example block themes to
use for [reference]: `twentytwentytwo`, and `twentytwentythree`. An
interesting thing to note is that the names are based on the year they
where created.

[reference]: https://developer.wordpress.org/themes/getting-started/theme-development-examples/

To get started the only 2 files that need to exist are `index.html` and
`style.css`.

| File                | Purpose |
| ------------------- | ------- |
| `patterns/*`        |         |
| `parts/footer.html` |         |

Common [Page templates]

| File                                | Description                                                   |
| ----------------------------------- | ------------------------------------------------------------- |
| `templates/front-page.html`         | Front page to display at `/`.                                 |
| `templates/home.html`               | Front page for the blog at `/blog/`. This shows latest posts. |
| `templates/page.html`               | Individual Page to display.                                   |
| `templates/404.html`                | Page to display when content is not found.                    |
| `templates/archive.html`            | List of posts to display                                      |
| `templates/singular.html`           | Used when `page.html` or `single.html` is not found           |
| `templates/single.html`             | Post template to use when a single post is requested          |
| `templates/single-{post-type}.html` | Post template to use when a single post is requested.         |

Common [post types]

- Post (Post Type: `post`)
- Page (Post Type: `page`)
- Attachment (Post Type: `attachment`)
- Revision (Post Type: `revision`)
- Navigation menu (Post Type: `nav_menu_item`)
- Block templates (Post Type: `wp_template`)
- Template parts (Post Type: `wp_template_part`)

[Page templates]: https://developer.wordpress.org/themes/basics/template-files/#common-wordpress-template-files
[post types]: https://developer.wordpress.org/themes/basics/post-types/#default-post-types

Parts (also known as partials) are smaller pieces that may be part of a
template.

| File            | Description                           |
| --------------- | ------------------------------------- |
| `parts/header`  | Sites header. This is a special case  |
| `parts/footer`  | Sites footer. This is a special case  |
| `parts/sidebar` | Sites sidebar. This is a special case |

Styling is done with `style.css`. It is required and contains
information about the theme. By default this is not included the
website.

Another optional CSS file is `rtl.css`. WordPress automatically
includes if the languages direction is right to left.

[docs]: https://developer.wordpress.org/themes/

    tags: #wordpress #programming #webdev
