# Adminer Management Scripts

This directory contains scripts for managing Adminer, a lightweight web-based database management tool perfect for quick SQL operations and database inspection during Dolibarr development.

## 📋 Available Scripts

- **`up_adminer.sh`** - Start Adminer database management interface
- **`down_adminer.sh`** - Stop Adminer service

## 🚀 Script Details

### `up_adminer.sh` - Start Adminer

**Purpose**: Launches Adminer with proper network configuration for database access.

**Usage**:

```bash
# Direct execution
./scripts/adminer/up_adminer.sh

# Via Makefile (recommended)
make up_adminer
```

**What it does**:

1. **Creates** required Docker networks if needed
2. **Starts** Adminer container with lightweight SQL interface
3. **Configures** access to MariaDB database
4. **Sets up** Traefik routing for web access
5. **Reports** access URL and connection details

**Service Configuration**:

- **Image**: `adminer:latest`
- **Access URL**: http://localhost:9080/
- **Database Support**: MySQL, MariaDB, PostgreSQL, SQLite
- **Resource Usage**: Minimal (~10MB image)

### `down_adminer.sh` - Stop Adminer

**Purpose**: Gracefully stops the Adminer service.

**Usage**:

```bash
# Direct execution
./scripts/adminer/down_adminer.sh

# Via Makefile (recommended)
make down_adminer
```

**What it does**:

1. **Stops** Adminer container gracefully
2. **Preserves** network configuration
3. **Reports** shutdown status

## 🔧 Database Connection

### Connection Settings

When accessing http://localhost:9080/, use:

**Connection Parameters**:

- **System**: `MySQL`
- **Server**: `mariadb`
- **Username**: `root`
- **Password**: `root`
- **Database**: (optional - leave empty to see all)

### Available Databases

- `dolibarr_2102` (Dolibarr 21.0.2)
- `dolibarr_2002` (Dolibarr 20.0.2)
- System databases: `mysql`, `information_schema`, etc.
