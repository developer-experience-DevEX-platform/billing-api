.PHONY: format-check lint test test-integration verify install-hooks

format-check:
	uv run black --check .

lint:
	uv run ruff check .

test:
	uv run pytest -m "not integration" --cov=src --cov-report=xml --cov-report=term-missing

test-integration:
	uv run pytest -m integration

verify: format-check lint test

install-hooks:
	git config core.hooksPath .githooks
