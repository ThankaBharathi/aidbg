.PHONY: help install lint format test test-cov clean run pre-commit

# Colors for output
YELLOW := \033[1;33m
GREEN := \033[1;32m
NC := \033[0m

help: ## Show this help message
	@echo '${YELLOW}Usage:${NC}'
	@echo '  ${GREEN}make${NC} ${YELLOW}[target]${NC}'
	@echo ''
	@echo '${YELLOW}Targets:${NC}'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "  ${GREEN}%-15s${NC} %s\n", $$1, $$2}'

install: ## Install dependencies
	poetry install --no-root

lint: ## Run all linters
	poetry run ruff check src tests
	poetry run mypy src
	poetry run black --check src tests
	@echo "✓ Lint passed"

format: ## Auto-format code
	poetry run black src tests
	poetry run isort src tests
	poetry run ruff check --fix src tests
	@echo "✓ Format completed"

test: ## Run tests
	poetry run pytest

test-cov: ## Run tests with coverage
	poetry run pytest --cov=src --cov-report=term-missing

run: ## Run the CLI
	poetry run python -m src.presentation.cli.main

pre-commit: ## Run pre-commit hooks
	poetry run pre-commit run --all-files

clean: ## Clean cache files
	rm -rf .pytest_cache .coverage htmlcov .mypy_cache .ruff_cache
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
