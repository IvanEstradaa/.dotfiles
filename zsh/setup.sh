echo "Setting up aliases..."
echo "[[ ! -f ~/.dotfiles/zsh/aliases.zsh ]] || source ~/.dotfiles/zsh/aliases.zsh" >> ~/.zshrc

echo "Setting up history zsh..."
echo "[[ ! -f ~/.dotfiles/zsh/history.zsh ]] || source ~/.dotfiles/zsh/history.zsh" >> ~/.zshrc

echo "Adding powerlevel10k theme to zsh..."
echo "source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc

echo "Adding zsh-autosuggestions to zsh..."
echo "source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

echo "Adding zsh-syntax-highlighting to zsh..."
echo "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

echo "Adding zsh-completions to zsh..."
echo "
if type brew &>/dev/null; then
    FPATH=\$(brew --prefix)/share/zsh-completions:\$FPATH

    autoload -Uz compinit
    compinit
  fi
" >> ~/.zshrc
chmod go-w '/opt/homebrew/share'
chmod -R go-w '/opt/homebrew/share/zsh'
rm -f ~/.zcompdump; compinit

echo "Setting up key bindings..."
echo "
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
" >> ~/.zshrc

echo "Adding fzf to zsh..."
echo "eval '\$(fzf --zsh)'" >> ~/.zshrc

echo "Adding zoxide to zsh..."
echo "eval '\$(zoxide init zsh)'" >> ~/.zshrc

echo "Export bat theme..."
echo "export BAT_THEME='ansi'" >> ~/.zshrc

echo "Export editor..."
echo "export EDITOR='nvim'" >> ~/.zshrc


echo "zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'" >> ~/.zshrc
