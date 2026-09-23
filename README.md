# billing-api

handles billing requests

Owner: group:default/developer-experience

Docs in Backstage: [docs/index.md](docs/index.md)

Copy `.env.example` to `.env` for local values.

Install: `uv sync`

Install the `.env` pre-commit hook: `make install-hooks`

Run in development: `uv run uvicorn src.main:app --reload --port 8000`

Local Postgres: `docker compose up postgres`

Run the app image and Postgres: `docker compose up --build`

Same checks as CI: `make verify`

Unit tests: `make test`

Integration tests: `make test-integration`

Integration tests start their own dependencies with Testcontainers, so Docker
must be running locally. The same command runs in CI. Do not change
`.github/workflows/ci.yml` to add a dependency.

The scaffold ships one Postgres sample in `tests/integration/test_postgres.py`.
That file is a pattern, not the full set of dependencies this service will
need. Replace it with tests of this service's own components, or keep it and
add more files next to it.

### Adding S3, SQS, or other AWS APIs

Use LocalStack. pytest already runs every file under `tests/integration/`.

```bash
uv add --dev testcontainers boto3
```

Point the service at `AWS_ENDPOINT_URL` from the container; production leaves
that unset so the AWS SDK talks to real AWS.

- Only Postgres: keep the sample. Change the table and queries to match the schema.
- S3 and SQS, no database: replace `test_postgres.py` with a LocalStack test.
- Postgres, S3, and SQS: keep both files. Testcontainers starts both containers.

Smoke, performance, and regression tests against a deployed environment belong
in CD, not here.
