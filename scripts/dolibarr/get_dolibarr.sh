#!/bin/bash
set -e

VERSION=$1
if [ -z "${VERSION}" ]; then echo "❌ Missing version. Uses : make get_dolibarr v=XYZ"; exit 1; fi

# Check if the version is valid
if ! [[ ${VERSION} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ Invalid version format. Use X.Y.Z format."
  exit 1
fi

# Convert version : X.Y.Z to XYZ
CLEAN_VERSION=$(echo ${VERSION} | sed 's/\.//g')

mkdir -p versions/${VERSION}
cd versions/${VERSION}

# Check if the version is already downloaded
if [ ! -f "htdocs/index.php" ]; then
  echo "⬇️  Download Dolibarr ${VERSION}..."

  curl -L -o dolibarr.zip https://github.com/Dolibarr/dolibarr/archive/refs/tags/${VERSION}.zip
  unzip dolibarr.zip

  mv dolibarr-${VERSION}/* .
  rm -rf dolibarr-${VERSION} dolibarr.zip

  echo "✅ Dolibarr ${VERSION} downloaded."
else
  echo "✅ Dolibarr ${VERSION} already downloaded."
fi


# echo "⬇️  Creating directories for Dolibarr ${VERSION}..."
# mkdir -p documents


# Create a pre-configured conf.php file
echo "⬇️  Creating pre-configured conf.php for Dolibarr ${VERSION}..."
cat > htdocs/conf/conf.php <<CONF_EOF
<?php
//
// File pre-configured for Dolibarr ${VERSION} on $(date '+%Y-%m-%d')
//
// Take a look at conf.php.example file for an example of conf.php file
// and explanations for all possibles parameters.
//
\$dolibarr_main_url_root='http://dlb${CLEAN_VERSION}.localhost';
\$dolibarr_main_document_root="/var/www/html";
\$dolibarr_main_url_root_alt='/custom';
\$dolibarr_main_document_root_alt="/var/www/html/custom";
\$dolibarr_main_data_root="/var/www/documents";
\$dolibarr_main_db_host='mariadb';
\$dolibarr_main_db_port='3306';
\$dolibarr_main_db_name='dolibarr_${CLEAN_VERSION}';
\$dolibarr_main_db_prefix='llx_';
\$dolibarr_main_db_user='dolibarr_user_${CLEAN_VERSION}';
\$dolibarr_main_db_pass='dolibarr_password_${CLEAN_VERSION}';
\$dolibarr_main_db_type='mysqli';
\$dolibarr_main_db_character_set='utf8';
\$dolibarr_main_db_collation='utf8_unicode_ci';
// Authentication settings
\$dolibarr_main_authentication='dolibarr';

//\$dolibarr_main_demo='autologin,autopass';
// Security settings
\$dolibarr_main_prod='0';
\$dolibarr_main_force_https='0';
\$dolibarr_main_restrict_os_commands='mariadb-dump, mariadb, mysqldump, mysql, pg_dump, pg_restore, clamdscan, clamdscan.exe';
\$dolibarr_nocsrfcheck='0';
\$dolibarr_main_instance_unique_id='$(openssl rand -hex 16)';
\$dolibarr_mailing_limit_sendbyweb='0';
\$dolibarr_mailing_limit_sendbycli='0';

//\$dolibarr_lib_FPDF_PATH="";
//\$dolibarr_lib_TCPDF_PATH="";
//\$dolibarr_lib_FPDI_PATH="";
//\$dolibarr_lib_TCPDI_PATH="";
//\$dolibarr_lib_GEOIP_PATH="";
//\$dolibarr_lib_NUSOAP_PATH="";
//\$dolibarr_lib_ODTPHP_PATH="";
//\$dolibarr_lib_ODTPHP_PATHTOPCLZIP="";
//\$dolibarr_js_CKEDITOR='';
//\$dolibarr_js_JQUERY='';
//\$dolibarr_js_JQUERY_UI='';

//\$dolibarr_font_DOL_DEFAULT_TTF='';
//\$dolibarr_font_DOL_DEFAULT_TTF_BOLD='';
\$dolibarr_main_distrib='standard';
CONF_EOF

echo "✅ Pre-configured conf.php created."


# Create the compose file for the version
echo "⬇️  Creating compose file for Dolibarr ${VERSION}..."

cd ../../composes/dolibarr
mkdir -p ${VERSION}
cd ${VERSION}

# Here I'm in ./composes/dolibarr/21.0.0/...
# Create base compose file
cat > compose-${CLEAN_VERSION}.yml <<EOF
services:
  dolibarr${CLEAN_VERSION}:
    build:
      context: ../../../dockerfiles
      dockerfile: example.Dockerfile
    volumes:
      - ../../../versions/${VERSION}/htdocs:/var/www/html
      - ../../../versions/${VERSION}/documents:/var/www/documents
      - ../../../custom:/var/www/html/custom
    labels:
      - traefik.enable=true
      - traefik.docker.network=traefik_default
      - traefik.http.routers.dlb${CLEAN_VERSION}.entrypoints=web
      - traefik.http.routers.dlb${CLEAN_VERSION}.rule=Host(\`dlb${CLEAN_VERSION}.localhost\`)
      - traefik.http.services.dlb${CLEAN_VERSION}.loadbalancer.server.port=80
    networks:
      - traefik_default
      - db_default

networks:
  traefik_default:
    external: true
  db_default:
    external: true
EOF

# Create override compose file if I want to use port without traefik
# cat > compose-${CLEAN_VERSION}.port.override.yml <<EOF
# services:
#   dolibarr_${CLEAN_VERSION}:
#     ports:
#       - 80:80
# EOF

# Create override compose file if I want to use traefik
# cat > compose-${CLEAN_VERSION}.traefik.override.yml <<EOF
# services:
#   dolibarr_${CLEAN_VERSION}:
#     networks:
#       - traefik_default

# networks:
#   traefik_default:
#     external: true
# EOF

echo "✅ Compose file created for Dolibarr ${VERSION}."
# cd ../../
