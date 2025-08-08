# Database Management Scripts

This directory contains scripts for managing the MariaDB database service that powers all Dolibarr instances in the development environment.

## 📋 Available Scripts

- **`up_database.sh`** - Start MariaDB database service with persistent storage
- **`down_database.sh`** - Stop database service and optionally purge data

## 🚀 Script Details

### `up_database.sh` - Start Database

**Purpose**: Launches the MariaDB container with proper configuration and data persistence.

**Usage**:

```bash
# Direct execution
./scripts/db/up_database.sh

# Via Makefile (recommended)
make up_database
```

**What it does**:

1. **Creates** `db_default` Docker network if needed
2. **Starts** MariaDB container with persistent storage
3. **Configures** root access with password `root`
4. **Enables** external access on port 3306
5. **Reports** startup status

**Container Configuration**:

- **Image**: `mariadb:latest`
- **Root Password**: `root`
- **Port**: `3306` (accessible from host)
- **Data Storage**: `composes/db/.mariadb/` (persistent)
- **Character Set**: `utf8mb4`
- **Collation**: `utf8mb4_unicode_ci`

### `down_database.sh` - Stop Database

**Purpose**: Gracefully stops the MariaDB service while preserving data.

**Usage**:

```bash
# Direct execution
./scripts/db/down_database.sh

# Via Makefile (recommended)
make down_database
```

**What it does**:

1. **Stops** MariaDB container gracefully
2. **Preserves** all database data in `.mariadb/`
3. **Maintains** network configuration
4. **Reports** shutdown status

**Data Preservation**:

- All databases remain intact
- User data and configurations preserved
- Next startup will restore all data
