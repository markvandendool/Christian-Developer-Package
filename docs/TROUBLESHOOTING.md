# Troubleshooting Guide

## Terminal Issues

If you're experiencing terminal issues, they may be related to Python virtual environment interference or shell configuration problems.

### Terminal Not Executing Commands Properly

**Symptoms:**
- Terminal treating comments as commands
- Error messages related to pyenv or virtualenv
- Commands not executing as expected

**Solution:**

```bash
# Reset your shell environment
unset PYENV_VERSION
unset VIRTUAL_ENV
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# If you're using zsh and having issues
exec /bin/bash --noprofile --norc

# Test if basic commands work
echo "Testing terminal..."
which node
which npm
npm --version
```

## MSM Deployment Issues

### Vercel Security Checkpoint

**Symptoms:**
- millionsongmind.com shows Vercel security checkpoint
- Assets failing to load with 404 errors
- Paths in HTML/JS files contain /MSM/ prefix

**Solution:**

1. Update vercel.json to include proper routes and rewrites:
```json
{
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/$1",
      "headers": {
        "X-Frame-Options": "SAMEORIGIN"
      }
    }
  ],
  "rewrites": [
    { "source": "/MSM/(.*)", "destination": "/$1" }
  ]
}
```

2. Run the MSM path fixer script:
```bash
npm run fix:msm
```

## Build and Installation Problems

### Node.js Version Issues

**Symptoms:**
- Build fails with syntax errors
- Incompatible dependency warnings

**Solution:**
Use Node.js version 18 or higher:
```bash
# If using nvm
nvm install 18
nvm use 18

# Verify version
node --version
```

### Missing Dependencies

**Symptoms:**
- Module not found errors
- Failed imports when running applications

**Solution:**
```bash
# Root dependencies
npm install

# ChordCubes dependencies
cd apps/chordcubes
npm install

# MSM dependencies
cd ../million-song-mind
npm install
```

## Repository Structure Issues

If you're having trouble finding files or understanding the repository structure:

```bash
# List main directories
ls -la

# Show apps
ls -la apps/

# Show tools
ls -la tools/
```

The repository should have this structure:
- `apps/` - Contains all applications (ChordCubes, MSM, etc.)
- `tools/` - Contains utility scripts
- `docs/` - Documentation
- `scripts/` - Fix and utility scripts

## Phoenix Hub Architecture

### Understanding the Path Structure

The millionsongmind.com domain uses a hub architecture with the following paths:
- Main domain (`/`): Phoenix Hub landing page
- `/cubes/`: ChordCubes application
- `/MSM/`: Million Song Mind application

If you're experiencing issues with these paths:

```bash
# Fix MSM paths in built files
npm run fix:msm

# Check deployment configuration
cat vercel.json
```

### Navigation Shortcuts

For easier navigation in the terminal, set up navigation shortcuts:

```bash
# Run the navigation setup script
./scripts/setup-navigation.sh

# Activate the shortcuts
source ~/.zshrc

# Now you can use:
cdcp        # Go to Christian Developer Package root
cdcp-cubes  # Go to ChordCubes app directory
cdcp-msm    # Go to Million Song Mind app directory
```

### Local Development

If you're having issues running the applications locally:

```bash
# Install dependencies for all apps
npm install
cd apps/chordcubes && npm install
cd ../million-song-mind && npm install
cd ../..

# Run development servers for all apps
npm run dev:all

# Or run individual apps:
npm run dev:cubes
npm run dev:msm
```
