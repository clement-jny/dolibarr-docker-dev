# Traefik Reverse Proxy Scripts

This directory contains scripts for managing Traefik, the reverse proxy that handles domain routing and service discovery for the entire Dolibarr development environment.

## 📋 Available Scripts

- **`up_traefik.sh`** - Start Traefik reverse proxy with full configuration
- **`down_traefik.sh`** - Stop Traefik service gracefully

## 🚀 Script Details

### `up_traefik.sh` - Start Reverse Proxy

**Purpose**: Launches Traefik with proper configuration for automatic service discovery and domain routing.

**Usage**:

```bash
# Direct execution
./scripts/traefik/up_traefik.sh

# Via Makefile (recommended)
make up_traefik
```

**What it does**:

1. **Creates** `traefik_default` Docker network if needed
2. **Starts** Traefik container with dashboard and API
3. **Configures** automatic service discovery
4. **Enables** HTTP routing on port 80
5. **Exposes** dashboard on port 8080
6. **Reports** startup status and access URLs

**Service Configuration**:

- **Image**: `traefik:latest`
- **Dashboard**: http://localhost:8080/
- **HTTP Port**: `80` (all web traffic)
- **API**: Enabled for service monitoring
- **Provider**: Docker with automatic discovery

### `down_traefik.sh` - Stop Reverse Proxy

**Purpose**: Gracefully stops Traefik while preserving network configuration.

**Usage**:

```bash
# Direct execution
./scripts/traefik/down_traefik.sh

# Via Makefile (recommended)
make down_traefik
```

**What it does**:

1. **Stops** Traefik container gracefully
2. **Preserves** network configuration
3. **Maintains** SSL certificates (if configured)
4. **Reports** shutdown status
