# Reverse engineering Wagmi Github CI/CD pipeline

I was looking to see how other projects structured there CI/CD pipeline on GitHub that has a similar flow to how I would like [Knut].

[Knut]: https://github.com/jlrickert/knutjs

Here are the key points that I am interested in:

- Verify workflow

  The verify workflow ensures that PR's to the main branch pass all the checks. This includes

- Changeset workflow

  This either creates a PR to make a release or publishes packages to npmjs. See the [changeset](../362) workflow for more details. It does re run the verify workflow before proceeding.

One technique that they use that is interesting is to have create a reusable actions for installing node and friends. This is a common thing that is in most of the actions. Here is its contents with a few things omitted:

```yaml
name: "Install dependencies"
description: "Prepare repository and all dependencies"

runs:
  using: "composite"
  steps:
    - name: Set up pnpm
      uses: pnpm/action-setup@v2

    - name: Set up node
      uses: actions/setup-node@v4
      with:
        cache: pnpm
        node-version: 20

    - name: Install dependencies
      shell: bash
      run: pnpm install
```

The thing that I am omitting is foundry-rs.

- [ ] TODO: Research into what foundry-rs does