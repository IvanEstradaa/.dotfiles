# Install Homebrew
echo "Installing Homebrew..."
sleep 0.1
source brew/install.sh

# Install diferrent Formulaes and Casks using xargs with Homebrew's install command
# (using grep to ignore commented lines with #)
echo "Installing Formulaes..."
sleep 0.1
grep -v '^\s*#' formulaes.txt | xargs brew install

echo "Installing Casks..."
sleep 0.1
grep -v '^\s*#' casks.txt | xargs brew install --cask

    
source bar/progressBar.sh


# Setup Nextcloud's VFS configuration
echo "Setting up Nextcloud..."
source nextcloud/setup.sh
display_dynamic_progress_bar 10 

# Setup LibreWolf customization
echo "Setting up LibreWolf..."
source librewolf/setup.sh
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

# Setup configuration for yazi
echo "Setting up configuration for yazi..."
source yazi/setup.sh
display_dynamic_progress_bar 10

# Setup .zrsch aliases
echo "Setting up .zshrc aliases..."
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