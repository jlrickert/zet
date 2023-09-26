# Steps to host a keg with GitHub pages

A keg repo on GitHub may be hosted on github pages with a little bit of work.
This involves configuring git pages, creating a few files files, setting up DNS,
adding a Jekyll theme, and setting up google for having the site index.

## GitHub pages setup

Out of the box a keg site has no entry points. This is `docs/README.md` and
`docs/dex/README.md`. `docs/README.md` acts as the home page while
`docs/dex/README.md` allows for linking to the index. `docs/README.md` links to
`docs/dex/README.md` that then links to `docs/dex/changes.md`. See
https://jlrickert.github.io/zet/README.md and
https://jlrickert.github.io/zet/dex/README.md for examples.

Once the files have been created the next step is configuring GitHub pages. In
your zettelkasten repo the settings for pages will be under the settings tab and
under pages. It should have the following things set:

- The source sould be **Deploy from a branch**.
- The branch should be the desired branch and the file should be `/docs`.
- (optional) Custom domain set to zet.example.com

## Theme

To add a theme a `_config.yml` needs to be created with the content needed to
set the theme. Here is an example:

```yaml
tittle: KEG Zettelkasten for Jared Rickert (jlrickert)
description:
  My personal zettelkasten KEG site. It contains stuff on pretty much any topic
  I feel like writing about.
url: https://zet.jlrickert.me
google_analytics: G-WXQ3PHET4N
remote_theme: pages-themes/hacker@v0.2.0
plugins:
  - jekyll-remote-theme # add this line to the plugins list if you already have one
  - jekyll-sitemap
```

I am currently using the theme **hacker**. A list of compatable themes may be
found at https://pages.github.com/themes/.

## Custom domain (Optional)

If setting up a custom domain make sure to have the following entries set in the
DNS. I use namecheap.

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

## Indexing

Having google index the site is nice to have. To make it so that google can
index your website go to search.google.com/search-console/welcome and type in
your domain name. Then follow the instructions for setting up DNS validation.

## Google analytics

Google analytics is as simple as coping over your GA4 tag over to your
`_config.yml` file. For example:

```yaml
google_analytics: G-WXQ3PHET4N
```

A problem that I ran into for some themes (including hacker) is that it may
still be using now deprecated google analytics. See
[hacker theme google analytics issue](../267?T) for an example of a potential
fix.

    tags: #blog #webdev
