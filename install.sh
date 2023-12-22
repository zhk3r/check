#!/bin/bash

# Define the GitHub repository URL
GITHUB_REPO="https://github.com/zhk3r/check.git"

# Define the directory to clone the repository into
INSTALL_DIR="$HOME/check"

# Clone the GitHub repository
git clone "$GITHUB_REPO" "$INSTALL_DIR"

# Change to the installation directory
cd "$INSTALL_DIR"

# Set execute permissions on rdns.py and update_check.sh
chmod +x rdns.py update_check.sh

# Update .zshrc with specific configurations
ZSHRC_FILE="$HOME/.zshrc"
TEMP_ZSHRC=$(mktemp)
cat $ZSHRC_FILE > $TEMP_ZSHRC

# Add the new line beneath 'source $ZSH/oh-my-zsh.sh'
sed -i "/source \$ZSH\/oh-my-zsh.sh/a source $INSTALL_DIR/check_function.zsh" $TEMP_ZSHRC

# Add the new line beneath 'export ZSH="$HOME/.oh-my-zsh"'
sed -i "/export ZSH=\"\$HOME\/.oh-my-zsh\"/a export PATH=\"check:\$PATH\"" $TEMP_ZSHRC

# Update the original .zshrc file
mv $TEMP_ZSHRC $ZSHRC_FILE

# Refresh .zshrc to apply changes
source $ZSHRC_FILE