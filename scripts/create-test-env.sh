#!/bin/bash
set -e

# Script pour créer un environnement de test Dolibarr avec image officielle
# Usage: ./create-test-env.sh <version> [port]

VERSION=$1
PORT=${2:-8000}

if [ -z "${VERSION}" ]; then
    echo "❌ Version manquante. Usage: ./create-test-env.sh <version> [port]"
    echo "Exemple: ./create-test-env.sh 18.0.5 8010"
    exit 1
fi

# Vérifier si le port est dans la plage autorisée (8000-8100)
if [ $PORT -lt 8000 ] || [ $PORT -gt 8100 ]; then
    echo "❌ Le port doit être entre 8000 et 8100"
    exit 1
fi

# Vérifier si le port est déjà utilisé
if netstat -tln | grep -q ":${PORT} "; then
    echo "❌ Le port ${PORT} est déjà utilisé"
    exit 1
fi

# Nom du test environment
TEST_NAME="test-${VERSION//\./-}-${PORT}"
TEST_DIR="test/${TEST_NAME}"

echo "🧪 Création de l'environnement de test ${TEST_NAME}..."

# Créer le répertoire de test
mkdir -p "${TEST_DIR}"

# Générer un identifiant unique pour la base de données
DB_SUFFIX=$(echo $RANDOM | md5sum | head -c 8)
DB_NAME="dolibarr_test_${DB_SUFFIX}"
DB_USER="test_user_${DB_SUFFIX}"
DB_PASSWORD="test_pass_${DB_SUFFIX}"

# Créer le docker-compose.yml pour le test
cat > "${TEST_DIR}/docker-compose.yml" <<EOF
version: '3.8'

services:
  dolibarr:
    image: dolibarr/dolibarr:${VERSION}
    container_name: ${TEST_NAME}-app
    ports:
      - "${PORT}:80"
    environment:
      - DOLIBARR_DB_HOST=mariadb
      - DOLIBARR_DB_NAME=${DB_NAME}
      - DOLIBARR_DB_USER=${DB_USER}
      - DOLIBARR_DB_PASSWORD=${DB_PASSWORD}
      - DOLIBARR_PROD=0
      - DOLIBARR_URL_ROOT=http://localhost:${PORT}
      - DOLIBARR_AUTO_DB_INSTALL=1
      - DOLIBARR_DB_PREFIX=llx_
      - DOLIBARR_DB_TYPE=mysqli
      # Activer les données de démonstration
      - DOLIBARR_ADMIN_LOGIN=admin
      - DOLIBARR_ADMIN_PASSWORD=admin
      - DOLIBARR_DEMO_ENABLED=1
    volumes:
      - dolibarr_data:/var/www/html
      - dolibarr_documents:/var/www/documents
      - ../../custom:/var/www/html/custom:ro
    depends_on:
      - mariadb
    networks:
      - ${TEST_NAME}-network

  mariadb:
    image: mariadb:10.11
    container_name: ${TEST_NAME}-db
    environment:
      - MYSQL_ROOT_PASSWORD=root_${DB_SUFFIX}
      - MYSQL_DATABASE=${DB_NAME}
      - MYSQL_USER=${DB_USER}
      - MYSQL_PASSWORD=${DB_PASSWORD}
    volumes:
      - mariadb_data:/var/lib/mysql
    ports:
      - "$((PORT + 100)):3306"
    networks:
      - ${TEST_NAME}-network

  phpmyadmin:
    image: phpmyadmin:latest
    container_name: ${TEST_NAME}-pma
    ports:
      - "$((PORT + 200)):80"
    environment:
      - PMA_ARBITRARY=1
      - PMA_HOST=mariadb
    depends_on:
      - mariadb
    networks:
      - ${TEST_NAME}-network

volumes:
  dolibarr_data:
    name: ${TEST_NAME}_dolibarr_data
  dolibarr_documents:
    name: ${TEST_NAME}_dolibarr_documents
  mariadb_data:
    name: ${TEST_NAME}_mariadb_data

networks:
  ${TEST_NAME}-network:
    name: ${TEST_NAME}_network
    driver: bridge
EOF

# Créer un fichier d'informations
cat > "${TEST_DIR}/info.txt" <<EOF
Environnement de test Dolibarr ${VERSION}
Créé le: $(date '+%Y-%m-%d %H:%M:%S')

🌐 URLs:
  - Dolibarr: http://localhost:${PORT}
  - PhpMyAdmin: http://localhost:$((PORT + 200))

🗄️  Base de données:
  - Host: localhost:$((PORT + 100))
  - Database: ${DB_NAME}
  - User: ${DB_USER}
  - Password: ${DB_PASSWORD}

👤 Connexion admin (avec données de démo):
  - Login: admin
  - Password: admin

🚀 Commandes:
  - Démarrer: cd ${TEST_DIR} && docker-compose up -d
  - Arrêter: cd ${TEST_DIR} && docker-compose down
  - Supprimer: cd ${TEST_DIR} && docker-compose down -v && cd ../.. && rm -rf ${TEST_DIR}
EOF

echo "✅ Environnement de test ${TEST_NAME} créé avec succès"
echo "📁 Répertoire: ${TEST_DIR}"
echo "🌐 Dolibarr: http://localhost:${PORT}"
echo "🗄️  PhpMyAdmin: http://localhost:$((PORT + 200))"
echo "👤 Login: admin / admin (avec données de démo)"
echo ""
echo "Pour démarrer l'environnement:"
echo "  cd ${TEST_DIR} && docker-compose up -d"