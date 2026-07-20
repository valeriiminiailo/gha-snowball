# gha-snowball

GHA CI/CD snowball that can be expanded

## Requirements

This project requires **Node.js 24** or higher and **pnpm 10** or higher.

- **Node.js**: Install from https://nodejs.org/ or use [nvm](https://github.com/nvm-sh/nvm) to manage versions
- **pnpm**: Install globally or use `corepack enable pnpm` (included with Node.js 24)

If you use nvm or fnm, the project includes a `.nvmrc` file. Simply run `nvm use` (or equivalent) to switch to the correct Node.js version.

## Getting Started

First, run the development server:

```bash
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser to see the result.

## Development Scripts

```bash
# Lint code
pnpm lint

# Format code
pnpm format

# Run type checker
pnpm typecheck

# Run tests
pnpm test

# Build for production
pnpm build

# Start production server
pnpm start
```

## Technology Stack

- **Frontend**: Next.js 16 with React 19
- **Styling**: Tailwind CSS 4
- **Package Manager**: pnpm 10
- **Runtime**: Node.js 24
- **Language**: TypeScript 5 (es6 target)
- **Testing**: Vitest with React Testing Library
- **Linting**: ESLint 9 with Prettier
- **CI/CD**: GitHub Actions with Docker support

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
