# Unix help pages with color

It is nice to have colors in man pages as well as other programs. After
searching around I found that colors are controlled by either termcap or
terminfo[^11.1].

This is configured by the LESS_TERMCAP_xx variables where xx is a capability
found in the man page for termcap.

Here is a dump of the variables and things that I found works:

```bash
export LESS="-R"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 5) # start blinking magenta
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # star bold mode green
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # start standout mode yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
```

The values for setaf and settab can be found with the following script.

```bash
#!/bin/bash
color(){
    for c; do
        printf '\e[48;5;%dm%03d' $c $c
    done
    printf '\e[0m \n'
}

IFS=$' \t\n'
color {0..15}
for ((i=0;i<6;i++)); do
    color $(seq $((i*36+16)) $((i*36+51)))
done
color {232..255}
```

[^11.1]: https://unix.stackexchange.com/questions/119/colors-in-man-pages
