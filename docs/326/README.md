# Setting up a new KEG app with tina and jekyll

This is a work in progress. Here is what I learned. Here are some of the issues
that I ran into:

- Tina CMS uses front mater. KEGML doesn't support front mater
- Tina CMS doesn't support mobile very well
- Tina CMS cli only allows hosting the cms on localhost

## Steps to reproduce

- [Install ruby with chruby](../325)
- Install jekyll

  ```bash
  gem install jekyll bundler
  jekyll new keg-site
  ```

- Modify `Gemfile`

  It should look something like the following

  ```ruby
  gem "github-pages", group: :jekyll_plugins
  # If you have any plugins, put them here!
  group :jekyll_plugins do
    gem "jekyll-feed", "~> 0.12"
    gem "jekyll-remote-theme", "~> 0.4.3"
  end

  # Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
  # and associated library.
  platforms :mingw, :x64_mingw, :mswin, :jruby do
    gem "tzinfo", ">= 1", "< 3"
    gem "tzinfo-data"
  end

  # Performance-booster for watching directories on Windows
  gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

  # Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
  # do not have a Java counterpart.
  gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]

  gem "webrick", "~> 1.8"
  ```

  Running `gem add webrick` does something intereseting

  [ ] TODO: How to use cli to create this

- Move jekyll files into the docs dir
- Modify jekyll config.

  It should look something like the following:

  ```yaml
  title: Your awesome title
  email: your-email@example.com
  description: >- # this means to ignore newlines until "baseurl:"
    This is a proto website to see how well tina cms will work with a keg
  baseurl: "/spike-jekyll-keg" # the subpath of your site, e.g. /blog
  url: "https://jlrickert.github.io/spike-jekyll-keg" # the base hostname & protocol for your site, e.g. http://example.com
  github_username: your_github_username

  remote_theme: pages-themes/hacker@v0.2.0

  # Build settings
  # theme: minima
  plugins:
    - jekyll-feed
    - jekyll-remote-theme
  ```

- Install tina

  ```bash
  pnpx @tinacms/cli@latest init
  ```

- Add dev script to `package.json`.

  ```json
  {
    "scripts": {
      "dev": "tinacms dev -c \"jekyll serve --source docs\""
    }
  }
  ```

## Meta

    tags: #ssg #jekyll #cms
