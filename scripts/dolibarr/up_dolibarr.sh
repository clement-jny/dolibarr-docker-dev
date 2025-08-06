#!/bin/bash
set -e

VERSION=$1
# TYPE=$2

if [ -z "$VERSION" ]; then
  echo "Usage: up_dolibarr <version>"
  exit 1
fi

# Convert version : X.Y.Z to XYZ
CLEAN_VERSION=$(echo ${VERSION} | sed 's/\.//g')

COMPOSE_FILE="composes/dolibarr/${VERSION}/compose-${CLEAN_VERSION}.yml"
# OVERRIDE_FILE="composes/dolibarr/${VERSION}/compose-${CLEAN_VERSION}.port.override.yml"
# OVERRIDE_FILE="composes/dolibarr/${VERSION}/compose-${CLEAN_VERSION}.traefik.override.yml"

if [ ! -f "${COMPOSE_FILE}" ]; then
  echo "❌ Compose file ${COMPOSE_FILE} not found!"
  exit 1
fi
# if [ ! -f "${OVERRIDE_FILE}" ]; then
#   echo "❌ Override file ${OVERRIDE_FILE} not found!"
#   exit 1
# fi

# if [ "$TYPE" == "port" ]; then
#   OVERRIDE_FILE="composes/dolibarr/${VERSION}/compose-${CLEAN_VERSION}.port.override.yml"
# elif [ "$TYPE" == "traefik" ]; then
#   OVERRIDE_FILE="composes/dolibarr/${VERSION}/compose-${CLEAN_VERSION}.traefik.override.yml"
# else
#   echo "❌ Invalid type specified! Use 'port' or 'traefik'."
#   exit 1
# fi

# if [ ! -f "${OVERRIDE_FILE}" ]; then
#   echo "❌ Override file ${OVERRIDE_FILE} not found!"
#   exit 1
# fi

echo "🚀 Launching Dolibarr v${VERSION}..."
# docker compose -f "${COMPOSE_FILE}" -f "${OVERRIDE_FILE}" up -d
docker compose -f "${COMPOSE_FILE}" up -d
echo "✅ Dolibarr v${VERSION} is up and running!"
