# Zip cheatsheet

## How to zip a file on the Unix command line

Lets say you have following structure and you want to create zip all the files into a flat structure into a file called archive.zip.

```
> tree
.
├── checkData.json
├── README.md
├── request.json
└── response.json
```

`zip archive.zip checkData.json request.json response.json`

To unzip run

`unzip archive.zip`