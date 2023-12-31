#!/bin/bash

# Define the GitHub repository URL
GITHUB_REPO="https://github.com/zhk3r/check.git"
# Define the directory to clone the repository into
INSTALL_DIR="$HOME/check"
# Clone the GitHub repository
git clone "$GITHUB_REPO" "$INSTALL_DIR"
# Change to the installation directory
cd "$INSTALL_DIR"
# Set execute permissions on rdns.py, hostguess.py and update_check.sh
chmod +x rdns.py hostguess.py update_check.sh
# Update .zshrc with specific configurations
ZSHRC_FILE="$HOME/.zshrc"
TEMP_ZSHRC=$(mktemp)
cat $ZSHRC_FILE > $TEMP_ZSHRC

# Check if the 'check_function.zsh' line already exists and add if not
if ! grep -q "source $INSTALL_DIR/check_function.zsh" $ZSHRC_FILE; then
    sed -i "/source \$ZSH\/oh-my-zsh.sh/a source $INSTALL_DIR/check_function.zsh" $TEMP_ZSHRC
fi

# Check if the 'export PATH' line already exists and add if not
if ! grep -q "export PATH=\"check:\$PATH\"" $ZSHRC_FILE; then
    sed -i "/export ZSH=\"\$HOME\/.oh-my-zsh\"/a export PATH=\"check:\$PATH\"" $TEMP_ZSHRC
fi

# Update the original .zshrc file
mv $TEMP_ZSHRC $ZSHRC_FILE
# Restart shell
source ZSHRC_FILE

# Download the simple-path theme from the wsl repository
curl -fsSL https://raw.githubusercontent.com/zhk3r/wsl/main/simple-path.zsh-theme -o "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/simple-path.zsh-theme"

# Update ZSH_THEME in .zshrc to use 'simple-path'
sed -i 's/^ZSH_THEME="robbyrussell"/ZSH_THEME="simple-path"/' $HOME/.zshrc

# Restart shell
exec zsh
