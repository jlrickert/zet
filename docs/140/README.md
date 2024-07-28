# How to create your own theme in WordPress

On a fresh WordPress install there will be a few example themes to get you started. They are `twentytwentyone`, `twentytwentythree`, and `twentytwentytwo`. There are 2 different types of themes. One is block and the other is classic. `twentytwentyone` is an example of a classic theme while the other 2 are block themes.

Key concepts

- template
- template-part
- block patterns

Minimum required files

- `templates/index.html`
- `style.css`
- `theme.json`

Basic directory structure of `twentytwentyone`

```
.
├── assets (dir)/
│   ├── css (dir)
│   ├── images (dir)
│   └── js (dir)
├── inc (dir)
├── template-parts (dir)/
│   ├── footer (dir)
│   ├── header (dir)
│   ├── navigation (dir)
│   ├── page (dir)
│   └── post (dir)
├── 404.php
├── archive.php
├── comments.php
├── footer.php
├── front-page.php
├── functions.php
├── header.php
├── index.php
├── page.php
├── README.txt
├── rtl.css
├── screenshot.png
├── search.php
├── searchform.php
├── sidebar.php
├── single.php
└── style.css
```

`theme.json` includes CSS variables.
