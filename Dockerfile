ARG NODE_VERSION=24-bookworm-slim

FROM node:${NODE_VERSION} AS dependencies
WORKDIR /app

# Copy only package-related files first for layer caching
# Include .npmrc and pnpm-lock.yaml so installs are deterministic
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml .npmrc ./

# Install dependencies using pnpm and a mounted pnpm store cache (BuildKit required)
# The cache id ensures the cache can be reused across builds on the same builder
RUN --mount=type=cache,id=pnpm-store,target=/root/.local/share/pnpm/store \
    corepack enable pnpm && pnpm install --frozen-lockfile

FROM node:${NODE_VERSION} AS builder
WORKDIR /app

# Copy node_modules from the dependencies stage and then the source
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

# Build environment
ENV NODE_ENV=production
# Increase heap for large Next.js builds (adjust if necessary)
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Ensure pnpm is available, then build. Using the lockfile ensures reproducible output.
RUN corepack enable pnpm && pnpm build

FROM node:${NODE_VERSION} AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# Create a non-root user for running the app
RUN addgroup --system --gid 1001 nodejs && adduser --system --uid 1001 nextjs

# Copy runtime assets from builder (standalone output)
COPY --from=builder --chown=nextjs:nodejs /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Ensure proper permissions for the prerender cache directory
RUN mkdir -p .next && chown -R nextjs:nodejs .next

USER nextjs
EXPOSE 3000
CMD ["node", "server.js"]