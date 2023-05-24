# Example of keyword searching with awk

Searching with keywords can be accomplished by running `ack keyword1|keyword2`
and so on. This will give you the file and a line number. At some point I
would like to create a bash script around this functionality to get a search
engine like experience.

Here is the example output of `ack 'example|ack'`:

```
20221115181409/README.md
1:# Postman close order for table 15 example

20221115183734/README.md
1:# Example of keyword searching with awk
3:Searching with keywords can be accomplished by running `awk keyword1|keyword2`
```

    #cli #linux
