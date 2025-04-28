# Adminer part
up_adminer:
	bash scripts/adminer/up_adminer.sh
down_adminer:
	bash scripts/adminer/down_adminer.sh

# Database part
up_database:
	bash scripts/db/up_database.sh
down_database:
	bash scripts/db/down_database.sh


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