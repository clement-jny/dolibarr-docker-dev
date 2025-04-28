#!/bin/bash
set -e

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: down_dolibarr <version>"
  exit 1
fi

# Convert version : X.Y.Z to XYZ
CLEAN_VERSION=$(echo ${VERSION} | sed 's/\.//g')

COMPOSE_FILE="composes/dolibarr/${VERSION}/compose-${CLEAN_VERSION}.yml"

if [ ! -f "${COMPOSE_FILE}" ]; then
  echo "❌ Compose file ${COMPOSE_FILE} not found!"
  exit 1
fi

echo "🛑 Stopping Dolibarr v${VERSION}..."
docker compose -f "${COMPOSE_FILE}" down