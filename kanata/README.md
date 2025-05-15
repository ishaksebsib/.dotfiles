# kanata

kanata is a keyboard remapping tool for linux.

## Installation

### Arch Linux

```bash
yay -S kanata
```

### setup

```bash
sudo kanata -c ~/.dotfiles/kanata/kanata.kbd
```

### run it in the background

### edit the service file to your home directory

```bash
cp ~/.dotfiles/kanata/kanata.service /etc/systemd/system/
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable kanata.service
sudo systemctl start kanata.service
```

### check the status

```bash
sudo systemctl status kanata.service
```

