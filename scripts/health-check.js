// Repository Health Check Script
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🔍 REPOSITORY HEALTH CHECK');
console.log('============================');

// Score tracking
let score = 0;
const MAX = 100;

// Helper function to run shell commands safely
function runCommand(command) {
  try {
    return execSync(command, { encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] });
  } catch (error) {
    return '';
  }
}

// Test 1: Repository Structure (20 points)
console.log('\n📁 Checking repository structure...');
const hasCubes = fs.existsSync(path.join(__dirname, '../apps/chordcubes'));
const hasMSM = fs.existsSync(path.join(__dirname, '../apps/million-song-mind'));

if (hasCubes && hasMSM) {
  console.log('✅ Repository structure valid (+20)');
  score += 20;
} else {
  console.log('❌ Repository structure invalid');
  if (!hasCubes) console.log('  Missing ChordCubes app');
  if (!hasMSM) console.log('  Missing Million Song Mind app');
}

// Test 2: No duplicate files (10 points)
console.log('\n🔍 Checking for duplicate files...');
const dupeCommand = 'find . -name "*.backup" -o -name "*.bak" | wc -l';
const dupes = parseInt(runCommand(dupeCommand).trim());

if (dupes === 0) {
  console.log('✅ No duplicate files (+10)');
  score += 10;
} else {
  console.log(`❌ Found ${dupes} duplicate files`);
}

// Test 3: MSM paths (20 points)
console.log('\n🔍 Checking MSM paths...');
const msmDistPath = path.join(__dirname, '../apps/million-song-mind/dist');

if (fs.existsSync(msmDistPath)) {
  const htmlFile = path.join(msmDistPath, 'index.html');
  if (fs.existsSync(htmlFile)) {
    const content = fs.readFileSync(htmlFile, 'utf8');
    const msmPaths = (content.match(/\/MSM\//g) || []).length;
    
    if (msmPaths === 0) {
      console.log('✅ MSM paths fixed (+20)');
      score += 20;
    } else {
      console.log(`❌ Found ${msmPaths} MSM path issues`);
    }
  } else {
    console.log('❌ MSM dist/index.html not found');
  }
} else {
  console.log('❌ MSM dist directory not found');
}

// Test 4: Documentation accurate (20 points)
console.log('\n📝 Checking documentation...');
const readmePath = path.join(__dirname, '../README.md');
let docScore = 0;

if (fs.existsSync(readmePath)) {
  const content = fs.readFileSync(readmePath, 'utf8');
  
  if (content.includes('ACTUAL SETUP TIME')) {
    console.log('✅ Setup time is honest (+5)');
    docScore += 5;
  }
  
  if (!content.includes('5-MINUTE QUICK START')) {
    console.log('✅ No false quick start claims (+5)');
    docScore += 5;
  }
  
  if (content.includes('KNOWN ISSUES')) {
    console.log('✅ Known issues documented (+5)');
    docScore += 5;
  }
  
  if (fs.existsSync(path.join(__dirname, '../docs/TROUBLESHOOTING.md'))) {
    console.log('✅ Troubleshooting guide exists (+5)');
    docScore += 5;
  }
  
  console.log(`✅ Documentation score: ${docScore}/20 (+${docScore})`);
  score += docScore;
} else {
  console.log('❌ README.md not found');
}

// Test 5: package.json configuration (30 points)
console.log('\n📦 Checking package.json configuration...');
const pkgPath = path.join(__dirname, '../package.json');
let pkgScore = 0;

if (fs.existsSync(pkgPath)) {
  const pkg = require(pkgPath);
  
  if (pkg.scripts && pkg.scripts['dev:all']) {
    console.log('✅ dev:all script exists (+10)');
    pkgScore += 10;
  }
  
  if (pkg.scripts && pkg.scripts['build:all']) {
    console.log('✅ build:all script exists (+10)');
    pkgScore += 10;
  }
  
  if (pkg.scripts && pkg.scripts['fix:msm']) {
    console.log('✅ fix:msm script exists (+10)');
    pkgScore += 10;
  }
  
  console.log(`✅ Package.json score: ${pkgScore}/30 (+${pkgScore})`);
  score += pkgScore;
} else {
  console.log('❌ package.json not found');
}

// Final score
console.log('\n============================');
console.log(`FINAL SCORE: ${score}/${MAX}`);
console.log('============================\n');

if (score >= 80) {
  console.log('✅ REPOSITORY IS READY FOR HANDOFF');
} else if (score >= 60) {
  console.log('⚠️ REPOSITORY NEEDS MINOR FIXES');
} else {
  console.log('❌ REPOSITORY HAS CRITICAL ISSUES');
}

// Exit with status code based on score
process.exit(score < 60 ? 1 : 0);
