#!/bin/bash
# Final validation before handoff

echo "🔍 FINAL VALIDATION CHECKLIST"
echo "=============================="

# Score tracking
SCORE=0
MAX=100

# Test 1: Repository Structure (20 points)
if [ -d "apps/chordcubes" ] && [ -d "apps/million-song-mind" ]; then
  echo "✅ Repository structure valid (+20)"
  SCORE=$((SCORE + 20))
else
  echo "❌ Repository structure invalid"
fi

# Test 2: No duplicate files (10 points)
DUPES=$(find . -name "*.backup" -o -name "*.bak" | wc -l)
if [ $DUPES -eq 0 ]; then
  echo "✅ No duplicate files (+10)"
  SCORE=$((SCORE + 10))
else
  echo "❌ Found $DUPES duplicate files"
fi

# Test 3: MSM paths fixed (20 points)
if ! grep -r "/MSM/" apps/million-song-mind/dist 2>/dev/null; then
  echo "✅ MSM paths fixed (+20)"
  SCORE=$((SCORE + 20))
else
  echo "❌ MSM paths still broken"
fi

# Test 4: Documentation accurate (20 points)
if grep -q "ACTUAL SETUP TIME" README.md; then
  echo "✅ Documentation updated (+20)"
  SCORE=$((SCORE + 20))
else
  echo "❌ Documentation still contains lies"
fi

# Test 5: Build works (30 points)
if npm run build:all 2>/dev/null; then
  echo "✅ Build successful (+30)"
  SCORE=$((SCORE + 30))
else
  echo "❌ Build failed"
fi

echo ""
echo "=============================="
echo "FINAL SCORE: $SCORE/$MAX"
echo ""

if [ $SCORE -ge 80 ]; then
  echo "✅ READY FOR HANDOFF"
elif [ $SCORE -ge 60 ]; then
  echo "⚠️ NEEDS MINOR FIXES"
else
  echo "❌ NOT READY - CRITICAL ISSUES REMAIN"
fi
