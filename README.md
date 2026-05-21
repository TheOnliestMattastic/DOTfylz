# DOTfylz

![banner](assets/banner.png)

A personal dotfiles repo managed with GNU Stow—enabling my compulsive need to nuke my OS every few months and start fresh without losing my entire workflow.

## What's Inside

- **nvim** — Neovim configuration with Lazy.nvim, LSP, DAP, and a custom colorscheme.
- **Bash** — `.bashrc` and `.bash_profile` with zoxide, fzf, luarocks, and aliases.
- **Git** — Global git configuration.
- **Wezterm** — Terminal emulator configuration.
- **Starship** — Shell prompt configuration.
- **gh** — GitHub CLI configuration.
- **mimeapps** — Default application mappings.
- **OpenRGB** — RGB lighting profiles.
- **lazygit** — Terminal UI for Git.

## Quick Start (OS Refresh)

If you are starting from a fresh OS install, use the following steps to restore your environment:

```bash
# 1. Clone the repository
git clone https://github.com/TheOnliestMattastic/DOTfylz ~/DOTfylz
cd ~/DOTfylz

# 2. Ensure GNU Stow is installed
# Arch: sudo pacman -S stow
# Ubuntu/Debian: sudo apt install stow
# macOS: brew install stow

# 3. Symlink all configurations
stow Bash Git gh lazygit mimeapps nvim OpenRGB starship wezterm
```

## Structure

Each directory mirrors the structure of `$HOME` and is managed by GNU Stow:

```text
DOTfylz/
├── Bash/       # .bash_profile, .bashrc
├── Git/        # .gitconfig
├── gh/         # .config/gh/
├── lazygit/    # .config/lazygit/
├── mimeapps/   # .config/mimeapps.list
├── nvim/       # .config/nvim/
├── OpenRGB/    # .config/OpenRGB/
├── starship/   # .config/starship.toml
└── wezterm/    # .config/wezterm/
```

## Disclaimer

This is a **personal setup**. It is opinionated, may change without notice, and relies on a specific set of installed packages/tools. Use at your own risk.
