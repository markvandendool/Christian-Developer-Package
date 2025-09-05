// Emergency MSM path fixer
const fs = require('fs');
const path = require('path');

// Fix all MSM asset paths
const fixMSMPaths = () => {
  const distPath = './apps/million-song-mind/dist';
  const htmlFile = path.join(distPath, 'index.html');
  
  if (fs.existsSync(htmlFile)) {
    let content = fs.readFileSync(htmlFile, 'utf8');
    // Remove /MSM/ prefix from all paths
    content = content.replace(/\/MSM\//g, '/');
    fs.writeFileSync(htmlFile, content);
    console.log('✅ Fixed MSM paths in index.html');
  } else {
    console.log('❌ HTML file not found at: ' + htmlFile);
    return;
  }
  
  // Fix JS files
  if (fs.existsSync(path.join(distPath, 'assets'))) {
    const jsFiles = fs.readdirSync(path.join(distPath, 'assets'))
      .filter(f => f.endsWith('.js'));
    
    jsFiles.forEach(file => {
      const filePath = path.join(distPath, 'assets', file);
      let content = fs.readFileSync(filePath, 'utf8');
      content = content.replace(/\/MSM\//g, '/');
      fs.writeFileSync(filePath, content);
      console.log(`✅ Fixed paths in ${file}`);
    });
    
    // Fix CSS files
    const cssFiles = fs.readdirSync(path.join(distPath, 'assets'))
      .filter(f => f.endsWith('.css'));
    
    cssFiles.forEach(file => {
      const filePath = path.join(distPath, 'assets', file);
      let content = fs.readFileSync(filePath, 'utf8');
      content = content.replace(/\/MSM\//g, '/');
      fs.writeFileSync(filePath, content);
      console.log(`✅ Fixed paths in ${file}`);
    });
  } else {
    console.log('❌ Assets directory not found');
  }
};

fixMSMPaths();
