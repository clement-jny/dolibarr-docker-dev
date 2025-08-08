#!/bin/bash

COMPOSE_FILE="composes/database/compose.yml"

if [ ! -f "${COMPOSE_FILE}" ]; then
  echo "❌ Compose file ${COMPOSE_FILE} not found!"
  exit 1
fi

echo "🚀 Launching database..."
docker compose -f "${COMPOSE_FILE}" up -d
