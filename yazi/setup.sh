YAZI_PATH="$HOME/.config/yazi"

# Remove .config/yazi
rm -rf $YAZI_PATH

# Symlink
ln -s $PWD/yazi/ $HOME/.config/

# Add yazi "y" function to .zshrc
echo "
function y() {
        local tmp=\"\$(mktemp -t \"yazi-cwd.XXXXXX\")\" cwd
        yazi \"\$@\" --cwd-file=\"\$tmp\"
        if cwd=\"\$(command cat -- \"\$tmp\")\" && [ -n \"\$cwd\" ] && [ \"\$cwd\" != \"\$PWD\" ]; then
                builtin cd -- \"\$cwd\"
        fi
        rm -f -- \"\$tmp\"
}" >> ~/.zshrc