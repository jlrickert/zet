# Sveltekit how to debounce input

WIP copy and pasted a working example. Need to convert to something more
general. Usually this is more useful when fetching from a remote source.

```svelte
<script lang='ts'>
	import { loginSession } from '$lib/store';
	import { createAnonymousUser, type User } from '$lib/sessions';
	import { nanoid } from 'nanoid';

	const debounce = <FN extends (...args: any[]) => void>(cb: FN, wait = 500): FN => {
		let timeout: ReturnType<typeof setTimeout>;

		return ((...args: any[]) => {
			clearTimeout(timeout);
			console.log('here');
			timeout = setTimeout(() => {
				cb(...args);
			}, wait);
		}) as any;
	};

	const updateName = debounce((name: string) => {
		loginSession.update((user) => {
			if (user) {
				return { ...user, name };
			}
			return createAnonymousUser({ name, id: nanoid() });
		});
	});
	let name = '';
	$: {
		updateName(name);
	}

	const validCharacters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-';
	const handleInput = (event: Event & { currentTarget: (EventTarget & HTMLInputElement) }) => {
		name = event.currentTarget.value
			.split('')
			.filter((a) => validCharacters.includes(a))
			.join('');
	};
</script>

<h1>Home page</h1>

<div>
	<label for='name'>Nickname</label>
	<input autocomplete='off' bind:value={name} on:input={handleInput}
		   type='text' maxlength='20'
	/>
</div>
```
