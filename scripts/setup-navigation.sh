#!/bin/zsh

# This script adds a handy shortcut to navigate to the Christian Developer Package
# It creates an alias 'cdcp' that can be used from anywhere in the terminal

# Define the path to the Christian Developer Package
CDP_PATH="$HOME/Christian-Developer-Package"

# Check if the directory exists
if [ ! -d "$CDP_PATH" ]; then
  echo "❌ Error: Christian Developer Package not found at $CDP_PATH"
  exit 1
fi

# Add the alias to .zshrc if it doesn't already exist
if ! grep -q "alias cdcp=" ~/.zshrc; then
  echo '\n# Christian Developer Package shortcut' >> ~/.zshrc
  echo 'alias cdcp="cd ~/Christian-Developer-Package"' >> ~/.zshrc
  echo '✅ Added shortcut: Use "cdcp" to navigate to Christian Developer Package'
  echo '   Please run "source ~/.zshrc" to activate the shortcut'
else
  echo '✅ Shortcut already exists: Use "cdcp" to navigate to Christian Developer Package'
fi

# Create additional navigation shortcuts for each app
if ! grep -q "alias cdcp-cubes=" ~/.zshrc; then
  echo 'alias cdcp-cubes="cd ~/Christian-Developer-Package/apps/chordcubes"' >> ~/.zshrc
  echo '✅ Added shortcut: Use "cdcp-cubes" to navigate to ChordCubes'
fi

if ! grep -q "alias cdcp-msm=" ~/.zshrc; then
  echo 'alias cdcp-msm="cd ~/Christian-Developer-Package/apps/million-song-mind"' >> ~/.zshrc
  echo '✅ Added shortcut: Use "cdcp-msm" to navigate to Million Song Mind'
fi

echo "\n🚀 Navigation shortcuts ready! Use the following commands:"
echo "   cdcp        - Go to Christian Developer Package root"
echo "   cdcp-cubes  - Go to ChordCubes app directory"
echo "   cdcp-msm    - Go to Million Song Mind app directory"
echo "\n⚠️  Remember to run 'source ~/.zshrc' to activate these shortcuts"
