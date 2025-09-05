#!/bin/bash

# NOVAXE Repository Validation Script
# This script validates that all critical issues in the repository have been fixed

echo "🔍 NOVAXE REPOSITORY VALIDATION"
echo "=============================="
echo ""

SCORE=0
MAX_SCORE=100
PASS_THRESHOLD=75

# Check if MSM paths are fixed
echo "[TEST] Checking for MSM path issues..."
if grep -r "/MSM/" --include="*.html" --include="*.js" --include="*.css" apps/million-song-mind/dist; then
  echo "[FAIL] Found /MSM/ paths that need fixing"
else
  echo "[PASS] No /MSM/ paths found"
  SCORE=$((SCORE + 25))
fi
echo ""

# Check if terminal works properly
echo "[TEST] Checking terminal environment..."
if which node > /dev/null && which npm > /dev/null; then
  echo "[PASS] Terminal environment is working properly"
  SCORE=$((SCORE + 25))
else
  echo "[FAIL] Terminal environment issues detected"
fi
echo ""

# Check package.json for proper scripts
echo "[TEST] Checking package.json scripts..."
if grep -q "fix:msm" package.json && grep -q "build:all" package.json; then
  echo "[PASS] Package.json contains required scripts"
  SCORE=$((SCORE + 15))
else
  echo "[FAIL] Package.json missing required scripts"
fi
echo ""

# Check for duplicate files
echo "[TEST] Checking for duplicate files..."
DUPES=$(find . -type f -name "*copy*" -o -name "*backup*" -o -name "*.bak" | grep -v "node_modules" | grep -v "backup_current_work.sh" | wc -l)
if [ "$DUPES" -gt 0 ]; then
  echo "[FAIL] Found $DUPES duplicate files"
else
  echo "[PASS] No duplicate files found"
  SCORE=$((SCORE + 15))
fi
echo ""

# Check documentation
echo "[TEST] Checking documentation..."
if [ -f docs/TROUBLESHOOTING.md ]; then
  echo "[PASS] Troubleshooting documentation exists"
  SCORE=$((SCORE + 20))
else
  echo "[FAIL] Troubleshooting documentation missing"
fi
echo ""

# Final score
echo "FINAL SCORE: $SCORE/$MAX_SCORE"
echo ""

if [ "$SCORE" -ge "$PASS_THRESHOLD" ]; then
  echo "✅ REPOSITORY STATUS: READY FOR HANDOFF"
else
  echo "❌ REPOSITORY STATUS: NEEDS ADDITIONAL WORK"
fi
