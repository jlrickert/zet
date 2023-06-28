# WordPress hosting with WPEngine

## Domain model

- Account

  An account is a plan and user pair that is used to group together

- User

- Plan

  A plan is what we have available to use for resources. This is the
  tier that we pay for.

- Group

  A group is a set of sites with an associated name and description.
  Purely for organization.

  ```haskell
  data site = { sites: Array String, name: String, name: Option String }
  ```

- Site

  A site is a collection of environments. Typically, an agency will have
  multiple sites where each site will have its own set of environments.
  For example, prod, staging, or dev environment are common for each
  site to have.

- Website

  What is this?

- Multi-site

  Something to do with users and permissions across various websites

- Environment

  An environment is a specific stateful configuration that make up a
  WordPress website. An environment will be part of a site.  Typically,
  an environment have a WordPress site available in the cloud. Typically
  it will also have some statistics with it such as storage used and how
  many visits per month.

Meta:

    tags: #wordpress
