# Example scan line effect with tailwind

I was working on a making a scan line like effect with tailwind. This is
still a work in progress.  This is an attempt to get an [example] from
CSS tricks ported over.  A few problems that need to be fixed in this
example is the lack of scroll.

[exmpale]:https://css-tricks.com/old-timey-terminal-styling/

In `index.html`

```html
<div
        class="relative font-mono m-o p-4 text-white shadow-gray-400 from-green-800 to-black bg-[radial-gradient(circle_at_center,var(--tw-gradient-stops))] scan-line"
>
        <!-- Content goes here -->
</div>
```

In `tailwind.css`

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer components {
    .scan-line::after {
        @apply content-[''] absolute block pointer-events-none top1 left-0  w-full h-full overflow-hidden;
        background-image: repeating-linear-gradient(
            0deg,
            black,
            black 1px,
            transparent 1px,
            transparent 2px
        );
        pointer-events: none;
    }
}
```

    tags: #css #tailwind
