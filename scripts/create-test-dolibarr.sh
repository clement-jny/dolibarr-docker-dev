#!/bin/bash
set -e

# Script to create a Dolibarr test environment with official image

VERSION=$1
PORT=$2

# Check if version argument is provided
if [ -z "${VERSION}" ]; then
    echo "❌ Missing version."
    echo "Use: ./scripts/create-test-dolibarr.sh X.Y.Z PORT or make create-test-dolibarr v=X.Y.Z p=PORT"
    echo "Example: ./scripts/create-test-dolibarr.sh 22.0.2 8010 or make create-test-dolibarr v=22.0.2 p=8010"
    exit 1
fi

# Check if the port is within the allowed range (8000-8100)
if [ $PORT -lt 8000 ] || [ $PORT -gt 8100 ]; then
    echo "❌ Port must be between 8000 and 8100"
    exit 1
fi

# Check if the port is already in use
if netstat -tln | grep -q ":${PORT} "; then
    echo "❌ Port ${PORT} is already in use"
    exit 1
fi

# Nom du test environment
TEST_NAME="test-${VERSION//\./-}-${PORT}"
TEST_DIR="test"
TEST_COMPOSE_FILE="${TEST_DIR}/test-${VERSION}-${PORT}.yml"

echo "🧪 Création de l'environnement de test ${TEST_NAME}..."

# Créer le répertoire de test
mkdir -p "${TEST_DIR}"

# Générer un identifiant unique pour la base de données
DB_SUFFIX=$(echo $RANDOM | md5sum | head -c 8)
DB_NAME="dolibarr_test_${DB_SUFFIX}"
DB_USER="test_user_${DB_SUFFIX}"
DB_PASSWORD="test_pass_${DB_SUFFIX}"

# Créer le compose.yml pour le test
cat > "${TEST_COMPOSE_FILE}" <<EOF
services:
  ${TEST_NAME}-web:
    image: dolibarr/dolibarr:${VERSION}
    restart: always
    environment:
      PHP_INI_DATE_TIMEZONE: Europe/Paris

      DOLI_DB_HOST: ${TEST_NAME}-mariadb
      DOLI_DB_NAME: ${DB_NAME}
      DOLI_DB_USER: ${DB_USER}
      DOLI_DB_PASSWORD: ${DB_PASSWORD}
      DOLI_URL_ROOT: http://localhost:${PORT}

      DOLI_INIT_DEMO: 1

      DOLI_ADMIN_LOGIN: admin
      DOLI_ADMIN_PASSWORD: admin
    volumes:
      - ../custom:/var/www/html/custom:ro
    ports:
      - "${PORT}:80"
    depends_on:
      - ${TEST_NAME}-mariadb

  ${TEST_NAME}-mariadb:
    image: mariadb:latest
    restart: always
    environment:
      MARIADB_ROOT_PASSWORD: root
      MARIADB_DATABASE: ${DB_NAME}
      MARIADB_USER: ${DB_USER}
      MARIADB_PASSWORD: ${DB_PASSWORD}
      TZ: Europe/Paris
    ports:
      - "$((PORT + 100)):3306"
EOF
