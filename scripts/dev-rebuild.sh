#!/usr/bin/env bash
set -euo pipefail

doppler run -- docker compose -f docker-compose.yml -f docker-compose.dev.yml build --no-cache api-gateway
