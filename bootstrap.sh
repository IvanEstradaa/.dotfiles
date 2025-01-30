# Install Homebrew
source brew/install.sh

# Install diferrent Formulaes and Casks using xargs with Homebrew's install command
# (using grep to ignore commented lines with #)
grep -v '^\s*#' packages.txt | xargs brew install

# Download FCPX
# open "https://www.apple.com/final-cut-pro/trial/download"
# echo "Downloading FCPX..."
# curl -L# -o ~/Downloads/FCPX.dmg "https://www.apple.com/final-cut-pro/trial/download"

# Setup Nextcloud's VFS configuration
source nextcloud/setup.sh 

# Setup configuration for Aerospace tiling window manager
source aerospace/setup.sh

# Setup configuration for Hammerspoon
source hammerspoon/setup.sh

# Setup crontabs and crontab_log
source crontab/setup.sh

# Setup .zrsch aliases
source zsh/setup.sh

echo "Setting up symlinks for bin/ scripts... Please enter your password if prompted."
# Setup scripts from bin/ directory to /usr/local/bin/
source bin/setup.sh