# Issue: handling nested links in html

A HTML box that should act as a link. Within the box there are additional items that have more links. The problem with this an `a` tag should have have `a` descendants.

For the root tag use something like `onclick="location.href='https://example.com'"`.

Still need to figure out what to do with giving it back expected behavior as the root tag won't use the defaults.
