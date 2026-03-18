# DOTfylz

![banner](assets/banner.png)

A personal dotfiles repo managed with GNU Stow—enabling my compulsive need to nuke my OS every few months and start fresh without losing my entire workflow. Think of it as muscle memory for my system configuration.

## What's Inside

This repo contains my personal configurations for:

- **nvim** — Personal Neovim setup based on my [HYPERfix.nvim](https://github.com/TheOnliestMattastic/HYPERfix.nvim) template. Includes Lazy.nvim, LSP, DAP, and a custom colorscheme
- **Bash** — `.bashrc` and `.bash_profile` with zoxide, fzf, luarocks completions, and aliases
- **Git** — Git configuration (mostly to avoid committing my shame)
- **Wezterm** — Terminal emulator config because some of us have moved on from the 90s
- **starship** — Catppuccin Macchiato prompt theme with custom directory icons
- **fontconfig** — Font rendering rules (synthetic bold/oblique)
- **amp** — Amp AI agent instructions (persona, coding standards, ADHD coaching)
- **mimeapps** — Default application associations (Brave, Betterbird, Dolphin, etc.)
- **gh** — GitHub CLI configuration
- **OpenRGB** — RGB lighting profiles
- **rclone** — Cloud storage mount configuration

## The Philosophy

I reinstall my OS approximately once every few months (sometimes weeks, if I'm having a particularly intrusive OCD day). Rather than spend 6 hours reconfiguring everything from scratch, I use this setup to get back to productivity in minutes.

GNU Stow handles symlinking the dotfiles to their proper locations across multiple environments. It's elegant, it's portable, and it means I can clone this repo on a fresh system and be coding within minutes.

## Quick Start

```bash
git clone <repo_url> ~/DOTfylz
cd ~/DOTfylz

# Install GNU Stow if you haven't already
# Arch: pacman -S stow
# Ubuntu/Debian: apt install stow
# macOS: brew install stow

# Symlink everything
stow Bash Git nvim wezterm starship fontconfig amp mimeapps gh OpenRGB rclone
```

For specific packages, just stow the ones you want:
```bash
stow nvim
stow starship
```

> **⚠️ Sensitive files**: `rclone.conf` and `gh/hosts.yml` are `.gitignore`'d because they contain credentials. After cloning, copy these manually from a backup before stowing.

## Fair Warning

This is a **personal setup**. Things may:
- Break without warning
- Change drastically between commits
- Be opinionated to the point of absurdity
- Require specific plugins/tools that I assume everyone has

That said, clone it, use it, adapt it—I welcome it. If you find a bug or want to improve something, PRs are welcome, but don't expect quick turnarounds. This is a hobby repo, not a commercial product.

## Structure

Each directory is set up for Stow and mirrors the structure of `$HOME`:

```
DOTfylz/
├── amp/
│   └── .config/amp/           # Amp AI agent instructions
├── Bash/
│   ├── .bashrc                # Bash configuration
│   └── .bash_profile          # Bash login profile
├── fontconfig/
│   └── .config/fontconfig/    # Font rendering rules
├── gh/
│   └── .config/gh/            # GitHub CLI config (hosts.yml gitignored)
├── Git/
│   └── .gitconfig             # Git configuration
├── mimeapps/
│   └── .config/mimeapps.list  # Default app associations
├── nvim/
│   └── .config/nvim/          # Neovim configuration
├── OpenRGB/
│   └── .config/OpenRGB/       # RGB lighting profiles
├── rclone/
│   └── .config/rclone/        # Cloud mounts (rclone.conf gitignored)
├── starship/
│   └── .config/starship.toml  # Starship prompt theme
├── wezterm/
│   └── .config/wezterm/       # Wezterm terminal config
└── assets/
    └── banner.png             # This fancy banner
```

## Why "DOTfylz"?

Because `dotfiles` is boring, and my brain processes things better when there's a bit of personality involved. Consider it a tiny act of rebellion against the tyranny of naming conventions.

## License

Do whatever you want with it. It's just my configs.

---

**TL;DR**: Fresh OS install? `stow *`. Back to coding. Neurosis satisfied (for now).
