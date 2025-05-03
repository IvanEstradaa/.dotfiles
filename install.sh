# Install Homebrew and Xcode command line tools if not already installed.

NONINTERACTIVE=1; /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to path
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile

# Run in current session
eval "$(/opt/homebrew/bin/brew shellenv)"

# Clone the dotfiles repository
git clone https://github.com/IvanEstradaa/.dotfiles.git ~/.dotfiles && cd ~/.dotfiles || exit 1

# Run the bootstrap script
source bootstrap.sh

# Clearing things up
LC_ALL=C sed -i '' '/curl/d' $HISTFILE
clear

# Run the macOS setup script
echo "Press any key to continue with macOS setup..."
read -n 1 -s # Wait for user input
source macos/setup.sh