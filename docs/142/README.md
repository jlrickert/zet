# How to effectively use cp

For copying files things are very straight forward. The basic syntax is one of these:

| Command                              | Outcome                                                   |
| ------------------------------------ | --------------------------------------------------------- |
| `cp -R [...options] dir dir`         | Copy source directory into destination directory          |
| `cp -R [...options] dir/ dir`        | Copy source directory contents into destination directory |
| `cp [...options] file file`          | Copy file to another location                             |
| `cp [...options] file [...file] dir` | Copy over files to a destination directory                |

A trailing _/_ on the source directory will copy the contents to the destination. If not are present then the directory itself will be copied over. Another interesting thing is that `-R` is used over `-r`. Historically, `-r` is what I used. However, `-R` is the correct one to use.

For example `cp -R plugins/css/ themes/example/css`

```
Before
.
├── plugins
│   └── css
│       ├── plug-rtl.css
│       └── plug.css
└─── themes
    └── example
        └── css
            ├── css
            │   ├── plug-rtl.css
            │   └── plug.css
            ├── example.css
            ├── main.css
            ├── plug-rtl.css
            └── plug.css

After
.
├── plugins
│   └── css
│       ├── plug-rtl.css
│       └── plug.css
└─── themes
    └── example
        └── css
            ├── css
            │   ├── plug-rtl.css
            │   └── plug.css
            ├── example.css
            ├── main.css
            ├── plug-rtl.css
            └── plug.css
```

For example `cp -R plugins/css themes/example/css`

```
Before
.
├── plugins
│   └── css
│       ├── plug-rtl.css
│       └── plug.css
└─── themes
    └── example
        └── css
            ├── example.css
            └── main.css

After
.
├── plugins
│   └── css
│       ├── plug-rtl.css
│       └── plug.css
└─── themes
    └── example
        └── css
            ├── css
            │   ├── plug-rtl.css
            │   └── plug.css
            ├── example.css
            └── main.css
```
