# Steps to host a keg with github pages

A keg repo on GitHub may be hosted on github pages with a little bit of work. This involes configuring git pages, creating a few files files, setting up dns, and setting up google for having the site index.

Files that need to exist are a front page and a page that links the the keg index for the site. This is `docs/README.md` and `docs/dex/README.md`. `docs/README.md` acts as the home page while `docs/dex/README.md` allows for linking to the index. `docs/README.md` links to `docs/dex/README.md` that then links to `docs/dex/changes.md`. See https://jlrickert.github.io/zet/README.md and https://jlrickert.github.io/zet/dex/README.md for examples.

The next step is configuring GitHub pages. In your zettelkasten repo the settings for a page will be under the settings tab and under pages. It should have the following setup.

- The source sould be **Deploy from a branch**.
- The branch should be the desired branch and the file should be `/docs`.
- (optional) Custom domain set to zet.example.com

If setting up a custom domain make sure the following entries are in the DNS. I use namecheap

```txt
CNAME zet username.github.io
A @ 185.199.108.153
A @ 185.199.109.153
A @ 185.199.110.153
A @ 185.199.111.153
AAAA @ 2606:50c0:8000::153
AAAA @ 2606:50c0:8001::153
AAAA @ 2606:50c0:8002::153
AAAA @ 2606:50c0:8003::153
```

To make it so that google can index your website go to search.google.com/search-console/welcome and type in your domain name. Then follow the instructions.
