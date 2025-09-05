// Clean duplicate files script
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🧹 Cleaning duplicate files...');

// Find all backup and .bak files
const findDuplicates = () => {
  try {
    const output = execSync('find . -name "*.backup" -o -name "*.bak"', { 
      encoding: 'utf8',
      cwd: path.join(__dirname, '..')
    });
    
    return output.trim().split('\n').filter(Boolean);
  } catch (error) {
    console.error('Error finding duplicate files:', error.message);
    return [];
  }
};

// Delete the found files
const deleteDuplicates = (files) => {
  if (files.length === 0) {
    console.log('✅ No duplicate files found');
    return;
  }
  
  console.log(`Found ${files.length} duplicate files to remove:`);
  
  files.forEach(file => {
    try {
      const fullPath = path.join(__dirname, '..', file);
      fs.unlinkSync(fullPath);
      console.log(`✅ Removed: ${file}`);
    } catch (error) {
      console.error(`❌ Failed to remove ${file}: ${error.message}`);
    }
  });
  
  console.log('✅ Cleanup complete');
};

// Run the cleanup
const duplicateFiles = findDuplicates();
deleteDuplicates(duplicateFiles);
