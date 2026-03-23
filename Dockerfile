# Stage 1: Build the app on your Windows 11 machine
FROM node:18-bookworm-slim AS build
WORKDIR /app
COPY . .
# We use --immutable to ensure your yarn.lock is respected
RUN yarn install --immutable && yarn build:all

# Stage 2: Create the tiny ARM image for the Pi
FROM node:18-bookworm-slim
WORKDIR /app

# Install production tools for ARM
RUN apt-get update && apt-get install -y python3 make g++ libpq-dev && rm -rf /var/lib/apt/lists/*

# Copy the bundle from the build stage
COPY --from=build /app/packages/backend/dist/bundle.tar.gz .
RUN tar xzf bundle.tar.gz && rm bundle.tar.gz

# Install only production-ready modules
RUN yarn install --production --network-timeout 600000

# Optimization for Raspberry Pi RAM
ENV NODE_OPTIONS="--max-old-space-size=2048"

CMD ["node", "packages/backend/dist/index.js", "--config", "app-config.yaml", "--config", "app-config.production.yaml"]