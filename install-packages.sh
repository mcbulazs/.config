#!/bin/bash

confirmation() {
    read -p "$1 (Y/N): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        return 0
    fi
    return 1
}
confirmation "This will take several minutes. Are you sure you want to continue?" || exit 1

#must have packages + base-devel
confirmation "Do you want to install must-have packages?" &&
    sudo pacman -S --needed git zip unzip make fzf less man-db iwd neofetch pulseaudio ripgrep vim wget xclip xdg-utils xorg xorg-xinit make base-devel

#BLUETOOTH
confirmation "Do you want to install BLUETOOTH specific packages?" &&
    sudo pacman -S --needed pulseaudio pulseaudio-bluetooth blueberry


#config packages
confirmation "Do you want to install personal config packages?" && {
    sudo pacman -S --needed bspwm sxhkd polybar alacritty dunst pavucontrol rofi ranger neovim picom feh flameshot ttf-jetbrains-mono-nerd
    confirmation "Do you want to copy .xinitrc (autostart package specific daemons)?" && {
        copyxinitrc=0
        while [[ $copyxinitrc -eq 0 && -f ~/.xinitrc ]]; do
            if confirmation "Do you want to save previous .xinitrc to .xinitrc.orig?"; then
                mv ~/.xinitrc ~/.xinitrc.orig
                copyxinitrc=1
            else
                if confirmation "Are you really sure? This will delete the previous .xinitrc?"; then
                    copyxinitrc=1
                    rm ~/.xinitrc
                fi
            fi

        done
        [[ -f ./dotfiles/.xinitrc ]] && cp ./dotfiles/.xinitrc ~/.xinitrc
    }
}

#zsh install
confirmation "Do you want to install zsh?" && {
    #installing the base zsh
    sudo pacman -S zsh
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" -- --skip-chsh --unattended
    #installing plugins
    confirmation "Do you want to install zsh plugins?" && {
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
        git clone https://github.com/chrissicool/zsh-256color.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-256color
    }
           
    confirmation "Do you want to copy .zshrc?" && {
        copyzshrc=0
        while [[ $copyzshrc -eq 0 && -f ~/.zshrc ]]; do
            if confirmation "Do you want to save previous .zshrc to .zshrc.orig?"; then
                mv ~/.zshrc ~/.zshrc.orig
                copyzshrc=1
            else
                if confirmation "Are you really sure, this will delete previous .zshrc?"; then
                    copyzshrc=1
                    rm ~/.zshrc
                fi

            fi
        done
        [[ -f ./dotfiles/.zshrc ]] && cp ./dotfiles/.zshrc ~/.zshrc
    }
    confirmation "Do you want to make zsh your default shell?" && {
        chsh -s /usr/bin/zsh
    }
}

#yay installation
if ! which yay &> /dev/null; then
    if confirmation "Do you want to install yay (unofficial package manger)?"; then
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay-bin.git "$HOME/yay-bin"
        cd "$HOME/yay-bin"
        makepkg -si
    fi
fi

#specific pacman packages
confirmation "Do you want to install other pacman packages?" && {
    echo -e "\nYou can get list of available packages here:"
    echo -e "\thttps://archlinux.org/packages"
    read -p "List packages you want to install by pacman (separated by space) [type n if you don't want any]: " packages
    [[ $packages != [nN] && $packages != [nN][oO] ]] && sudo pacman -S --needed "$packages"
}
#specific yay packages
confirmation "Do you want to install other yay packages?" && {
    echo -e "\nYou can get list of available packages here:"
    echo -e "https://aur.archlinux.org/packages"
    read -p "List packages you want to install by yay (separated by space) [type n if you don't want any]: " packages
    [[ $packages != [nN] && $packages != [nN][oO] ]] && yay -S --needed "$packages"
}


echo "Congratulation you have installed the packages, now copy the contents of this dir to your .config and reboot. Have Fun!"
