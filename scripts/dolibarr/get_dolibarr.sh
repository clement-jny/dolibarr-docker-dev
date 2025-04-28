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


# Create the compose file for the version
echo "⬇️  Creating compose file for Dolibarr ${VERSION}..."

cd ../../composes/dolibarr
mkdir -p ${VERSION}
cd ${VERSION}

# Here I'm in ./composes/dolibarr/21.0.0/...
# Create base compose file
cat > compose-${CLEAN_VERSION}.yml <<EOF
services:
  dolibarr_${CLEAN_VERSION}:
    container_name: dolibarr_${CLEAN_VERSION}
    build:
      context: ../../../dockerfiles
      dockerfile: example.Dockerfile
    volumes:
      - ../../../versions/${VERSION}/htdocs:/var/www/html
      - ../../../versions/${VERSION}/documents:/var/www/documents
      - ../../../custom:/var/www/html/custom
    labels:
      - traefik.enable=true
      - traefik.http.routers.dolibarr_${CLEAN_VERSION}.entrypoints=web
      - traefik.http.routers.dolibarr_${CLEAN_VERSION}.rule=Host(\`dolibarr-${CLEAN_VERSION}.localhost\`)
      - traefik.http.services.dolibarr_${CLEAN_VERSION}.loadbalancer.server.port=80
    networks:
      - db_default

networks:
  db_default:
    external: true
EOF

# Create override compose file if I want to use port without traefik
cat > compose-${CLEAN_VERSION}.port.override.yml <<EOF
services:
  dolibarr_${CLEAN_VERSION}:
    ports:
      - 80:80
EOF

# Create override compose file if I want to use traefik
cat > compose-${CLEAN_VERSION}.traefik.override.yml <<EOF
services:
  dolibarr_${CLEAN_VERSION}:
    networks:
      - traefik_default

networks:
  traefik_default:
    external: true
EOF

echo "✅ Compose file created for Dolibarr ${VERSION}."
# cd ../../
