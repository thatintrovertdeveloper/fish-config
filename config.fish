if status is-interactive
    # Prompt and navigation helpers only need to load in interactive shells
    starship init fish | source
    zoxide init fish | source
end

# Source sensitive API keys from separate file (not tracked in git)
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

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
