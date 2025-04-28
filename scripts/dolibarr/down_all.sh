# #!/bin/bash
# set -e

# for dir in composes/dolibarr/*/ ; do
# 	VERSION=$(basename "$dir")
# 	CLEAN_VERSION=$(echo ${VERSION} | sed 's/\.//g')

# 	(cd composes/dolibarr/${CLEAN_VERSION} && docker compose -f compose-${CLEAN_VERSION}.yml down) || true
# done