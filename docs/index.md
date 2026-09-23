# billing-api

handles billing requests

Owner: `group:default/developer-experience`

This page is the TechDocs home for the service. GitHub still uses the
repository README. Add any other page as a `.md` file under `docs/`;
MkDocs includes it automatically. Keep `index.md` as the homepage.

## Local environment

Copy `.env.example` to `.env`. A pre-commit hook rejects `.env` files; `.env.example` is allowed. Run `make install-hooks` once after clone.

- `PORT` (`8000`): same port the process listens on in Compose.
- `DATABASE_URL` (`postgres://app:app@localhost:5432/app`): host-side URL. Compose sets `postgres://app:app@postgres:5432/app` in the app container.
- `AWS_ENDPOINT_URL` (unset): set only for LocalStack. Leave unset in production.

`uv run uvicorn` and Compose use these names. The image already listens on `8000`.

## Docker Compose

Postgres is the local database. Integration tests still start their own
containers with Testcontainers. Do not change `.github/workflows/ci.yml` to
add a dependency.

```bash
# Database only, then run the app on the host
docker compose up postgres
cp .env.example .env
uv sync
make install-hooks
uv run uvicorn src.main:app --reload --port 8000

# App image and Postgres together
docker compose up --build
```

Health check: `curl http://localhost:8000/health`

## Verify

`make verify` runs the same local checks as Python CI, in the same order:
format, lint, then unit tests.

```bash
make verify
make test
make test-integration
```

The first GitHub Release run after scaffold only proves CI. Image publish
waits until `ECR_REPOSITORY` exists. Docs publish waits until
`TECHDOCS_S3_BUCKET` exists. Then use **Actions → Release → Run workflow**.

## Platform

- Service repository: https://github.com/developer-experience-DevEX-platform/billing-api
- Staging GitOps: https://github.com/developer-experience-DevEX-platform/platform-gitops/tree/main/environments/staging/billing-api
- Production GitOps: https://github.com/developer-experience-DevEX-platform/platform-gitops/tree/main/environments/production/billing-api
- Infrastructure stack: https://github.com/developer-experience-DevEX-platform/platform-infrastructure/tree/main/services/billing-api
