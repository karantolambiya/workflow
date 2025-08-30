FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:18-alpine AS production

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=10s CMD curl -f http://localhost:3000/health || exit 1

CMD ["node", "./dist/index.js"]
