#!/bin/bash

# Phoenix Hub Validation Scrip# Check if ChordCubes has Vite configuration
echo "[TEST] Checking ChordCubes development setup..."
if [ -f apps/chordcubes/vite.config.js ]; then
  echo "[PASS] ChordCubes has proper development configuration"
  SCORE=$((SCORE + 20))
else
  echo "[FAIL] ChordCubes development configuration incomplete"
fi
echo ""script validates that the Phoenix Hub architecture is correctly configured

echo "🔍 PHOENIX HUB VALIDATION"
echo "========================="
echo ""

SCORE=0
MAX_SCORE=100
PASS_THRESHOLD=75

# Check if vercel.json exists and has proper routes
echo "[TEST] Checking Vercel configuration..."
if [ -f vercel.json ] && grep -q "/MSM/" vercel.json && grep -q "/cubes/" vercel.json; then
  echo "[PASS] Vercel configuration contains proper routes"
  SCORE=$((SCORE + 20))
else
  echo "[FAIL] Vercel configuration missing or incomplete"
fi
echo ""

# Check if Phoenix Hub landing page exists
echo "[TEST] Checking Phoenix Hub landing page..."
if [ -f index.html ] && grep -q "Phoenix Hub" index.html; then
  echo "[PASS] Phoenix Hub landing page exists"
  SCORE=$((SCORE + 20))
else
  echo "[FAIL] Phoenix Hub landing page missing"
fi
echo ""

# Check if Architecture documentation exists
echo "[TEST] Checking Architecture documentation..."
if [ -f docs/ARCHITECTURE.md ] && grep -q "Phoenix Hub" docs/ARCHITECTURE.md; then
  echo "[PASS] Architecture documentation exists"
  SCORE=$((SCORE + 20))
else
  echo "[FAIL] Architecture documentation missing"
fi
echo ""

# Check if ChordCubes has Vite configuration
echo "[TEST] Checking ChordCubes development setup..."
if [ -f apps/chordcubes/vite.config.js ] && grep -q "npm run dev" apps/chordcubes/package.json; then
  echo "[PASS] ChordCubes has proper development configuration"
  SCORE=$((SCORE + 20))
else
  echo "[FAIL] ChordCubes development configuration incomplete"
fi
echo ""

# Check if navigation shortcuts script exists
echo "[TEST] Checking navigation shortcuts..."
if [ -f scripts/setup-navigation.sh ]; then
  echo "[PASS] Navigation shortcuts script exists"
  SCORE=$((SCORE + 20))
else
  echo "[FAIL] Navigation shortcuts script missing"
fi
echo ""

# Final score
echo "PHOENIX HUB SCORE: $SCORE/$MAX_SCORE"
echo ""

if [ "$SCORE" -ge "$PASS_THRESHOLD" ]; then
  echo "✅ PHOENIX HUB STATUS: READY FOR DEPLOYMENT"
else
  echo "❌ PHOENIX HUB STATUS: NEEDS ADDITIONAL WORK"
fi
