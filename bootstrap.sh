# Install Homebrew
echo "Installing Homebrew..."
sleep 0.1
source brew/install.sh

# Install diferrent Formulaes and Casks using xargs with Homebrew's install command
# (using grep to ignore commented lines with #)
echo "Installing packages..."
sleep 0.1
grep -v '^\s*#' packages.txt | xargs brew install

# Download FCPX
# open "https://www.apple.com/final-cut-pro/trial/download"
# echo "Downloading FCPX..."
# curl -L# -o ~/Downloads/FCPX.dmg "https://www.apple.com/final-cut-pro/trial/download"

source bar/progressBar.sh

# Setup Nextcloud's VFS configuration
echo "Setting up Nextcloud..."
source nextcloud/setup.sh
display_dynamic_progress_bar 10 

# Setup configuration for Aerospace tiling window manager
echo "Setting up configuration for Aerospace..."
source aerospace/setup.sh
display_dynamic_progress_bar 20

# Setup configuration for Hammerspoon
echo "Setting up configuration for Hammerspoon..."
source hammerspoon/setup.sh
display_dynamic_progress_bar 30

# Setup crontabs and crontab_log
echo "Setting up cron jobs..."
source crontab/setup.sh
display_dynamic_progress_bar 10

# Setup .zrsch aliases
echo "Setting up .zshrc aliases..."
source zsh/setup.sh
display_dynamic_progress_bar 15

# Setup scripts from bin/ directory to /usr/local/bin/
echo "Setting up symlinks for bin/ scripts... Please enter your password if prompted."
source bin/setup.sh
display_dynamic_progress_bar 20

echo "Bootstrapping complete!"