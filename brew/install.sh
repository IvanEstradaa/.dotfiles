NONINTERACTIVE=1; /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to path
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile

# Run in current session
eval "$(/opt/homebrew/bin/brew shellenv)"
