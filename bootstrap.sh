# Install Homebrew
source brew/install.sh

# Install diferrent Formulaes and Casks using xargs with Homebrew's install command
# (using grep to ignore commented lines with #)
grep -v '^\s*#' packages.txt | xargs brew install

# Download FCPX
open "https://www.apple.com/final-cut-pro/trial/download"

# Setup my configuration for aerospace tiling window manager
source aerospace/setup.sh

# Setup my crontabs and my crontab_log
source crontab/setup.sh

# Setup my .zrsch aliases
source zsh/setup.sh
