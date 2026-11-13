if status is-interactive
    # Prompt and navigation helpers only need to load in interactive shells
    starship init fish | source
    zoxide init fish | source
end

set fish_greeting ""

# Source sensitive API keys from separate file (not tracked in git)
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

# Theme
fish_config theme choose "Dracula Official"

set -gx EDITOR nvim

# Homebrew (Linux); skip silently on machines without it
if test -f /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end

# Add Bun global bin directory to PATH (skipped if it doesn't exist)
fish_add_path "$HOME/.bun/bin"

alias vim='nvim'
alias vi='nvim'
alias claude-squad='cs'
alias gpsup='git push --set-upstream origin main'
alias t='tmux'
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias ts='tmux new-session'
alias tk='tmux kill-session'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias convert-linux="~/Git/media-converter/convert_linux.sh"

# PYENV
set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path "$PYENV_ROOT/bin"
if type -q pyenv
    pyenv init - fish | source
end

# SDKMan
# NOTE: sdkman-init.sh is a bash script and cannot be sourced by fish.
set -gx SDKMAN_DIR "$HOME/.sdkman"

# Android
set -gx ANDROID_HOME "$HOME/Android/Sdk"
fish_add_path "$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools" "$ANDROID_HOME/tools" "$ANDROID_HOME/tools/bin"

# Flutter
set -gx FLUTTER_HOME "$HOME/flutter"
fish_add_path "$FLUTTER_HOME/bin"

# Volta
set -gx VOLTA_HOME "$HOME/.volta"
fish_add_path "$VOLTA_HOME/bin"

# Ionic Capacitor
set -gx CAPACITOR_ANDROID_STUDIO_PATH "/usr/local/bin/android-studio"

# OpenCode / Strix / user-local tools (fish_add_path skips dirs that don't exist)
fish_add_path "$HOME/.opencode/bin" "$HOME/.strix/bin" "$HOME/.local/bin"
