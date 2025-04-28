#!/bin/bash

COMPOSE_FILE="composes/traefik/compose.yml"

if [ ! -f "${COMPOSE_FILE}" ]; then
  echo "❌ Compose file ${COMPOSE_FILE} not found!"
  exit 1
fi

echo "🚀 Launching traefik..."
docker compose -f "${COMPOSE_FILE}" up -d
