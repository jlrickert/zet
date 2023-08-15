# When to use CGO_ENABLED

`CGO_ENABLED` enables compiling code from c. For some features this is necessary. However, cross compilation is not possible. As a best practice it be best to not enable it globally and only set it to true locally when necessary. One example where I ran into this is when installing hugo with the enhanced feature set.
