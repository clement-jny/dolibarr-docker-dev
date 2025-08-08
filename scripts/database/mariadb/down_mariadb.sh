#!/bin/bash

COMPOSE_FILE="composes/database/mariadb/compose.yml"

if [ ! -f "${COMPOSE_FILE}" ]; then
  echo "❌ Compose file ${COMPOSE_FILE} not found!"
  exit 1
fi

echo "🛑 Stopping mariadb..."
docker compose -f "${COMPOSE_FILE}" down
