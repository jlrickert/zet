# WordPress development key concepts

WordPress is a platform originally built to be a blogging platform. Currently, it has expanded to be a generic website builder with a traditional CMS.

Here are the key concepts to learn.

- Core concepts: CMS, Multisite network, plugin, theme.
- Data: database, database table, loop, metadata, query.
- Content types: attachment, category, page, post, post format, post type, tag, taxonomy, term, revision.
- File types: child theme, config file, functions file, include file, stylesheet, template file, template hierarchy, template part.
- Admin tools: Customizer, meta box, navigation menu, options, settings, shortcode, widget.
- Code: action hook, API, class, filter hook, function, object, Object Oriented Programming, property, method, template tag.
- Permissions: capability, role.
- Security: NONCE keys, SALT keys, sanitization, validation.

See the developer [documentation] for a deep dive.

Common development tools

- [wordpressify]

Hosting platforms

- WP Engine
- GoDaddy managed WordPress
- WP Pusher

[wordpressify]: https://www.wordpressify.co/
[documention]: https://developer.wordpress.org/

### Key concepts for plugin development

### Key concepts for theme development

The domain is as follows

- Full site editor

  The Full site editor (FSE) is what the user managing content uses. It is also known as the Gutenberg editor

- block

  A block is an atomic piece that is designed to be composed with other blocks to build up pages, posts, and reusable blocks.

  Some blocks may allow nesting of other blocks, also called InnerBlocks. This allows compositions of blocks create to build up pages, posts, and reusable blocks. This is the items that you use to build things in the FSE. For example, a Group block with a child paragraph block can be used to create a page with colored background and a paragraph in the center of the group. A block has attributes. See the core block [reference] on the documentation for what blocks are available.

  [reference]: https://developer.wordpress.org/block-editor/reference-guides/core-blocks/

- block variant

  A block variant is a predefined set of attributes for a block

- pattern

  A pattern is a template that generates a series of blocks in a particular arrangement. A pattern is not reusable by itself but can be used to make a site specific reusable block. A pattern may be part of a plugin or theme.

- template part

  A part is a theme specific reusable block. Its primary role is to build up templates.

- reusable block

  A reusable block allows for a shared block to be used across the site. This is site specific. A template part may also be thought of as a reusable block that is theme specific.

- theme

  A theme is how the contents are generated. The data built out for a site utilizing the FSE creates and manages data in the database. This is then fed into a theme that then decides how the content is displayed for the user. A theme is managed through code. This means that it may be managed with version control.

- site

  A site is the website that is being built. Typically this is stateful data and is placed in a database. Site data may managed via database migrations and backups.

[key conepts]: https://developer.wordpress.org/block-editor/explanations/architecture/key-concepts/

### Opinionated development setup

See also:

- https://dev.to/ingosteinke/classic-themes-with-block-patterns-in-wordpress-1ncp
