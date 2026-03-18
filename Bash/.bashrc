# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# ==============================================================================
# zoxide config
# ------------------------------------------------------------------------------

eval "$(zoxide init bash)"

# ==============================================================================
# Set up fzf key bindings and fuzzy completion
# ------------------------------------------------------------------------------

eval "$(fzf --bash)"

# ==============================================================================
# luarocks completion
# ------------------------------------------------------------------------------

eval "$(luarocks completion bash)"

# ==============================================================================
# aliases
# ------------------------------------------------------------------------------

alias ll="ls -lah"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gph="git push"
alias gpl="git pull"
alias op="xdg-open"
alias di="sudo dnf install"
alias yy="yazi"
