#!/usr/bin/env bash
set -euo pipefail

doppler run -- docker compose -f docker-compose.dev.yml down
