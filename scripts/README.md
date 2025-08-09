# Automation Scripts

This directory contains shell scripts for automating the setup, management, and teardown of the Dolibarr development environment. All scripts are organized by service and can be executed individually or through the main Makefile.

## Core Infrastructure

### **`database/`**

This directory contains scripts for managing the MariaDB database service that powers all Dolibarr instances in the development environment.

#### 📋 Available Scripts

- **`up_mariadb.sh`** - Start MariaDB database service
- **`down_mariadb.sh`** - Stop MariaDB database service

### **`traefik/`**

This directory contains scripts for managing Traefik, the reverse proxy that handles domain routing and service discovery for the entire Dolibarr development environment.

#### 📋 Available Scripts

- **`up_traefik.sh`** - Start Traefik reverse proxy with full configuration
- **`down_traefik.sh`** - Stop Traefik service

### **`dolibarr/`**

This directory contains comprehensive scripts for managing Dolibarr instances throughout their lifecycle - from download and configuration to deployment and maintenance.

#### 📋 Available Scripts

- **`get_dolibarr.sh`** - Download, configure, and prepare Dolibarr versions
- **`up_dolibarr.sh`** - Start Dolibarr instances with proper networking
- **`down_dolibarr.sh`** - Stop specific Dolibarr instances
- **`down_all.sh`** - Stop all running Dolibarr instances

## Database Administration Tools

### **`adminer/`**

This directory contains scripts for managing Adminer, a lightweight web-based database management tool perfect for quick SQL operations and database inspection during Dolibarr development.

#### 📋 Available Scripts

- **`up_adminer.sh`** - Start Adminer database management interface
- **`down_adminer.sh`** - Stop Adminer service

### **`phpmyadmin/`**

This directory contains scripts for managing PHPMyAdmin, a comprehensive web-based MySQL/MariaDB administration tool that provides full database management capabilities for Dolibarr development.

#### 📋 Available Scripts

- **`up_phpmyadmin.sh`** - Start PHPMyAdmin database administration interface
- **`down_phpmyadmin.sh`** - Stop PHPMyAdmin service

## 📋 Script Features

- **Error handling**: All scripts include proper error checking and validation
- **Version management**: Automatic handling of Dolibarr version formatting (X.Y.Z → XYZ)
- **Network creation**: Automatic Docker network setup and management
- **Configuration generation**: Auto-generation of conf.php files with correct settings
- **Status feedback**: Clear success/error messages and progress indicators

## 🚨 Important Notes

- Scripts assume Docker and Docker Compose are installed and running
- Version parameters must follow semantic versioning (X.Y.Z format)
- Database scripts may require sudo privileges depending on your Docker setup
- Always start infrastructure (Traefik, Database) before launching Dolibarr instances
