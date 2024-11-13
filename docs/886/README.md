# Process for create my encode script

This is my process for creating the encode script. I first wrote a simple [spec](../885). I then generated a bash script. I fed the spec and the template into the AI with a program called mods.

```bash
zet pub cat 885 | mods --role bash "This is my spec for the encode program"
create-bash-script encode
cat encode | mods --role bash -C
```

The output largely did what I want.
