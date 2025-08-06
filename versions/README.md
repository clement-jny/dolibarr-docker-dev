# Dolibarr Versions Storage

This directory contains all downloaded Dolibarr versions, each organized in its own subdirectory with complete source code and pre-configured settings for development.

## 📁 Directory Structure

Each Dolibarr version follows this structure:

```
versions/
├── 21.0.2/
│   ├── htdocs/               # Dolibarr web application files
│   │   ├── conf/
│   │   │   └── conf.php      # Pre-configured database settings
│   │   ├── index.php         # Main entry point
│   │   └── ...               # All Dolibarr source files
│   ├── documents/            # Document storage (auto-created)
│   ├── ChangeLog             # Version release notes
│   ├── composer.json         # PHP dependencies
│   └── README.md             # Dolibarr documentation
├── 20.0.2/                   # Another version
└── ...
```

## 🚀 Download and Setup

### Automatic Download (Recommended)

```bash
# Download and configure Dolibarr 21.0.2
make get_dolibarr v=21.0.2

# Download multiple versions
make get_dolibarr v=20.0.2
make get_dolibarr v=19.0.4
```

### What the Script Does

1. **Downloads** the specified version from [Dolibarr GitHub releases](https://github.com/Dolibarr/dolibarr/releases)
2. **Extracts** the archive to `versions/X.Y.Z/`
3. **Creates** pre-configured `conf.php` with correct database settings
4. **Generates** corresponding Docker Compose file in `composes/dolibarr/X.Y.Z/`
5. **Sets up** proper Traefik routing labels

### Manual Download

If you need to download manually:

```bash
cd versions/
mkdir 21.0.2 && cd 21.0.2
wget https://github.com/Dolibarr/dolibarr/archive/refs/tags/21.0.2.zip
unzip 21.0.2.zip
mv dolibarr-21.0.2/* .
rm -rf dolibarr-21.0.2 21.0.2.zip
```

## ⚙️ Pre-Configuration

Each downloaded version includes a pre-configured `htdocs/conf/conf.php` with:

- **Database host**: `mariadb`
- **Database name**: `dolibarr_XXXX` (where XXXX is the clean version number)
- **Database user**: `dolibarr_user_XXXX`
- **Database password**: `dolibarr_password_XXXX`
- **URL root**: `http://dlbXXXX.localhost`
- **Document root**: `/var/www/html`
- **Data directory**: `/var/www/documents`

## 🌐 Access URLs

Each version gets its own domain:

- `21.0.2` → `http://dlb2102.localhost/`
- `20.0.2` → `http://dlb2002.localhost/`
- `19.0.4` → `http://dlb1904.localhost/`

## 📝 Available Versions

You can find all available Dolibarr versions in the [official GitHub repository](https://github.com/Dolibarr/dolibarr/releases).

### Supported Version Format

- Use semantic versioning: `X.Y.Z` (e.g., `21.0.2`, `20.0.2`)
- The system automatically converts dots to clean version numbers for URLs and database names

## 🔧 Configuration Customization

After download, you can modify the `conf.php` file in each version to:

- Change database settings
- Adjust document paths
- Configure additional modules
- Set development-specific options

## 📊 Storage Requirements

Each Dolibarr version requires approximately:

- **150-200 MB** for source code
- **Variable** for documents (depends on usage)
- Consider disk space when downloading multiple versions
