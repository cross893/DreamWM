cp ~/.config/conky/conky.conf conky/conky.conf
cp ~/.config/kitty/kitty.conf kitty/kitty.conf
cp ~/.config/sway/config sway/config
cp ~/.config/waybar/config waybar/config
cp ~/.config/waybar/style.css waybar/style.css
cp ~/.config/wofi/config wofi/config
cp ~/.config/wofi/style.css wofi/style.css
cp ~/.zshrc zsh/zshrc
cp ~/.p10k.zsh zsh/p10k.zsh
cp -r ~/.oh-my-zsh zsh/oh-my-zsh
sudo cp /root/.p10k.zsh zsh/su.p10k.zsh
sudo cp -r /root/.oh-my-zsh zsh/su.oh-my-zsh
sudo chown -R user:user zsh
#printenv | grep -i XDG_CURRENT_DESKTOP 
