#!/bin/bash
set -e

# Script pour télécharger/upgrader/downgrader Dolibarr depuis SourceForge
# Usage: ./upgrade-dolibarr.sh <version> [target_dir]

VERSION=$1
TARGET_DIR=${2:-"dev/dolibarr"}

if [ -z "${VERSION}" ]; then
    echo "❌ Version manquante. Usage: ./upgrade-dolibarr.sh <version> [target_dir]"
    echo "Exemple: ./upgrade-dolibarr.sh 22.0.2"
    exit 1
fi

# Vérifier le format de version
if ! [[ ${VERSION} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ Format de version invalide. Utilisez le format X.Y.Z"
    exit 1
fi

echo "📦 Téléchargement de Dolibarr ${VERSION} depuis SourceForge..."

# URL SourceForge
SOURCEFORGE_URL="https://sourceforge.net/projects/dolibarr/files/Dolibarr%20ERP-CRM/${VERSION}/dolibarr-${VERSION}.zip/download"

# Créer un répertoire temporaire
TEMP_DIR=$(mktemp -d)
cd "${TEMP_DIR}"

# Télécharger le zip
echo "⬇️  Téléchargement en cours..."
curl -L -o "dolibarr-${VERSION}.zip" "${SOURCEFORGE_URL}"

if [ ! -f "dolibarr-${VERSION}.zip" ]; then
    echo "❌ Échec du téléchargement"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

# Extraire le zip
echo "📂 Extraction en cours..."
unzip -q "dolibarr-${VERSION}.zip"

# Revenir au répertoire du projet
cd - > /dev/null

# Sauvegarder l'ancienne version si elle existe
if [ -d "${TARGET_DIR}" ]; then
    BACKUP_DIR="${TARGET_DIR}.backup.$(date +%Y%m%d-%H%M%S)"
    echo "💾 Sauvegarde de l'ancienne version vers ${BACKUP_DIR}"
    mv "${TARGET_DIR}" "${BACKUP_DIR}"
fi

# Créer le répertoire cible
mkdir -p "$(dirname "${TARGET_DIR}")"

# Déplacer la nouvelle version
echo "📁 Installation de Dolibarr ${VERSION}..."
mv "${TEMP_DIR}/dolibarr-${VERSION}" "${TARGET_DIR}"

# Créer les répertoires nécessaires
mkdir -p "${TARGET_DIR}/documents"
mkdir -p "$(dirname "${TARGET_DIR}")/documents"

# Créer/mettre à jour le fichier de configuration
echo "⚙️  Configuration de Dolibarr ${VERSION}..."
CONF_FILE="${TARGET_DIR}/htdocs/conf/conf.php"

# Générer un identifiant unique pour cette instance
UNIQUE_ID=$(openssl rand -hex 16)

cat > "${CONF_FILE}" <<CONF_EOF
<?php
//
// Fichier de configuration Dolibarr ${VERSION} généré le $(date '+%Y-%m-%d %H:%M:%S')
//
\$dolibarr_main_url_root='http://localhost:8080';
\$dolibarr_main_document_root='/var/www/html';
\$dolibarr_main_url_root_alt='/custom';
\$dolibarr_main_document_root_alt='/var/www/html/custom';
\$dolibarr_main_data_root='/var/www/documents';

// Configuration base de données
\$dolibarr_main_db_host='mariadb';
\$dolibarr_main_db_port='3306';
\$dolibarr_main_db_name='dolibarr_dev';
\$dolibarr_main_db_prefix='llx_';
\$dolibarr_main_db_user='dolibarr_user';
\$dolibarr_main_db_pass='dolibarr_password';
\$dolibarr_main_db_type='mysqli';
\$dolibarr_main_db_character_set='utf8';
\$dolibarr_main_db_collation='utf8_unicode_ci';

// Authentification
\$dolibarr_main_authentication='dolibarr';

// Paramètres de sécurité
\$dolibarr_main_prod='0';
\$dolibarr_main_force_https='0';
\$dolibarr_main_restrict_os_commands='mariadb-dump, mariadb, mysqldump, mysql, pg_dump, pg_restore';
\$dolibarr_nocsrfcheck='0';
\$dolibarr_main_instance_unique_id='${UNIQUE_ID}';

// Configuration email
\$dolibarr_mailing_limit_sendbyweb='0';
\$dolibarr_mailing_limit_sendbycli='0';

\$dolibarr_main_distrib='standard';
CONF_EOF

# Nettoyer le répertoire temporaire
rm -rf "${TEMP_DIR}"

echo "✅ Dolibarr ${VERSION} installé avec succès dans ${TARGET_DIR}"
echo "🌐 Accès: http://localhost:8080"
echo "🗄️  PhpMyAdmin: http://localhost:8081"
echo ""
echo "Pour démarrer l'environnement:"
echo "  cd dev && docker-compose up -d"