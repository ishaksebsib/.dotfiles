# my .dotfiles

## Installation

```bash
git clone https://github.com/ishaksebsib/.dotfiles.git
cd .dotfiles
```

## Usage

```bash
# User config (e.g. symlink to ~/ in this case ~/.config/nvim)
stow nvim

# System config (e.g. symlink to / in this case /etc/systemd/zram-generator.conf)
sudo stow --target=/ zram-generator
```

## Screenshots

![image](https://github.com/ishaksebsib/.dotfiles/blob/main/imgs/.config/imgs/screenshot.png)
