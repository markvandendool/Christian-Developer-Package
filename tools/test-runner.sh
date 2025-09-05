#!/bin/bash
# Test Runner - Christian's Developer Package  
# Runs basic tests to verify package functionality

set -e

echo "🧪 CHRISTIAN'S DEVELOPER PACKAGE TESTS"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

TESTS_PASSED=0
TESTS_FAILED=0

print_test() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

print_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((TESTS_PASSED++))
}

print_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((TESTS_FAILED++))
}

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Test 1: Directory Structure
print_test "Checking directory structure..."
if [ -d "apps/chordcubes" ] && [ -d "apps/million-song-mind" ] && [ -d "docs" ] && [ -d "tools" ]; then
    print_pass "Directory structure is correct"
else
    print_fail "Directory structure is missing required folders"
fi

# Test 2: Required Files
print_test "Checking required files exist..."
REQUIRED_FILES=(
    "README.md"
    "package.json"
    "apps/chordcubes/index.html"
    "apps/million-song-mind/package.json"
    "tools/setup.sh"
    "tools/health-check.sh"
)

ALL_FILES_EXIST=true
for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        print_fail "Required file missing: $file"
        ALL_FILES_EXIST=false
    fi
done

if [ "$ALL_FILES_EXIST" = true ]; then
    print_pass "All required files exist"
fi

# Test 3: ChordCubes Static Files
print_test "Testing ChordCubes static files..."
if [ -f "apps/chordcubes/main.js" ] && [ -f "apps/chordcubes/styles.css" ]; then
    print_pass "ChordCubes core files present"
else
    print_fail "ChordCubes missing core files"
fi

# Test 4: Million Song Mind Dependencies
print_test "Testing Million Song Mind setup..."
if [ -d "apps/million-song-mind/node_modules" ]; then
    print_pass "Million Song Mind dependencies installed"
else
    print_fail "Million Song Mind dependencies not installed (run 'npm install' in apps/million-song-mind)"
fi

# Test 5: Production Systems Accessibility
print_test "Testing production system accessibility..."
if curl -f -s https://millionsongmind.com > /dev/null 2>&1; then
    print_pass "millionsongmind.com is accessible"
else
    print_fail "millionsongmind.com is not accessible"
fi

# Test 6: Tools Executability
print_test "Testing tool executability..."
if [ -x "tools/setup.sh" ] && [ -x "tools/health-check.sh" ]; then
    print_pass "Tools are executable"
else
    print_fail "Tools are not executable (run 'chmod +x tools/*.sh')"
fi

# Test 7: Package.json Scripts
print_test "Testing package.json script references..."
SCRIPT_ERRORS=false
if ! npm run --silent 2>/dev/null | grep -q "dev\|start\|health-check\|build\|test"; then
    print_fail "Package.json scripts may have issues"
    SCRIPT_ERRORS=true
fi

if [ "$SCRIPT_ERRORS" = false ]; then
    print_pass "Package.json scripts are properly defined"
fi

# Results Summary
echo ""
echo "📊 TEST RESULTS SUMMARY"
echo "======================="
echo -e "Tests Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests Failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 ALL TESTS PASSED! Package is ready for use.${NC}"
    exit 0
else
    echo -e "${RED}❌ $TESTS_FAILED tests failed. Please fix issues before proceeding.${NC}"
    exit 1
fi
