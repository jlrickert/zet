# Node installation

## Ubuntu installation

```bash
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
# Download and install Node.js:
nvm install 22
# Verify the Node.js version:
node -v # Should print "v22.17.1".
nvm current # Should print "v22.17.1".
# Download and install pnpm:
corepack enable pnpm
# Verify pnpm version:
pnpm -v
```