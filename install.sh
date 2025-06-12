# Ask for the administrator password upfront
echo "Please enter your password to continue..."
sudo -v

# Keep-alive: update existing sudo time stamp every minute to prevent password prompts during installation
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew and Xcode command line tools if not already installed.
if ! command -v brew &>/dev/null; then
  echo "Installing Xcode command line tools and Homebrew..."
  NONINTERACTIVE=1; /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add to path
  echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile

  # Run in current session
  eval "$(/opt/homebrew/bin/brew shellenv)"

  if ! command -v brew &>/dev/null; then
    echo "Homebrew installation failed, exiting..."
    exit 1
  fi
else
  echo "Homebrew already intalled!"
fi

echo "Cloning dotfiles repository"
git clone https://github.com/IvanEstradaa/.dotfiles.git ~/.dotfiles && cd ~/.dotfiles || { echo "Failed to clone dotfiles repository. Please check URL or network connection."; exit 1; }

echo "Starting dotfiles setup"
source bootstrap.sh

# Clearing things up
LC_ALL=C sed -i '' '/sudo/d' $HISTFILE
LC_ALL=C sed -i '' '/curl/d' $HISTFILE
clear

echo "Press any key to continue with macOS setup (or Ctrl+C to cancel)... 30s remaining..."
read -n 1 -s -t 30 || echo "Timeout reached. Proceeding with macOS setup."
source macos/setup.sh
