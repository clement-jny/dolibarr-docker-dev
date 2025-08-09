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
# Start MariaDB service

## Using make command (recommended)
make up_database

## Using docker compose directly
cd composes/database/mariadb
docker compose up -d
```

```bash
# Stop MariaDB service

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
# Start Traefik service

## Using make command (recommended)
make up_traefik

## Using docker compose directly
cd composes/traefik
docker compose up -d
```

```bash
# Stop Traefik service

## Using make command
make down_traefik

## Using docker compose directly
cd composes/traefik
docker compose down
```

### **`dolibarr/`**

This directory contains Docker Compose files for all Dolibarr versions. Each version has its own subdirectory with dedicated compose configuration for independent deployment and testing.

#### 📁 Directory Structure

```
composes/dolibarr/
├── 21.0.2/
│   └── compose-2102.yml    # Dolibarr 21.0.2 service definition
├── 20.0.2/
│   └── compose-2002.yml    # Dolibarr 20.0.2 service definition
```

- Accessible via version-specific URLs (e.g., `http://dlb2102.localhost/`)
- Version-specific compose files (e.g., `21.0.2/compose-2102.yml`)
- Traefik labels for domain routing

#### ⚙️ Container Configuration

Each Dolibarr instance includes:

- **Custom Docker Image**: Built from `dockerfiles/example.Dockerfile`
- **Volume Mounts**: Source code, documents, and custom modules
- **Network Access**: Connected to both Traefik and database networks
- **Domain Routing**: Automatic Traefik configuration

#### 🚀 Usage

```bash
# Start specific Dolibarr service version

## Using make command (recommended)
make up_dolibarr v=21.0.2

## Using docker compose directly
cd composes/dolibarr/21.0.2
docker compose -f compose-2102.yml up -d
```

```bash
# Stop specific Dolibarr service version

## Using make command
make down_dolibarr v=21.0.2

## Using docker compose directly
cd composes/dolibarr/21.0.2
docker compose -f compose-2102.yml down
```

```bash
# Start multiple Dolibarr service versions
make up_dolibarr v=21.0.2
make up_dolibarr v=20.0.2
make up_dolibarr v=19.0.4
```

```bash
# Stop multiple Dolibarr service versions
make down_dolibarr v=21.0.2
make down_dolibarr v=20.0.2
make down_dolibarr v=19.0.4
```

#### ⚠️ Important Notes

- **Dependencies**: Requires Traefik and MariaDB to be running first
- **Port Conflicts**: Each version uses a unique service name to avoid conflicts
- **File Permissions**: Ensure proper permissions on mounted volumes
- **Database**: Each version connects to its own database (e.g., `dolibarr_2102`)
- **Custom Modules**: Shared across all versions via `/custom` mount

## Management Tools

### **`adminer/`**

This directory contains the Docker Compose configuration for Adminer, a lightweight web-based database management tool perfect for quick SQL operations and database inspection during development.

- Accessible via `http://localhost:9080/`
- Simple SQL interface for development

#### 🚀 Usage

```bash
# Start Adminer service

## Using make command (recommended)
make up_adminer

## Using docker compose directly
cd composes/adminer
docker compose up -d
```

```bash
# Stop Adminer service

## Using make command
make down_adminer

## Using docker compose directly
cd composes/adminer
docker compose down
```

#### 🔑 Database Access

- **System**: `MySQL`
- **Server**: `mariadb`
- **Username**: `root`
- **Password**: `root`
- **Database**: (leave empty to see all databases)

### **`phpmyadmin/`**

This directory contains the Docker Compose configuration for PHPMyAdmin, a comprehensive web-based MySQL/MariaDB administration tool that provides full database management capabilities for Dolibarr development.

- Accessible via `http://localhost:9090/`
- Advanced MySQL/MariaDB administration

#### 🚀 Usage

```bash
# Start PHPMyAdmin service

## Using make command (recommended)
make up_phpmyadmin

## Using docker compose directly
cd composes/phpmyadmin
docker compose up -d
```

```bash
# Stop PHPMyAdmin service

## Using make command
make down_phpmyadmin

## Using docker compose directly
cd composes/phpmyadmin
docker compose down
```

#### 🔑 Database Access

- **Server**: `mariadb`
- **Username**: `root`
- **Password**: `root`
