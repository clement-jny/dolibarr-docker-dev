# Dolibarr Docker Development Environment

A Docker-based development environment for Dolibarr ERP/CRM system with support for custom modules and testing.

## Quick Start

1. **Get Dolibarr source code:**

   ```bash
   make get-dolibarr v=22.0.0
   ```

2. **Start the development environment:**

   ```bash
   docker compose up -d
   ```

3. **Access Dolibarr:**
   - Web interface: http://localhost:8000
   - Database: localhost:3306 (root/root)

## Project Structure

- `dolibarr/` - Dolibarr source code
- `custom/` - Custom modules and extensions
- `documents/` - Dolibarr documents and data
- `test/` - Test instance for modules
- `scripts/` - Automation scripts

## Testing Different Versions

Create and run test instances:

```bash
# Create test configuration
make create-test-dolibarr v=22.0.0 p=8010

# Start test instance
make up-test-dolibarr v=22.0.0 p=8010

# Stop test instance
make down-test-dolibarr v=22.0.0 p=8010
```

## Custom Modules

Place your custom modules in the `custom/` directory. They will be automatically mounted in both development and test environments.

## Available Commands

- `make get-dolibarr v=<version>` - Download Dolibarr version
- `make create-test-dolibarr v=<version> p=<port>` - Create test configuration
- `make up-test-dolibarr v=<version> p=<port>` - Start test instance
- `make down-test-dolibarr v=<version> p=<port>` - Stop test instance

## Requirements

- Docker
- Docker Compose
- Make
