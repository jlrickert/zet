# Strange .pnpm-store appearing in my repo

I was experimenting with running a SvelteKit application for deployment and
development when a **.pnpm-store** file was placed in my app directory. The
directory was create while experimenting in a node container with a shell.
Running `pnpm install` would create the folder and place it into my application.
After some investigation I determined that due to the environment the path was
set to the current working directory. Originally, I thought this was a problem
but it went away as the store isn't created in the **runner** or **dev**
targets. Nothing seems to be broken either.

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
COPY --from=deps /app/node_modules ./node_modules
COPY . .
EXPOSE $PORT
CMD ["pnpm", "run", "dev", "--host"]


FROM --platform=arm64 node:18-alpine AS runner
RUN npm install --global pnpm
WORKDIR /app
ENV NODE_ENV production
RUN addgroup --system --gid 1001 group1
RUN adduser --system --uid 1001 user1
COPY --from=builder /app/build /app/server
COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app/package.json app/pnpm-lock.yaml ./
USER user1
ENV PORT 3000
EXPOSE $PORT
CMD ["node", "server"]
```

I am ignoring it for now. Running something like
`pnpm configure set store-path /.pnpm-store` may be a partial solution. keeping
it here for reference in case I run into an issue with it.
