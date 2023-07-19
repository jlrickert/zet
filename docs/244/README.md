# WordPress block editor domain model

The block editor is the piece of software that allows WordPress content managers to be able to build content for their website. By default Page and Post post types are able to be edited.

- Menu

  Menu is a post type that is a list of links

- Category

  A category is a type of block. By default WordPress has be text, media, design, widgets, theme, and embed. Custom categories may be added with `add_filter('block_categories', 'plugin_block_categories', 10, 2)`

- [Post Type]

  Post Type is the type of entry that a content editor may add. By default WordPress comes with Pages, Posts, Attachments, Revisions, Navigation Menus, Custom CSS, and Changesets. Page and Post are shown in the menu on the left side of the admin page. Plugins may add new post types. See [how to add a new post type in WordPress](../245) for more details.

- Query Loop
- Block inserter

  This is the the side bar on the left that you use to add an additional block. An alternative is to click the add inserter button in the block.

- Settings sidebar

  This is the settings that may be edited in the sidebar on the right. The component to look into is the `InspectorControls` component.

- Block toolbar

  This is the toolbar that shows when you select a block. Components relavent to this include `BlockControls`.

- Attributes

[Post Type]: https://wordpress.org/documentation/article/what-is-post-type/

    tags: #wordpress
