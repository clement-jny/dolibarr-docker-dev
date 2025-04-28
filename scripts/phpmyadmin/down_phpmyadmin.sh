#!/bin/bash

COMPOSE_FILE="composes/phpmyadmin/compose.yml"

if [ ! -f "${COMPOSE_FILE}" ]; then
  echo "❌ Compose file ${COMPOSE_FILE} not found!"
  exit 1
fi

echo "🛑 Stopping phpmyadmin..."
docker compose -f "${COMPOSE_FILE}" down
