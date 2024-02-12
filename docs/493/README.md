# System interactions in Tauri

I was looking for a way to make a web app that could also be deployed on desktop via Tauri.

Here is what I learned:

- Frontend is able to make calls rust. Rust then will have access to the system.

  On the rust side a FFI is created. The frontend can then invoke it. See invocation [example].

  [example]: https://tauri.app/v1/guides/features/command#complete-example

- Event system

  Basic pub sub

## See also

- https://tauri.app/v1/guides/features/command#complete-example