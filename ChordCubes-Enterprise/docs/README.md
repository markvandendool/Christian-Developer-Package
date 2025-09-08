# ChordCubes V1.50 Gold - Enterprise Edition

**Military-Grade Web Application for 3D Music Theory Visualization**

## Overview

ChordCubes is an advanced 3D visualization tool for harmonic relationships in music theory. This enterprise-grade deployment package follows industry best practices for development, staging, and production environments.

## Project Structure

```
ChordCubes-Enterprise/
├── production/          # Production-ready code (GOLD MASTER)
│   └── src/             # Production source files
├── staging/             # Staging environment for pre-production testing
│   └── src/             # Staging source files
├── development/         # Development environment for active development
│   └── src/             # Development source files
├── deployments/         # Deployment packages with SHA-256 verification
├── backups/             # Daily backups with timestamp versioning
├── config/              # Configuration files and server PIDs
├── logs/                # Environment-specific logs with timestamps
├── docs/                # Project documentation
└── scripts/             # Deployment and utility scripts
```

## Deployment Instructions

### Quick Start

```bash
# Navigate to the scripts directory
cd /Users/markvandendool/ChordCubes-Enterprise/scripts

# Make the deployment script executable
chmod +x deploy-enterprise.sh

# Run the enterprise deployment
./deploy-enterprise.sh
```

### Accessing Environments

- **Production:** http://localhost:9000
- **Staging:** http://localhost:9001
- **Development:** http://localhost:9002

## Features

- **12-stage Pipeline Tracer HUD:** Visualize chord progressions in real-time
- **Forensic Keyboard Debugger:** Advanced MIDI and keyboard input analysis
- **Font Jan16 Support:** Specialized music notation with ligature support
- **3D Harmonic Visualization:** Interactive chord relationships in 3D space

## Security and Verification

All deployment packages include SHA-256 verification and are backed up with timestamp versioning. The deployment script ensures proper server management with dedicated process tracking and logging.

## Environment Management

Each environment is isolated with its own:
- Source code
- Server process
- Port assignment
- Log files
- Version identifier in the HTML title

## Developer Onboarding

New developers should:

1. Clone the repository
2. Use the development environment only (`/development/src/`)
3. Test changes in staging before requesting production deployment
4. Follow the strict deployment workflow through the `deploy-enterprise.sh` script

## Maintenance

Regular maintenance tasks are documented in the maintenance section of this documentation. All deployments and backups are automated through the deployment script.

## Version History

- **V1.50 Gold:** Enterprise-ready release with 12-stage Pipeline Tracer HUD
- **V1.49:** Pre-release with transport bridge implementation
- **V1.30-1.32:** Development versions with font improvements

## License and Copyright

© 2025 ChordCubes Enterprise. All rights reserved.

*This documentation was last updated on September 8, 2025.*
