# Docker Images Configuration

This directory contains Dockerfiles for building custom PHP/Apache images optimized for Dolibarr development. Each Dockerfile is tailored for specific PHP versions and database combinations.

## 📁 Available Dockerfiles

### Generic Images

- **`example.Dockerfile`** - Standard PHP/Apache image configuration

## 🔄 Image Selection

### For Development

- Use `example.Dockerfile` for general development
- Use `php-8.2.Dockerfile` for PHP 8.2 specific testing
- Use `php-7.4.Dockerfile` for legacy compatibility testing

### For Database Testing

- Use `*-pg.Dockerfile` images when testing PostgreSQL compatibility
- Use standard images for MySQL/MariaDB development
