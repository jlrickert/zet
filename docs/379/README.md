# Dynamic themes in sveltekit

Here is an example configuration in `tailwind.config.js` file.

```js
/** @type {import('tailwindcss').Config} */
export default {
  content: ["./src/**/*.{html,js,svelte,ts}"],
  theme: {
    extend: {},
    colors: {
      primary: "var(--color-primary, red)",
      secondary: "var(--color-secondary, green)",
      tertiary: "var(--color-tertiary, blue)",
    },
  },
  plugins: [],
};
```

Somewhere in your `+layout.svelte` file:

```svelte
<script lang="ts">
  let primary-color = "green";
  let secondary-color = "blue";
  let tertiary-color = "red";
</script>
<div style={`
    --color-primary: ${primary-color};
    --color-secondary: ${secondary-color};
    --color-tertiary: ${tertiary-color};
  `}>
  <slot />
</div>
```

If any of the color variables change the colors will also change.

Warning: I haven't ran the code example above. I have the color variables in a
writeable.

    tags: #svelte #webDev
