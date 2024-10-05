# My personal Arch .config

As this is my personal config the packages are the basic packages I need, so feel free to check and change the installer and the configuration.
Also the NeoVim config is under my name (bulazs) you should change it to your own.

## Installation

I only recommend the installation to for fresh profiles or for those who really do know what they are doing.

The `install-packages.sh` will guide you through everything, if you accept them all you will get my own configuartion

> [!CAUTION]
> This installation WILL overwrite your previous config if not being careful, so please read everything the terminal prompts

```sh
git clone --recurse-submodules https://github.com/mcbulazs/.config.git config-git
cd config-git
./install-packages.sh
cp -r ./* ~/.config 
sudo reboot now
```

## Packages

### Config specific packages

- `bspwm`
- `sxhkd`
- `polybar` 
- `alacritty`
- `dunst`
- `pavucontrol`
- `rofi`
- `ranger`
- `neovim`
- `picom`
- `feh`
- `flameshot`
- `ttf-jetbrains-mono-nerd`

### "Must" have packages

- `git`
- `zip`
- `unzip`
- `make`
- `fzf`
- `less`
- `man-db`
- `iwd`
- `neofetch`
- `pulseaudio`
- `ripgrep`
- `vim`
- `wget`
- `xclip`
- `xdg-utils`
- `xorg`
- `make`
- `base-devel`
