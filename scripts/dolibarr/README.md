# Dolibarr Management Scripts

This directory contains comprehensive scripts for managing Dolibarr instances throughout their lifecycle - from download and configuration to deployment and maintenance.

## 📋 Available Scripts

### Core Management Scripts

- **`get_dolibarr.sh`** - Download and configure Dolibarr versions
- **`up_dolibarr.sh`** - Start Dolibarr instances with proper networking
- **`down_dolibarr.sh`** - Stop specific Dolibarr instances
- **`down_all.sh`** - Stop all running Dolibarr instances

## 🚀 Script Details

### `get_dolibarr.sh` - Download and Setup

**Purpose**: Downloads, extracts, and configures Dolibarr versions for development.

**Usage**:

```bash
# Direct execution
./scripts/dolibarr/get_dolibarr.sh 21.0.2

# Via Makefile (recommended)
make get_dolibarr v=21.0.2
```

**What it does**:

1. **Validates** version format (X.Y.Z)
2. **Downloads** from GitHub releases
3. **Extracts** to `versions/{VERSION}/`
4. **Generates** pre-configured `conf.php`
5. **Creates** Docker Compose file
6. **Sets up** Traefik routing labels

**Generated Configuration**:

```php
$dolibarr_main_url_root='http://dlb{CLEAN_VERSION}.localhost';
$dolibarr_main_db_name='dolibarr_{CLEAN_VERSION}';
$dolibarr_main_db_user='root';
$dolibarr_main_db_pass='root';
```

### `up_dolibarr.sh` - Start Instance

**Purpose**: Launches Dolibarr instances with proper network configuration.

**Usage**:

```bash
# Direct execution
./scripts/dolibarr/up_dolibarr.sh 21.0.2

# Via Makefile (recommended)
make up_dolibarr v=21.0.2
```

**What it does**:

1. **Validates** version exists
2. **Creates** required Docker networks
3. **Starts** Docker Compose service
4. **Displays** access URL
5. **Provides** setup instructions

**Output Example**:

```
🚀 Launching Dolibarr 21.0.2...
🌐 Access your Dolibarr instance at: http://dlb2102.localhost/
📋 Database credentials: root/root
✅ Dolibarr 21.0.2 is now running!
```

### `down_dolibarr.sh` - Stop Instance

**Purpose**: Stops specific Dolibarr instances gracefully.

**Usage**:

```bash
# Direct execution
./scripts/dolibarr/down_dolibarr.sh 21.0.2

# Via Makefile (recommended)
make down_dolibarr v=21.0.2
```

**What it does**:

1. **Validates** version format
2. **Stops** Docker Compose service
3. **Preserves** data and configuration
4. **Confirms** shutdown

### `down_all.sh` - Stop All Instances

**Purpose**: Stops all running Dolibarr instances simultaneously.

**Usage**:

```bash
# Direct execution
./scripts/dolibarr/down_all.sh

# Via Makefile
make down_all_dolibarr
```

**What it does**:

1. **Identifies** all running Dolibarr containers
2. **Stops** each instance gracefully
3. **Reports** shutdown status
4. **Preserves** all data

## 🔧 Script Features

### Error Handling

- **Version Validation**: Ensures proper X.Y.Z format
- **Dependency Checking**: Verifies Docker and network availability
- **File Verification**: Checks for existing downloads and configurations
- **Network Management**: Automatic creation of required networks

### Automation Benefits

- **Pre-configuration**: Automatic database and URL setup
- **Network Integration**: Seamless Traefik and database connectivity
- **Version Management**: Clean version number handling (21.0.2 → 2102)
- **Consistent Environment**: Standardized configuration across versions

### Development Workflow

```bash
# Complete setup workflow
make up_traefik up_database          # Start infrastructure
make get_dolibarr v=21.0.2          # Download and configure
make up_dolibarr v=21.0.2           # Launch instance
# Access http://dlb2102.localhost/    # Start development

# Cleanup workflow
make down_dolibarr v=21.0.2         # Stop specific version
# or
make down_all_dolibarr              # Stop all versions
```

## ⚠️ Important Notes

- **Version Format**: Must use semantic versioning (X.Y.Z)
- **Dependencies**: Requires Traefik and MariaDB to be running
- **File Permissions**: Ensure scripts are executable (`chmod +x`)
- **Disk Space**: Each version requires ~200MB
- **Network Ports**: Uses Docker networks, no port conflicts
- **Data Persistence**: Databases and documents survive container restarts
