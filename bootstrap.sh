# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  sleep 0.1
  source brew/install.sh
else
  echo "Homebrew already installed."
fi

# Install diferrent Formulaes and Casks using xargs with Homebrew's install command
# (using grep to ignore commented lines with #)
echo "Installing Formulaes..."
sleep 0.1
while read -r formula; do
  [[ -z "$formula" || "$formula" =~ ^\s*# ]] && continue
  echo "Installing: $formula"
  brew install $formula || echo "Failed to install: $formula"
done < formulaes.txt

echo "Installing Casks..."
sleep 0.1
while read -r cask; do
  [[ -z "$cask" || "$cask" =~ ^\s*# ]] && continue
  echo "Installing: $cask"
  brew install $cask || echo "Failed to install: $cask"
done < casks.txt
# brew bundle install --file=$HOME/.dotfiles/Brewfile
    
source bar/progressBar.sh


# Setup Nextcloud's VFS configuration
echo "Setting up Nextcloud..."
source nextcloud/setup.sh
display_dynamic_progress_bar 10 

# Setup LibreWolf customization
echo "Setting up LibreWolf..."
source chrome/setup.sh
display_dynamic_progress_bar 12

# Setup configuration for Aerospace tiling window manager
echo "Setting up configuration for Aerospace..."
source aerospace/setup.sh
display_dynamic_progress_bar 20

# Setup configuration for Hammerspoon
echo "Setting up configuration for Hammerspoon..."
source hammerspoon/setup.sh
display_dynamic_progress_bar 30

# Setup java symlink
echo "Setting up Java..." 
source java/setup.sh
display_dynamic_progress_bar 6

# Setup configuration for WezTerm
echo "Setting up configuration for WezTerm..."
source wezterm/setup.sh
display_dynamic_progress_bar 10

# Setup configuration for yazi
echo "Setting up configuration for yazi..."
source yazi/setup.sh
display_dynamic_progress_bar 20

# Setup .zshrc configuration
echo "Setting up tmux configuration..."
source tmux/setup.sh
display_dynamic_progress_bar 15

# Setup .zshrc configuration
echo "Setting up nvim configuration..."
source nvim/setup.sh
display_dynamic_progress_bar 25

# Setup .zshrc configuration
echo "Setting up zsh configuration..."
source zsh/setup.sh
display_dynamic_progress_bar 15

# Setup scripts from bin/ directory to /usr/local/bin/
echo "Setting up symlinks for bin/ scripts... Please enter your password if prompted."
source bin/setup.sh
display_dynamic_progress_bar 20

echo "Bootstrapping complete!

Next Steps: Set Up macOS config, run the following in your terminal:

source macos/setup.sh
"

# typeset -g POWERLEVEL9K_BATTERY_STAGES='\UF008E\UF007A\UF007B\UF007C\UF007D\UF007E\UF007F\UF0080\UF0081\UF0082\UF0079'
# https://github.com/Asthestarsfalll/img2art
