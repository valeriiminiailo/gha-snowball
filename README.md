# gha-snowball

GHA CI/CD snowball that can be expanded

## Getting Started

First, run the development server:

```bash
pnpm dev
```

## Docker & CI notes

This project includes a multi-stage `Dockerfile` tuned for Next.js + `pnpm`. Important points:

- The Dockerfile uses a build argument `NODE_VERSION` near the top. It is set to a Debian-slim Node 24 image to ensure compatibility with native modules (sharp, esbuild, etc.). To change the Node version used by the image, edit the `ARG NODE_VERSION` value in `Dockerfile`.

- Builds use BuildKit cache mounts for the pnpm store. To build locally with caching enabled run:

```bash
# enable BuildKit for cache mounts
DOCKER_BUILDKIT=1 docker build -t gha-snowball:latest .
```

- The Dockerfile copies `.npmrc` and the lockfile into the image before running `pnpm install --frozen-lockfile`, so installs are reproducible and use the project-specific pnpm settings.

- If dependencies require native builds (for example `sharp`), approve them locally and commit the lockfile/workspace approvals using:

```bash
pnpm approve-builds
git add pnpm-workspace.yaml pnpm-lock.yaml
git commit -m "Approve native builds for CI/Docker"
```

- If you encounter memory issues during `pnpm build` in Docker, the Dockerfile sets `NODE_OPTIONS` for the builder stage. You can increase the heap by editing the `ENV NODE_OPTIONS` value in `Dockerfile`.

CI integration: ensure the CI runner uses BuildKit (or remove the cache mounts) and that `.npmrc` and `pnpm-lock.yaml` are present in the repository so installs in CI are deterministic.

