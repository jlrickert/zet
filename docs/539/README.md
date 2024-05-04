# Cross compatibility with Windows Explorer zip files

Windows explorer has a built in features to create zip files. Windows uses 7-zip which is different that the one that macosx uses. To work around this issue brew has the p7zip package.

To install run:

```bash
brew install p7zip
```

To extract run something like:

```bash
7z e some-zip-file.zip
```

This extracts all contents of the `some-zip-file.zip` into the current working directory.

## 7z commands

- a:: Add
- d:: Delete
- e:: Extract
- l:: List
- t:: Test
- u:: Update
- x:: extract with full paths
