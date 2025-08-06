# Docker Compose Configurations

This directory contains Docker Compose files for all services in the Dolibarr development environment. Each service has its own subdirectory with dedicated compose files and documentation.

## 📁 Directory Structure

### Core Services

**[`db/`](db/README.md)** - MariaDB database service

- Contains the main database compose file
- Persistent data storage configuration
- Database initialization scripts

**[`traefik/`](traefik/README.md)** - Reverse proxy service

- Accessible via `http://localhost:8080/`
- Traefik configuration for routing
- SSL/TLS certificate management
- Service discovery and load balancing

### Dolibarr Instances

**[`dolibarr/`](dolibarr/README.md)** - Dolibarr application containers

- Accessible via version-specific URLs (e.g., `http://dlb2102.localhost/`)
- Version-specific compose files (e.g., `21.0.2/compose-2102.yml`)
- Traefik labels for domain routing

### Management Tools

**[`adminer/`](adminer/README.md)** - Lightweight database management tool

- Accessible via `http://localhost:9080/`
- Simple SQL interface for development

**[`phpmyadmin/`](phpmyadmin/README.md)** - Full-featured database management

- Accessible via `http://localhost:9090/`
- Advanced MySQL/MariaDB administration

## 🔧 Usage

These compose files are used by the automation scripts in the [`scripts/`](../scripts/README.md) directory. You can also run them manually:

```bash
# Start the database service
docker compose -f composes/db/compose.yml up -d

# Start Dolibarr version 21.0.2
docker compose -f composes/dolibarr/21.0.2/compose-2102.yml up -d
```

## 🌐 Network Configuration

All services use external Docker networks for communication:

- `traefik_default` - For reverse proxy routing
- `db_default` - For database access

These networks are defined in the corresponding Docker Compose files and are created automatically when you start the services.
