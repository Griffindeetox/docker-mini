# --- build deps stage ---
FROM node:20-alpine AS deps
WORKDIR /app
# copy BOTH package.json and package-lock.json
COPY package*.json ./
RUN npm ci --omit=dev

# --- runtime stage ---
FROM node:20-alpine
ENV NODE_ENV=production
RUN addgroup -S app && adduser -S app -G app
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY server.js ./server.js
USER app
EXPOSE 3000
# use curl for healthcheck (install it)
USER root
RUN apk add --no-cache curl
USER app
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -fsS http://localhost:3000/health || exit 1
CMD ["node","server.js"]
