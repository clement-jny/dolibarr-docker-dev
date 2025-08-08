# Adminer part
up_adminer:
	bash scripts/adminer/up_adminer.sh
down_adminer:
	bash scripts/adminer/down_adminer.sh

# Database part

## MariaDB
up_mariadb:
	bash scripts/database/mariadb/up_mariadb.sh
down_mariadb:
	bash scripts/database/mariadb/down_mariadb.sh

# Dolibarr part
v ?=
# type ?= traefik
get_dolibarr:
	bash scripts/dolibarr/get_dolibarr.sh $(v)
up_dolibarr:
	bash scripts/dolibarr/up_dolibarr.sh $(v)
down_dolibarr:
	bash scripts/dolibarr/down_dolibarr.sh $(v)
# list:
# 	bash scripts/dolibarr/list_dolibarr.sh
# down_all:
# 	bash scripts/dolibarr/down_all.sh

# Phpmyadmin part
up_phpmyadmin:
	bash scripts/phpmyadmin/up_phpmyadmin.sh
down_phpmyadmin:
	bash scripts/phpmyadmin/down_phpmyadmin.sh

# Traefik part
up_traefik:
	bash scripts/traefik/up_traefik.sh
down_traefik:
	bash scripts/traefik/down_traefik.sh
