# Custom Dolibarr Modules and Extensions

This directory contains custom Dolibarr modules, themes, and extensions that are shared across all Dolibarr versions in the development environment. It serves as a centralized location for custom development work.

## 📁 Directory Structure

```
custom/
├── mymodule/                # Custom module
│   ├── admin/               # Module administration files
│   ├── class/               # PHP classes and business logic
│   ├── core/modules/        # Core module files
│   ├── css/                 # Custom stylesheets
│   ├── img/                 # Module images and icons
│   ├── js/                  # JavaScript files
│   ├── langs/               # Language translations
│   │   ├── en_US/           # English translations
│   │   └── fr_FR/           # French translations
│   ├── lib/                 # Library files
│   ├── sql/                 # Database scripts
│   └── tpl/                 # Template files
├── mysecondmodule/          # Your custom module
├── mytheme/                 # Your custom theme
└── readme.md                # This file
```

## 🚀 Module Development

### Shared Across Versions

All content in this directory is automatically mounted to `/var/www/html/custom` in every Dolibarr container, making your modules available across all versions:

- **Dolibarr 21.0.2**: http://dlb2102.localhost/custom/
- **Dolibarr 20.0.2**: http://dlb2002.localhost/custom/
- **Dolibarr 19.0.4**: http://dlb1904.localhost/custom/

### Module Structure

Follow Dolibarr's standard module structure:

```
mymodule/
├── admin/
│   ├── about.php           # About page
│   └── setup.php           # Configuration page
├── class/
│   └── myclass.class.php   # Main class
├── core/modules/
│   └── modMyModule.class.php # Module descriptor
├── css/
│   └── mymodule.css        # Module styles
├── img/
│   ├── mymodule.png        # Module icon (32x32)
│   └── object_mymodule.png # Object icon (16x16)
├── js/
│   └── mymodule.js         # JavaScript functionality
├── langs/
│   ├── en_US/
│   │   └── mymodule.lang   # English translations
│   └── fr_FR/
│       └── mymodule.lang   # French translations
├── lib/
│   └── mymodule.lib.php    # Utility functions
├── sql/
│   ├── llx_mymodule.sql    # Table creation
│   └── llx_mymodule.key.sql # Keys and indexes
└── myobject.php            # Main object page
```

### Development Testing

### Cross-Version Testing

```bash
# Test module in different versions
make up_dolibarr v=21.0.2  # Test in latest version
make up_dolibarr v=20.0.2  # Test in previous version
make up_dolibarr v=19.0.4  # Test in older version
```

## ⚠️ Important Notes

- **Shared Storage**: All files are shared across Dolibarr versions
- **Version Compatibility**: Test modules with all target Dolibarr versions
- **File Permissions**: Ensure proper read/write permissions
- **Backup Strategy**: Regularly backup custom development work
- **Naming Conventions**: Follow Dolibarr naming standards
- **Documentation**: Document your modules for future maintenance
- **Security**: Never store sensitive data in version control
- **Performance**: Monitor impact on overall system performance
