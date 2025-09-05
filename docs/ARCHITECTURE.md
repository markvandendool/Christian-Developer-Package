# Phoenix Hub Architecture

## Overview
The millionsongmind.com domain hosts Phoenix Hub, a central portal for all Novaxe music applications. This architecture provides a unified entry point while maintaining separate codebases for each application.

## Structure
- **Main Domain**: millionsongmind.com → Phoenix Hub (portal/landing page)
- **Sub-paths**:
  - `/cubes/` → ChordCubes application
  - `/MSM/` → Million Song Mind application
  - `/novaxe/` → Novaxe main application (future integration)

## Repository Organization
```
Christian-Developer-Package/
├── apps/
│   ├── chordcubes/          # ChordCubes application 
│   │   └── ...
│   └── million-song-mind/   # Million Song Mind application
│       └── ...
├── tools/                   # Utility scripts for the entire ecosystem
├── scripts/                 # Scripts for building, fixing paths, etc.
└── docs/                    # Documentation
```

## Local Development
Each app can be developed independently:
- **Million Song Mind**: Uses Vite for development
  - Command: `npm run dev` in apps/million-song-mind
  - Runs on port 5173 (Vite default)
- **ChordCubes**: Currently uses Python HTTP server
  - Command: `npm run dev` in apps/chordcubes
  - Runs on port 5173 (configured in package.json)

**Developing Multiple Apps Simultaneously**:
```bash
# From the root directory
npm run dev:all  # Runs both apps concurrently
```

## Deployment
All apps deploy to Vercel under the millionsongmind.com domain with different paths:
- Phoenix Hub: Main domain (/)
- ChordCubes: /cubes/
- Million Song Mind: /MSM/

### Deployment Process
1. Build all applications: `npm run build:all`
2. Fix MSM paths if needed: `npm run fix:msm`
3. Deploy to Vercel: `npm run deploy`

## Important Notes
- The `/MSM/` path prefix is intentional and required for the Million Song Mind app
- The path fixing script (`fix-msm-paths.js`) ensures all assets are correctly referenced

## Health Check
Run the health check script to verify all systems are operational:
```bash
npm run health-check
```

## Troubleshooting
For common issues and their solutions, refer to [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
