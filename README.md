# Dolibarr Docker Development Environment

A comprehensive Docker-based development environment for Dolibarr ERP/CRM system, designed for core development and module testing with multiple concurrent versions.

## 🚀 Features

- **Multi-version support**: Run multiple Dolibarr versions simultaneously
- **Automated setup**: One-command download and configuration of Dolibarr versions
- **Pre-configured environment**: Ready-to-use database and web server setup
- **Reverse proxy**: Traefik for easy domain-based access (dlb2002.localhost, dlb2102.localhost, etc.)
- **Development tools**: Adminer and PHPMyAdmin for database management
- **Custom modules**: Support for custom Dolibarr modules and extensions

## 📁 Project Structure

```
dolibarr-docker-dev/
├── composes/          # Docker Compose configurations
├── custom/            # Custom Dolibarr modules and extensions
├── dockerfiles/       # Custom Docker images
├── scripts/           # Automation scripts for setup and management
└── versions/          # Downloaded Dolibarr versions
```

## 🛠️ Quick Start

### 1. Start the infrastructure

```bash
make up_traefik    # Start reverse proxy
make up_database   # Start MariaDB
```

### 2. Download and setup Dolibarr

```bash
make get_dolibarr v=21.0.2    # Download Dolibarr 21.0.2
make up_dolibarr v=21.0.2     # Start Dolibarr instance
```

### 3. Access your Dolibarr instance

- **Dolibarr**: http://dlb2102.localhost/
- **Adminer**: http://localhost:9080/
- **PHPMyAdmin**: http://localhost:9090/
- **Traefik Dashboard**: http://localhost:8080/

## 📋 Database Configuration

When setting up Dolibarr for the first time:

- **Database server**: `mariadb`
- **Database name**: `dolibarr_XXXX` (auto-created, where XXXX is the clean version)
- **Username**: `dolibarr_user_XXXX`
- **Password**: `dolibarr_password_XXXX`
- **Port**: `3306`

## 🔧 Available Commands

### Infrastructure Management

- `make up_traefik` / `make down_traefik` - Manage reverse proxy
- `make up_database` / `make down_database` - Manage database
- `make up_adminer` / `make down_adminer` - Manage Adminer
- `make up_phpmyadmin` / `make down_phpmyadmin` - Manage PHPMyAdmin

### Dolibarr Management

- `make get_dolibarr v=X.Y.Z` - Download and configure Dolibarr version
- `make up_dolibarr v=X.Y.Z` - Start Dolibarr instance
- `make down_dolibarr v=X.Y.Z` - Stop Dolibarr instance

## 📂 Directory Details

Each directory has its own README with detailed information:

- [`composes/`](composes/README.md) - Docker Compose configurations
- [`custom/`](custom/readme.md) - Custom modules and extensions
- [`dockerfiles/`](dockerfiles/README.md) - Custom Docker images
- [`scripts/`](scripts/README.md) - Automation scripts
- [`versions/`](versions/README.md) - Dolibarr versions storage
