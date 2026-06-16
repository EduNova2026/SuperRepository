#!/usr/bin/env bash
set -euo pipefail

git checkout main
git pull origin main

doppler run -- docker compose -f docker-compose.yml up --build
