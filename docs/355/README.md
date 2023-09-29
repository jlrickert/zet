# How to use docker for NodeJS development

If you plan on deploying with docker then there is an advantage to developing
with docker as well.

Here is an example Dockerfile for an both production and development. This
particular file is for SvelteKit app but the idea should transfer to other
frameworks.

```Dockerfile
FROM --platform=arm64 node:18-alpine AS deps
RUN npm install --global pnpm
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile


FROM --platform=arm64 node:18-alpine AS builder
RUN npm install --global pnpm
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN pnpm run build


FROM --platform=arm64 node:18-alpine AS dev
RUN npm install --global pnpm
WORKDIR /app
ENV NODE_ENV development
ENV PORT 5173
RUN addgroup --system --gid 1001 group1
RUN adduser --system --uid 1001 user1
USER user1
COPY --from=deps --chown=user1:group1 /app/node_modules /app/node_modules
COPY . .
EXPOSE $PORT
CMD ["pnpm", "run", "dev", "--host"]


FROM --platform=arm64 node:18-alpine AS runner
RUN npm install --global pnpm
WORKDIR /app
ENV NODE_ENV production
RUN addgroup --system --gid 1001 group1
RUN adduser --system --uid 1001 user1
COPY --from=builder --chown=user1:group1 /app/build /app/server
COPY --from=deps --chown=user1:group1 /app/node_modules ./node_modules
COPY --from=deps --chown=user1:group1 /app/package.json /app/pnpm-lock.yaml ./
USER user1
ENV PORT 3000
EXPOSE $PORT
CMD ["node", "server"]
```

## Production

For production things are much simpler. All the needs to be done is build the
image and then run. For example

```bash
docker build -t app-name .
docker run --rm -it -p 3000:3000 app-name
```

## Development

For development things get much trickier. Your files need to be mounted on the
running container. However, this creates an issue where `node_modules` and other
compiled things are also mounted. To get around this docker volumes need to be
used.

```bash
docker volume create app-name-node_modules
```

```bash
docker run --rm -it \
    -p 5173:5173 \
    --mount "source=app-name-node_modules,target=/app/node_modules" \
    --mount "type=bind,source=${PWD},target=/app" \
    app-name
```
