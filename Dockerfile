FROM node:16-alpine as builder

WORKDIR /app

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml /app/

RUN pnpm install

COPY . /app/

RUN pnpm run build

# start final image
FROM node:16-alpine

WORKDIR /app

COPY --from=builder /app/.output .output
COPY --from=builder /app/.nuxt .nuxt

ENV NUXT_PUBLIC_API_BASE http://localhost:9000
ENV HOST 0.0.0.0
EXPOSE 3000

CMD ["node", ".output/server/index.mjs"]
