#!/bin/bash
# Verify Deployment - Christian's Developer Package
# Comprehensive deployment readiness verification

set -e

echo "🔍 DEPLOYMENT VERIFICATION SYSTEM"
echo "================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

COMPONENTS_READY=0
COMPONENTS_TOTAL=4

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

print_check() {
    echo -e "${BLUE}[CHECK]${NC} $1"
}

print_ready() {
    echo -e "${GREEN}[READY]${NC} $1"
    ((COMPONENTS_READY++))
}

print_not_ready() {
    echo -e "${RED}[NOT READY]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Component 1: Main Site (Documentation)
print_header "MAIN SITE VERIFICATION"
print_check "Checking main documentation..."

if [ -f "README.md" ] && [ -f "package.json" ] && [ -d "docs" ]; then
    if grep -q "CHRISTIAN'S COMPLETE DEVELOPER PACKAGE" README.md; then
        print_ready "Main Site - Documentation complete and accessible"
    else
        print_not_ready "Main Site - Documentation incomplete"
    fi
else
    print_not_ready "Main Site - Missing critical documentation files"
fi

# Component 2: ChordCubes
print_header "CHORDCUBES VERIFICATION"
print_check "Verifying ChordCubes 3D visualization..."

if [ -d "apps/chordcubes" ]; then
    if [ -f "apps/chordcubes/index.html" ] && [ -f "apps/chordcubes/main.js" ]; then
        # Check bundle size (should be around 480KB)
        MAIN_JS_SIZE=$(wc -c < "apps/chordcubes/main.js" 2>/dev/null || echo "0")
        if [ "$MAIN_JS_SIZE" -gt 400000 ]; then
            print_ready "ChordCubes - Complete 3D visualization system ready"
        else
            print_not_ready "ChordCubes - Bundle size too small, may be incomplete"
        fi
    else
        print_not_ready "ChordCubes - Missing core files"
    fi
else
    print_not_ready "ChordCubes - Directory not found"
fi

# Component 3: Million Song Mind React
print_header "MILLION SONG MIND VERIFICATION"
print_check "Verifying Million Song Mind React application..."

if [ -d "apps/million-song-mind" ]; then
    if [ -f "apps/million-song-mind/package.json" ] && [ -f "apps/million-song-mind/index.html" ]; then
        if [ -d "apps/million-song-mind/src" ]; then
            print_ready "Million Song Mind - React application ready for development"
        else
            print_not_ready "Million Song Mind - Source code directory missing"
        fi
    else
        print_not_ready "Million Song Mind - Core application files missing"
    fi
else
    print_not_ready "Million Song Mind - Directory not found"
fi

# Component 4: Unity Landing (Production Systems)
print_header "PRODUCTION SYSTEMS VERIFICATION"
print_check "Verifying production system accessibility..."

PRODUCTION_SYSTEMS_OK=true

# Test production URLs
URLS=(
    "https://millionsongmind.com"
    "https://millionsongmind.com/cubes/"
    "https://millionsongmind.com/MSM/"
)

for url in "${URLS[@]}"; do
    if curl -f -s --max-time 10 "$url" > /dev/null 2>&1; then
        echo "  ✅ $url accessible"
    else
        echo "  ❌ $url not accessible"
        PRODUCTION_SYSTEMS_OK=false
    fi
done

if [ "$PRODUCTION_SYSTEMS_OK" = true ]; then
    print_ready "Production Systems - All systems accessible and operational"
else
    print_not_ready "Production Systems - Some systems not accessible"
fi

# URL Mapping Verification
print_header "URL MAPPING VERIFICATION"
echo "  📍 Main Site: https://millionsongmind.com/"
echo "  📍 ChordCubes: https://millionsongmind.com/cubes/"
echo "  📍 MSM React: https://millionsongmind.com/MSM/"
echo "  📍 Local Dev: http://localhost:8000/ (after npm run dev)"

# Final Results
echo ""
echo "📊 DEPLOYMENT VERIFICATION RESULTS"
echo "=================================="
echo -e "Components Ready: ${GREEN}$COMPONENTS_READY${NC}/${COMPONENTS_TOTAL}"

if [ $COMPONENTS_READY -eq $COMPONENTS_TOTAL ]; then
    echo ""
    echo -e "${GREEN}🎉 ALL SYSTEMS READY FOR DEPLOYMENT! 🎉${NC}"
    echo ""
    echo "✅ Documentation complete"
    echo "✅ ChordCubes 3D visualization ready" 
    echo "✅ Million Song Mind React app ready"
    echo "✅ Production systems operational"
    echo ""
    echo "Christian can proceed with confidence!"
    exit 0
else
    echo ""
    echo -e "${RED}❌ DEPLOYMENT NOT READY${NC}"
    echo "Please address the issues above before proceeding."
    exit 1
fi
