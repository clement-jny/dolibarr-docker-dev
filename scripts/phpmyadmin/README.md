# PHPMyAdmin Management Scripts

This directory contains scripts for managing PHPMyAdmin, a comprehensive web-based MySQL/MariaDB administration tool that provides full database management capabilities for Dolibarr development.

## 📋 Available Scripts

- **`up_phpmyadmin.sh`** - Start PHPMyAdmin database administration interface
- **`down_phpmyadmin.sh`** - Stop PHPMyAdmin service

## 🚀 Script Details

### `up_phpmyadmin.sh` - Start PHPMyAdmin

**Purpose**: Launches PHPMyAdmin with full database administration capabilities and automatic MariaDB connection.

**Usage**:

```bash
# Direct execution
./scripts/phpmyadmin/up_phpmyadmin.sh

# Via Makefile (recommended)
make up_phpmyadmin
```

**What it does**:

1. **Creates** required Docker networks if needed
2. **Starts** PHPMyAdmin container with full MySQL administration suite
3. **Configures** automatic connection to MariaDB
4. **Sets up** Traefik routing for web access
5. **Enables** advanced database features and tools
6. **Reports** access URL and connection status

**Service Configuration**:

- **Image**: `phpmyadmin/phpmyadmin:latest`
- **Access URL**: http://pma.localhost/
- **Auto-login**: Enabled with root credentials
- **Upload Limit**: 64MB for SQL imports
- **Features**: Complete MySQL/MariaDB administration

### `down_phpmyadmin.sh` - Stop PHPMyAdmin

**Purpose**: Gracefully stops the PHPMyAdmin service.

**Usage**:

```bash
# Direct execution
./scripts/phpmyadmin/down_phpmyadmin.sh

# Via Makefile (recommended)
make down_phpmyadmin
```

**What it does**:

1. **Stops** PHPMyAdmin container gracefully
2. **Preserves** network configuration and settings
3. **Maintains** session data and preferences
4. **Reports** shutdown status

## 🔧 Database Connection

### Automatic Configuration

PHPMyAdmin is pre-configured for the development environment:

**Connection Parameters** (automatic):

- **Server**: `mariadb` (Docker service name)
- **Username**: `root`
- **Password**: `root`
- **Auto-login**: Enabled for development convenience
- **Arbitrary Server**: Enabled for flexibility

### Database Access

**Available Databases**:

- `dolibarr_2102` (Dolibarr 21.0.2)
- `dolibarr_2002` (Dolibarr 20.0.2)
- `dolibarr_1904` (Dolibarr 19.0.4)
- System databases: `mysql`, `information_schema`, `performance_schema`, `sys`
