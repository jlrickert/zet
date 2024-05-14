# Git gutter issues in Phpstorm based editor when using SMB protocol

I ran into an issue where git wasn't working in Phpstorm. Running the following fixed it for me

```bash
git config --global --add safe.directory '%(prefix)///server.int.jlrickert.me/www/webroot/devel/project'
```
