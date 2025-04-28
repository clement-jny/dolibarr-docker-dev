#!/bin/bash

COMPOSE_FILE="composes/traefik/compose.yml"

if [ ! -f "${COMPOSE_FILE}" ]; then
  echo "❌ Compose file ${COMPOSE_FILE} not found!"
  exit 1
fi

echo "🛑 Stopping traefik..."
docker compose -f "${COMPOSE_FILE}" down
