# How to setup tailwind for WordPress

Tailwind is a way to do utilize utility CSS to allowing for co-locating
CSS within html files. This is also called utility based CSS. This
setup is taken from [css tricks].

In your theme run the following. You may need to initialize a
`package.json` with `pnpm init`.

```bash
pnpm i -D tailwindcss
pnpx tailwind css
```

Create `tailwind.css` with the following content

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Add a script in `package.json` to have the value `tailwindcss -i
./tailwind.css -o ./style.css --watch`.

[css tricks]: https://css-tricks.com/adding-tailwind-css-to-wordpress-themes/

    tags: #wordpress #php #css #programming
