# gha-snowball

GHA CI/CD snowball that can be expanded

## Getting Started

First, run the development server:

```bash
pnpm dev
```

## Docker & CI notes

This project includes a multi-stage `Dockerfile` tuned for Next.js + `pnpm`. Important points:

```bash
# enable BuildKit for cache mounts
DOCKER_BUILDKIT=1 docker build -t gha-snowball:latest .
```