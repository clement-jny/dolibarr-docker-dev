#!/bin/bash
set -e

# Script for downloading/upgrading/downgrading Dolibarr from SourceForge

VERSION=$1
TARGET_DIR="dolibarr"

# Check if version argument is provided
if [ -z "${VERSION}" ]; then
    echo "❌ Missing version."
    echo "Use: ./scripts/get-dolibarr.sh X.Y.Z or make get_dolibarr v=X.Y.Z"
    echo "Example: ./scripts/get-dolibarr.sh 22.0.2 or make get_dolibarr v=22.0.2"
    exit 1
fi

# Check if the version is valid
if ! [[ ${VERSION} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ Invalid version format. Use X.Y.Z format."
  exit 1
fi


echo "📦 Downloading Dolibarr ${VERSION}... from SourceForge"

# Define the SourceForge URL for the specified version
SOURCEFORGE_URL="https://sourceforge.net/projects/dolibarr/files/Dolibarr%20ERP-CRM/${VERSION}/dolibarr-${VERSION}.zip"

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
cd "${TEMP_DIR}"

# Download the zip file
curl -L -o "dolibarr-${VERSION}.zip" "${SOURCEFORGE_URL}"

if [ ! -f "dolibarr-${VERSION}.zip" ]; then
    echo "❌ Download failed."
    rm -rf "${TEMP_DIR}"
    exit 1
fi

# Extract the zip file
echo "📂 Extraction..."
unzip -q "dolibarr-${VERSION}.zip"


# Revenir au répertoire du projet
cd - > /dev/null

# Move the extracted files to the target directory
echo "📁 Installation of Dolibarr ${VERSION} into ${TARGET_DIR}..."
cp -r "${TEMP_DIR}/dolibarr-${VERSION}"/* "${TARGET_DIR}"



# Cleanup
rm -rf "${TEMP_DIR}"

echo "✅ Dolibarr ${VERSION} installed in ${TARGET_DIR}"