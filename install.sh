#!/bin/bash

REPO_URL="https://github.com/navidgs/ool.git"

git clone $REPO_URL

cd ool

# Make the main script executable
chmod +x ool

# Create a bin directory in your home directory if it doesn't exist
mkdir -p ~/bin

cd ..
mv ool ~/bin

echo "OOL CLI tool has been installed to ~/bin"

# add ~/bin to the PATH in your shell profile
echo 'export PATH="$PATH:$HOME/bin"' >> ~/.zshrc

