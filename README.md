# EDU'NOVA

SaaS super-repository. The first backend brick is a FastAPI API Gateway managed with UV, Docker Compose, and Doppler.

## Secrets & Environment Variables

Doppler is the source of truth for secrets in development and production. Do not create or commit `.env` files.

Required variables:

- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `POSTGRES_DB`
- `POSTGRES_REPLICATION_USER`
- `POSTGRES_REPLICATION_PASSWORD`
- `IDENTITY_APP_NAME`
- `MAURIA_API_URL`
- `MAURIA_LOGIN_PATH`
- `ALLOW_STUDENT_BYPASS`

> **Note** : `ALLOW_STUDENT_BYPASS=true` permet de tester le login avec des emails `@student.junia.com` sans appeler l'API Mauria. À n'activer qu'en développement.

## Quick Start

Clone the repository with its backend submodule:

```bash
git clone --recurse-submodules git@github.com:EduNova2026/SuperRepository.git
cd SuperRepository
```

If you already cloned the repository without submodules, initialize them before starting Docker:

```bash
git submodule update --init --recursive
```

Start the full infrastructure with Doppler:

```bash
doppler run -- docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d
```

Stop it when needed:

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml down
```

The API Gateway is the only backend service exposed to the host and listens on `http://localhost:8000`.
The frontend must never call backend microservices directly.

The Identity Service and Mauria mock are internal Docker services only. They are reachable by other containers through Docker DNS (`http://identity-service:8000` and `http://mauria-mock:8000`) but are not published on localhost.

```bash
curl http://localhost:8000/health
curl http://localhost:8000/health/detailed
curl http://localhost:8000/api/v1/gateway/status
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H 'Content-Type: application/json' \
  -d '{"email":"test@junia.com","password":"test"}'
```

## Local development

The helper scripts still work if you prefer them:

```bash
./scripts/dev-up.sh
./scripts/dev-down.sh
```

## Backend checks

Run from `backend/`:

```bash
uv run pytest
uv run ruff check .
uv run ruff format .
```
