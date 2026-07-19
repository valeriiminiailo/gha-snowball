# gha-snowball

GHA CI/CD snowball that can be expanded

## Getting Started

First, run the development server:

```bash
pnpm dev
```

## Docker & CI notes

This project includes a multi-stage `Dockerfile` tuned for Next.js + `pnpm`. Important points:

Build and run the production container:

```bash
docker compose up --build
```
To stop the container 
```bash
docker compose down
```