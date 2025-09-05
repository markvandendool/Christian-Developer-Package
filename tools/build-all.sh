#!/bin/bash
# Build All - Christian's Developer Package
# Builds all applications in the package

set -e

echo "🚀 BUILDING ALL APPLICATIONS"
echo "============================"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[BUILD]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Build Million Song Mind React App
if [ -d "apps/million-song-mind" ]; then
    print_status "Building Million Song Mind React App..."
    cd apps/million-song-mind
    if [ -f "package.json" ]; then
        npm install --silent
        npm run build
        print_success "Million Song Mind built successfully"
    else
        echo "⚠️  No package.json found in Million Song Mind"
    fi
    cd ../..
else
    echo "⚠️  Million Song Mind directory not found"
fi

# ChordCubes is static - just verify files exist
if [ -d "apps/chordcubes" ]; then
    print_status "Verifying ChordCubes files..."
    if [ -f "apps/chordcubes/index.html" ]; then
        print_success "ChordCubes files verified"
    else
        echo "❌ ChordCubes index.html missing"
        exit 1
    fi
else
    echo "❌ ChordCubes directory not found"
    exit 1
fi

echo ""
echo "🎉 ALL BUILDS COMPLETE! 🎉"
echo ""
echo "Next steps:"
echo "1. Run 'npm run dev' to start development server"
echo "2. Visit http://localhost:8000/ to test applications"
