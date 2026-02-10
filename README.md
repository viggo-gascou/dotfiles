<h1 id="my-dotfiles" align="center">
    <img width="64" src="https://assets.vgascou.co/developer.png"/><br>
    my dotfiles <br>
    <sup><sub><em>powered by <a href="https://www.chezmoi.io/">chezmoi </a></em>🏠</sub></sup>
</h1>

## 🚀 Quick Setup

Execute this command to setup the dotfiles automatically with the help of chezmoi

```sh
/bin/bash -c "$(curl -fsSL https://vgascou.co/dotfiles.sh)"
```

## ⚙️ Manual Installation

If you prefer to install manually:

1. Install [chezmoi](https://www.chezmoi.io/install/)

2. Apply the configuration

```sh
chezmoi init --apply viggo-gascou
```

## 🔁 Updating

To update your dotfiles:

```sh
chezmoi update
```
