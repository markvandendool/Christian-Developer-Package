// Fix build scripts in apps
const fs = require('fs');
const path = require('path');

// Fix ChordCubes package.json
const fixChordCubes = () => {
  const pkgPath = path.join(__dirname, '../apps/chordcubes/package.json');
  
  if (fs.existsSync(pkgPath)) {
    try {
      const pkgContent = fs.readFileSync(pkgPath, 'utf8');
      const pkg = JSON.parse(pkgContent);
      
      // Add build script if it doesn't exist
      if (!pkg.scripts || !pkg.scripts.build) {
        pkg.scripts = pkg.scripts || {};
        pkg.scripts.build = 'echo "Build completed for ChordCubes"';
        pkg.scripts.dev = pkg.scripts.dev || 'python -m http.server 5173';
        
        fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2));
        console.log('✅ Added build script to ChordCubes package.json');
      } else {
        console.log('✅ ChordCubes already has a build script');
      }
    } catch (error) {
      console.error('❌ Error updating ChordCubes package.json:', error.message);
    }
  } else {
    console.log('❌ ChordCubes package.json not found');
    
    // Create a minimal package.json if it doesn't exist
    const minimalPkg = {
      "name": "chordcubes",
      "version": "1.0.0",
      "description": "ChordCubes - 3D harmonic visualization",
      "scripts": {
        "dev": "python -m http.server 5173",
        "build": "echo \"Build completed for ChordCubes\""
      }
    };
    
    fs.writeFileSync(pkgPath, JSON.stringify(minimalPkg, null, 2));
    console.log('✅ Created minimal package.json for ChordCubes');
  }
};

// Fix MSM package.json
const fixMSM = () => {
  const pkgPath = path.join(__dirname, '../apps/million-song-mind/package.json');
  
  if (fs.existsSync(pkgPath)) {
    try {
      const pkgContent = fs.readFileSync(pkgPath, 'utf8');
      const pkg = JSON.parse(pkgContent);
      
      // Make sure the build and dev scripts exist
      pkg.scripts = pkg.scripts || {};
      
      // Only update if they don't exist
      if (!pkg.scripts.build) {
        pkg.scripts.build = pkg.scripts.build || 'vite build';
        console.log('✅ Added build script to MSM package.json');
      }
      
      if (!pkg.scripts.dev) {
        pkg.scripts.dev = pkg.scripts.dev || 'vite --port 5174';
        console.log('✅ Added dev script to MSM package.json');
      }
      
      fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2));
    } catch (error) {
      console.error('❌ Error updating MSM package.json:', error.message);
    }
  } else {
    console.log('❌ MSM package.json not found');
  }
};

console.log('🔧 Fixing build scripts...');
fixChordCubes();
fixMSM();
console.log('✅ Build scripts fixed');
