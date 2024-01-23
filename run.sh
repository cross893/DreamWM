#!/bin/bash

yes | sudo pacman -S curl
yes | sudo pacman -S git
yes | sudo pacman -S man
yes | sudo pacman -S ranger

yes | sudo pacman -S chromium
yes | sudo pacman -S nemo
yes | sudo pacman -S gparted

mkdir /home/$USER/.config

if (XDG_SESSION_DESKTOP=sway)
then
  echo "This is a SWAY"
  
  yes | sudo pacman -S htop
  yes | sudo pacman -S cmus
  
  yes | sudo pacman -S waybar
  mkdir /home/$USER/.config/waybar
  cp waybar/config /home/$USER/.config/waybar/config
  cp waybar/style.css /home/$USER/.config/waybar/style.css
  
  yes | sudo pacman -S wofi
  mkdir /home/$USER/.config/wofi
  cp wofi/config /home/$USER/.config/wofi/config
  cp wofi/style.css /home/$USER/.config/wofi/style.css
  
  mkdir /home/$USER/.config/sway
  cp sway/config /home/$USER/.config/sway/config

elif (DESKTOP_SESSION=awesome)
then
  echo "This is a AWESOME"

elif (DESKTOP_SESSION=i3)
then
  echo "This is a i3-wm"
fi

yes | sudo pacman -S conky
mkdir /home/$USER/.config/conky
cp conky/conky.conf /home/$USER/.config/conky/conky.conf

yes | sudo pacman -S kitty
mkdir /home/$USER/.config/kitty
cp kitty/kitty.conf /home/$USER/.config/kitty/kitty.conf

### Fonts
mkdir /home/$USER/.fonts
cp fonts/JetBrainsMonoNerdFontMono-Regular.ttf /home/$USER/.fonts/
sudo mkdir /root/.fonts
sudo cp fonts/JetBrainsMonoNerdFontMono-Regular.ttf /root/.fonts/
yes | sudo pacman -S ttf-arphic-uming ttf-arphic-ukai ttf-hannom adobe-source-han-sans-cn-fonts adobe-source-han-sans-kr-fonts ttf-hanazono

### ZSH
yes | sudo pacman -S zsh
chsh -s $(which zsh)
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USER/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git /home/$USER/.oh-my-zsh/custom/themes/powerlevel10k
sudo git clone https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k
cp zsh/zshrc /home/$USER/.zshrc
sudo cp zsh/zshrc /root/.zshrc
cp zsh/p10k.zsh /home/$USER/.p10k.zsh
sudo cp zsh/su.p10k.zsh /root/.p10k.zsh

### Install blackarch package
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syu
sudo pacman -Syyu --needed --overwrite='*' blackarch

### Install mate
#sudo pacman -S caja marco mate-backgrounds mate-control-center mate-desktop mate-icon-theme mate-menus mate-notification-daemon mate-panel mate-polkit mate-session-manager mate-settings-daemon mate-themes mate-user-guide

### Install xfce
#sudo pacman -S exo garcon thunar thunar-volman tumbler xfce4-appfinder xfce4-panel xfce4-power-manager xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4 xfwm4-themes
