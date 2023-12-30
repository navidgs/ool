#!/bin/bash

REPO_URL="https://github.com/navidgs/ool.git"

git clone $REPO_URL

cd ool

# Make the main script executable
chmod +x ool

# Move to a directory in the PATH
cd ..
mv ool /usr/local/bin

# Provide feedback to the user
echo "ool has been installed to /usr/local/bin"
