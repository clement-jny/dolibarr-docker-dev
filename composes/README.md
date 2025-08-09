# Docker Compose Configurations

This directory contains Docker Compose files for all services in the Dolibarr development environment. Each service has its own subdirectory with dedicated compose files and documentation.

## Core Services

### **`database/`**

This directory contains the Docker Compose configuration for the MariaDB database service that powers all Dolibarr instances in the development environment.

- Contains the main database compose file
- Persistent data storage configuration
- Database initialization scripts

#### 🌐 Network Configuration

- **Network**: `mariadb_default` (created automatically)
- **External Access**: Available to all Dolibarr instances
- **Host Access**: Available at `localhost:3306`

#### 🚀 Usage

```bash
# Start the database service

## Using make command (recommended)
make up_database

## Using docker compose directly
cd composes/database/mariadb
docker compose up -d
```

```bash
# Stop the database service

## Using make command
make down_database

## Using docker compose directly
cd composes/database/mariadb
docker compose down
```

#### 💾 Data Persistence

Database data is stored in the `.data/` directory:

```
composes/database/mariadb/
├── .data/
│   ├── mysql/               # System databases
│   ├── performance_schema/
│   └── dolibarr_*/          # Dolibarr databases (created automatically)
└── compose.yml
```

#### ⚠️ Important Notes

- **Data Persistence**: The `.data/` directory contains all database data
- **Root Access**: Uses simple root/root credentials for development ease
- **Port Exposure**: Database is accessible from host for external tools
- **Automatic Startup**: Database must be running before starting Dolibarr instances
- **Backup**: Consider backing up `.data/` for important development data

### **`traefik/`**

This directory contains the Docker Compose configuration for Traefik, the reverse proxy that handles routing and domain management for all services in the development environment.

- Accessible via `http://localhost:8080/`
- Traefik configuration for routing
- SSL/TLS certificate management
- Service discovery and load balancing

#### 🚀 Usage

```bash
# Start the Traefik service

## Using make command (recommended)
make up_traefik

## Using docker compose directly
cd composes/traefik
docker compose up -d
```

```bash
# Stop the Traefik service

## Using make command
make down_traefik

## Using docker compose directly
cd composes/traefik
docker compose down
```

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
