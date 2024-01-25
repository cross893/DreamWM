#!/bin/bash

if sudo -v
then

	### Arch
	if [ "$(uname -n)" = "archlinux" ]
	then
  		wminstall=-1
 		while ! [ "$wminstall" -ge 0 -a "$wminstall" -le 1 ]
		do
  			echo "Do you wanna install WM?"
			read -p "sway - 1, " wminstall
		done
  
		while ! [ "$blackarchpack" = "y" -o "$blackarchpack" = "n" ]
		do
			read -p "Do you wanna install blackarch packages? (y/n) " blackarchpack
		done
		
		yes | sudo pacman -S curl
		yes | sudo pacman -S git
		echo "1\ny" | sudo pacman -S man
		yes | sudo pacman -S ranger
	 	
		yes | sudo pacman -S chromium
		yes | sudo pacman -S gparted

		if [ "$wminstall" = "1" ]
		then
			yes | sudo pacman -S sway
		fi
		
		mkdir /home/$USER/.config
	 	
		if [ "$XDG_SESSION_DESKTOP" = "sway" -o "$wminstall" = "1" ]
		then
			yes | sudo pacman -S htop
			yes | sudo pacman -S cmus
			yes | sudo pacman -S nemo
			
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
			
		elif [ "$DESKTOP_SESSION" = "awesome" ]
		then
			echo "This is a AWESOME in developing"
			
		elif [ "$DESKTOP_SESSION" = "i3" ]
		then
			echo "This is a i3-wm in developing"
			
		elif [ "$XDG_SESSION_DESKTOP" = "KDE" ]
		then
			echo "This is a KDE in developing"
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
		if [ "$blackarchpack" = "y" ]
		then
			curl -O https://blackarch.org/strap.sh
			chmod +x strap.sh
			sudo ./strap.sh
			sudo pacman -Syu
			sudo pacman -Syyu --needed --overwrite='*' blackarch
		fi
	
	
	### Debian
	elif [ "$(uname -n)" = "debian" ]
	then
		echo "Debian in developing"
  
 		wminstall=-1
 		while ! [ "$wminstall" -ge 0 -a "$wminstall" -le 1 ]
		do
  			echo "Do you wanna install WM?"
			read -p "sway - 1, " wminstall
		done
		
		while ! [ "$kalitools" = "y" -o "$kalitools" = "n" ]
		do
			read -p "Do you wanna install kali linux tools? (y/n) " kalitools
		done
	 	
		sudo apt-get install curl -y
		sudo apt-get install git -y
		sudo apt-get install man -y
		sudo apt-get install ranger -y
	 
		sudo apt-get install chromium -y
		sudo apt-get install gparted -y

		if [ "$wminstall" = "1" ]
  		then
    			sudo apt-get install sway -y
       		fi

		mkdir /home/$USER/.config
   
		if [ "$XDG_SESSION_DESKTOP" = "sway" -o  "$wminstall" = "1" ]
		then
			echo "This is a SWAY in developing"
		
		elif [ "$DESKTOP_SESSION" = "awesome" ]
		then
			echo "This is a AWESOME in developing"
	  
		elif [ "$DESKTOP_SESSION" = "i3" ]
		then
			echo "This is a i3-wm in developing"
	  
		elif [ "$XDG_SESSION_DESKTOP" = "KDE" ]
		then
			echo "This is a KDE in developing"
		fi
  		
    		### Fonts
		mkdir /home/$USER/.fonts
		cp fonts/JetBrainsMonoNerdFontMono-Regular.ttf /home/$USER/.fonts/
		sudo mkdir /root/.fonts
		sudo cp fonts/JetBrainsMonoNerdFontMono-Regular.ttf /root/.fonts/
	  
		### ZSH
		sudo apt-get install zsh -y
		chsh -s $(which zsh)
		sudo chsh -s $(which zsh)
		sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USER/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	 	sudo cp -r /home/$USER/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting /root/.oh-my-zsh/custom/plugins/
		git clone https://github.com/romkatv/powerlevel10k.git /home/$USER/.oh-my-zsh/custom/themes/powerlevel10k
		sudo git clone https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k
		cp zsh/zshrc /home/$USER/.zshrc
		sudo cp zsh/zshrc /root/.zshrc
		cp zsh/p10k.zsh /home/$USER/.p10k.zsh
		sudo cp zsh/su.p10k.zsh /root/.p10k.zsh
	 
		### Install kali linux tools
		if [ "$kalitools" = "y" ]
		then
			echo "This is a kali linux tools in developing"
		fi
	fi
else
	echo "Add you user in sudoers group"
fi
