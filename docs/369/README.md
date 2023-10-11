# Dynamic colors with SvelteKit and tailwind

I found a way to do dynamic colors with tailwind and sveltekit.

In your `tailwind.config.js`:

```js
/** @type {import('tailwindcss').Config} */
export default {
  theme: {
    extend: {},
    colors: {
      primary: "var(--color-primary, red)",
      secondary: "var(--color-secondary, blue)",
      tertiary: "var(--color-tertiary, green)",
    },
  },
};
```

In your root `+layout.svelte`:

```svelte
<script lang="ts">
	let primaryColor = '#ff0000';
	let secondaryColor = '#00ff00';
	let tertiaryColor = '#0000ff';

	let rootElement: HTMLDivElement;
	$: rootElement && rootElement.style.setProperty('--color-primary', primaryColor);
	$: rootElement && rootElement.style.setProperty('--color-secondary', secondaryColor);
	$: rootElement && rootElement.style.setProperty('--color-tertiary', tertiaryColor);
</script>


<div bind:this={rootElement}>
	<slot />
</div>

<script>
    :global(:root) {
        --color-primary: red;
        --color-secondary: blue;
        --color-tertiary: green;
    }
</script>
```

## See also

- https://svelte.dev/repl/57f03a5268884c8080b286c95e9a7c52?version=3.38.2
