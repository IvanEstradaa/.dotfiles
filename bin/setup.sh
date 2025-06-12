#!/bin/bash

# Make all files in ~/.dotfiles/bin/ executable
chmod +x "$HOME/.dotfiles/bin/"*

# Ensure /usr/local/bin exists
sudo mkdir -p /usr/local/bin/

# Remove all broken symlinks in /usr/local/bin interactively
sudo find -L /usr/local/bin -type l -exec rm -i {} +

# Link new executables from ~/.dotfiles/bin to /usr/local/bin,
# excluding setup.sh and files already linked
for file in "$HOME/.dotfiles/bin/"*; do
  filename=$(basename "$file")

  # Skip setup.sh
  if [[ "$filename" == "setup.sh" ]]; then
    continue
  fi

  # Only link if it doesn't already exist in /usr/local/bin
  if [[ ! -e "/usr/local/bin/$filename" ]]; then
    sudo ln -s "$file" "/usr/local/bin/$filename"
    echo "Added new symlink: $filename"
  fi
done

# ---
# This script performs the following:
# 1. Makes dotfiles binaries executable.
# 2. Removes broken symlinks from /usr/local/bin interactively.
# 3. Adds new symlinks for binaries (excluding setup.sh) from ~/.dotfiles/bin to /usr/local/bin.
# 4. Skips already existing links to avoid overwriting.

# Additional references:
# - drag bin: https://github.com/Wevah/dragterm/issues/2
# - ripdrag with yazi: https://github.com/nik012003/ripdrag/issues/19
# - keymaster bin: https://github.com/johnthethird/keymaster.git
#     - Related QR code info: https://apple.stackexchange.com/questions/176119/how-to-access-the-wi-fi-password-through-terminal
# - localsend bin: https://github.com/zpp0196/localsend-rs?tab=readme-ov-file
