#!/bin/bash

if sudo -v
then
distr=0
	while ! [ "$distr" -ge 1 -a "$distr" -le 2 ]; do
  		echo "What distribution do you have? (in developing)"
		read -p "Arch - 1, Debian - 2: " wminstall
	done
 
	### Arch
	if [ "$distr" = "1" ]; then
  		wminstall=-1
 		while ! [ "$wminstall" -ge 0 -a "$wminstall" -le 8 ]; do
  			echo "Do you wanna install WM? (in developing)"
			read -p "sway - 1, awesome - 2, i3-wm - 3, dwm - 4, hyprland - 5, kde - 6, xfce - 7, gnome - 8, nothing - 0: " wminstall
		done
  
		while ! [ "$blackarchpack" = "y" -o "$blackarchpack" = "n" ]; do
			read -p "Do you wanna install blackarch packages? (y/n) " blackarchpack
		done
  
		while ! [ "$neovim" = "y" -o "$neovim" = "n" ]; do
			read -p "Do you wanna install neovim? (y/n) " neovim
		done
  
		while ! [ "$devpack" = "y" -o "$devpack" = "n" ]; do
			read -p "Do you wanna install developing package? (y/n) " devpack
		done

  		yes | sudo pacman -Suy
    
		yes | sudo pacman -S curl
		yes | sudo pacman -S git
		echo "1\ny" | sudo pacman -S man
		yes | sudo pacman -S ranger
		yes | sudo pacman -S iwd
	 	
		yes | sudo pacman -S chromium
		yes | sudo pacman -S firefox
		yes | sudo pacman -S gparted
		yes | sudo pacman -S notepadqq

		if [ "$wminstall" = "1" ]; then #---------------------------------------------------------------------------------------------------------------------------------
			yes | sudo pacman -S mesa
			yes | sudo pacman -S base-devel
			yes | sudo pacman -S wlroots
			yes | sudo pacman -S wayland
			yes | sudo pacman -S wayland-protocols
			yes | sudo pacman -S pcre2
			yes | sudo pacman -S json-c
			yes | sudo pacman -S pango
			yes | sudo pacman -S cairo
			yes | sudo pacman -S gdk-pixbuf2
			#yes | sudo pacman -S messon
			yes | sudo pacman -S cmake
			yes | sudo pacman -S bash-completion
			yes | sudo pacman -S polkit
			yes | sudo pacman -S grim
			yes | sudo pacman -S swaybg
			yes | sudo pacman -S swaylock
			yes | sudo pacman -S awesome-terminal-fonts
			yes | sudo pacman -S swayidle
			yes | sudo pacman -S sway

   			yes | pacman -S pulseaudio
			yes | pacman -S pulseaudio-alsa
			yes | pacman -S alsa-utils
   
		elif [ "$wminstall" = "2" ]; then #---------------------------------------------------------------------------------------------------------------------------------
			yes | sudo pacman -S awesome
   			yes | sudo pacman -S sddm
   			sudo systemctl enable sddm

   			yes | pacman -S pulseaudio
			yes | pacman -S pulseaudio-alsa
			yes | pacman -S alsa-utils
   
		elif [ "$wminstall" = "3" ]; then #---------------------------------------------------------------------------------------------------------------------------------
			yes | sudo pacman -S i3-wm
   			yes | sudo pacman -S sddm
   			sudo systemctl enable sddm

   			yes | pacman -S pulseaudio
			yes | pacman -S pulseaudio-alsa
			yes | pacman -S alsa-utils
   
		elif [ "$wminstall" = "4" ]; then #---------------------------------------------------------------------------------------------------------------------------------
  			echo "This is a DWM in developing"
   
		elif [ "$wminstall" = "5" ]; then #---------------------------------------------------------------------------------------------------------------------------------
			yes | sudo pacman -S hyprland
   			yes | sudo pacman -S sddm
   			sudo systemctl enable sddm

   			yes | pacman -S pulseaudio
			yes | pacman -S pulseaudio-alsa
			yes | pacman -S alsa-utils
   
		elif [ "$wminstall" = "6" ]; then
  			### Video drivers
			yes | sudo pacman -S xf86-video-amdgpu
			yes | sudo pacman -S xf86-video-ati
			yes | sudo pacman -S xf86-video-intel
			yes | sudo pacman -S xf86-video-nouveau
			yes | sudo pacman -S xf86-video-vesa
			yes | sudo pacman -S nvidia

			### X server
			yes | sudo pacman -S xorg-server
			sudo pacman -S xorg-apps

   			### Install and start plasma
			yes | sudo pacman -S plasma
   			sudo systemctl enable sddm

      			### Install sound
			yes | sudo pacman -S alsa-utils
			yes | sudo pacman -S alsa-plugins
   
		elif [ "$wminstall" = "7" ]; then
  			### Video drivers
			yes | sudo pacman -S xf86-video-amdgpu
			yes | sudo pacman -S xf86-video-ati
			yes | sudo pacman -S xf86-video-intel
			yes | sudo pacman -S xf86-video-nouveau
			yes | sudo pacman -S xf86-video-vesa
			yes | sudo pacman -S nvidia

			### X server
			yes | sudo pacman -S xorg-server
			sudo pacman -S xorg-apps
   
   			### Install and start xfce
			sudo pacman -S xfce4
   			yes | sudo pacman -S sddm
   			sudo systemctl enable sddm

      			### Install sound
			yes | sudo pacman -S alsa-utils
			yes | sudo pacman -S alsa-plugins
   
		elif [ "$wminstall" = "8" ]; then
  			### Video drivers
			yes | sudo pacman -S xf86-video-amdgpu
			yes | sudo pacman -S xf86-video-ati
			yes | sudo pacman -S xf86-video-intel
			yes | sudo pacman -S xf86-video-nouveau
			yes | sudo pacman -S xf86-video-vesa
			yes | sudo pacman -S nvidia

			### X server
			yes | sudo pacman -S xorg-server
			sudo pacman -S xorg-apps
   
   			### Install and start gnome
			sudo pacman -S gnome-extra
   			yes | sudo pacman -S gdm
   			sudo systemctl enable gdm

      			### Install sound
			yes | sudo pacman -S alsa-utils
			yes | sudo pacman -S alsa-plugins
		fi
		
		mkdir /home/$USER/.config
	 	
		if [ "$XDG_SESSION_DESKTOP" = "sway" -o "$wminstall" = "1" ]; then
			yes | sudo pacman -S htop
			yes | sudo pacman -S cmus
			yes | sudo pacman -S nemo
   
			yes | sudo pacman -S mako
			
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
			
		elif [ "$DESKTOP_SESSION" = "awesome" -o  "$wminstall" = "2" ]; then
			echo "This is a AWESOME in developing" #---------------------------------------------------------------------------------------------------------------------------------
			yes | sudo pacman -S nemo
			yes | sudo pacman -S xterm
   
			mkdir /home/$USER/.config/awesome
   			cp awesome/rc.lua /home/$USER/.config/awesome/rc.lua
      			
		elif [ "$DESKTOP_SESSION" = "i3" -o  "$wminstall" = "3" ]; then
			echo "This is a i3-wm in developing" #---------------------------------------------------------------------------------------------------------------------------------
			
		elif [ "$DESKTOP_SESSION" = "DWM" -o  "$wminstall" = "4" ]; then
			echo "This is a DWM in developing" #---------------------------------------------------------------------------------------------------------------------------------
			
		elif [ "$DESKTOP_SESSION" = "hyperland" -o  "$wminstall" = "5" ]; then #?????????????????????????
			echo "This is a hyprland in developing" #---------------------------------------------------------------------------------------------------------------------------------
			
		elif [ "$XDG_SESSION_DESKTOP" = "KDE" -o  "$wminstall" = "6" ]; then
			echo "This is a KDE in developing" #---------------------------------------------------------------------------------------------------------------------------------
		
		elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" -o  "$wminstall" = "7" ]; then
			echo "This is a XFCE in developing" #---------------------------------------------------------------------------------------------------------------------------------
		
		elif [ "$XDG_CURRENT_DESKTOP" = "GNOME" -o  "$wminstall" = "8" ]; then
			echo "This is a GNOME in developing" #---------------------------------------------------------------------------------------------------------------------------------
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
  
		### Install neovim
		if [ "$neovim" = "y" ]; then
			yes | sudo pacman -S nvim
   			mkdir /home/$USER/.config/nvim
      			cp nvim/init.vim /home/$USER/.config/nvim/init.vim
   			sudo mkdir /root/.config/nvim
      			sudo cp nvim/init.vim /root/.config/nvim/init.vim
	 		mkdir /home/$USER/.local/
	 		mkdir /home/$USER/.local/share/
	 		mkdir /home/$USER/.local/share/nvim/
	 		mkdir /home/$USER/.local/share/nvim/site/
	 		mkdir /home/$USER/.local/share/nvim/site/autoload/
	 		cp nvim/plug.vim /home/$USER/.local/share/nvim/site/autoload/plug.vim
	 		sudo mkdir /root/.local/
	 		sudo mkdir /root/.local/share/
	 		sudo mkdir /root/.local/share/nvim/
	 		sudo mkdir /root/.local/share/nvim/site/
	 		sudo mkdir /root/.local/share/nvim/site/autoload/
	 		sudo cp nvim/plug.vim /root/.local/share/nvim/site/autoload/plug.vim
		fi
  
		### Install dev package
		if [ "$devpack" = "y" ]; then
  			yes | sudo pacman -S openal
     			yes | sudo pacman -S glew
			yes | sudo pacman -S glfw
   			yes | sudo pacman -S libsndfile
      			yes | sudo pacman -S mpg123
      			yes | sudo pacman -S lib32-glibc
  		fi
    
		### Install blackarch package
		if [ "$blackarchpack" = "y" ]; then
			curl -O https://blackarch.org/strap.sh
			chmod +x strap.sh
			sudo ./strap.sh
			sudo pacman -Syu
			sudo pacman -Syyu --needed --overwrite='*' blackarch
		fi
	
	
	### Debian
	elif [ "$distr" = "2" ]; then
 		wminstall=-1
 		while ! [ "$wminstall" -ge 0 -a "$wminstall" -le 5 ]; do
  			echo "Do you wanna install WM? (in developing)"
			read -p "sway - 1, awesome - 2, i3-wm - 3, dwm - 4, hyprland - 5, nothing - 0: " wminstall
		done
		
		while ! [ "$kalitools" = "y" -o "$kalitools" = "n" ]; do
			read -p "Do you wanna install kali linux tools? (y/n) " kalitools
		done
  
		while ! [ "$neovim" = "y" -o "$neovim" = "n" ]; do
			read -p "Do you wanna install neovim? (y/n) " neovim
		done
	 	
		sudo apt-get update -y
		sudo apt-get upgrade -y
  
		sudo apt-get install curl -y
		sudo apt-get install git -y
		sudo apt-get install man -y
		sudo apt-get install ranger -y
	 
		sudo apt-get install chromium -y
		sudo apt-get install gparted -y

		if [ "$wminstall" = "1" ]; then #---------------------------------------------------------------------------------------------------------------------------------
    			sudo apt-get install sway -y
    			sudo apt-get install swaylock -y
    			sudo apt-get install swayidle -y
    			sudo apt-get install swaybg -y
       
       		elif [ "$wminstall" = "2" ]; then #---------------------------------------------------------------------------------------------------------------------------------
    			sudo apt-get install awesome-extra -y
       
       		elif [ "$wminstall" = "3" ]; then #---------------------------------------------------------------------------------------------------------------------------------
    			sudo apt-get install i3 -y
       
       		elif [ "$wminstall" = "4" ]; then #---------------------------------------------------------------------------------------------------------------------------------
    			sudo apt-get install dwm suckless-tools -y
       
       		elif [ "$wminstall" = "5" ]; then #---------------------------------------------------------------------------------------------------------------------------------
    			echo "This is a hyprland in developing"
       		fi

		mkdir /home/$USER/.config
   
		if [ "$XDG_SESSION_DESKTOP" = "sway" -o  "$wminstall" = "1" ]; then
			sudo apt-get install htop -y
			sudo apt-get install cmus -y
			sudo apt-get install nemo -y
			
			sudo apt-get install waybar -y
			mkdir /home/$USER/.config/waybar
			cp waybar/config /home/$USER/.config/waybar/config
			cp waybar/style.css /home/$USER/.config/waybar/style.css
			
			sudo apt-get install wofi -y
			mkdir /home/$USER/.config/wofi
			cp wofi/config /home/$USER/.config/wofi/config
			cp wofi/style.css /home/$USER/.config/wofi/style.css
			
			mkdir /home/$USER/.config/sway
			cp sway/config /home/$USER/.config/sway/config
		
		elif [ "$DESKTOP_SESSION" = "awesome" -o  "$wminstall" = "2" ]; then
			echo "This is a AWESOME in developing" #---------------------------------------------------------------------------------------------------------------------------------
	  
		elif [ "$DESKTOP_SESSION" = "i3" -o  "$wminstall" = "3" ]; then
			echo "This is a i3-wm in developing" #---------------------------------------------------------------------------------------------------------------------------------
	  	
		elif [ "$DESKTOP_SESSION" = "DWM" -o  "$wminstall" = "4" ]; then
			echo "This is a DWM in developing" #---------------------------------------------------------------------------------------------------------------------------------
			
		elif [ "$DESKTOP_SESSION" = "hyperland" -o  "$wminstall" = "5" ]; then #?????????????????????????
			echo "This is a hyperland in developing" #---------------------------------------------------------------------------------------------------------------------------------
			
		elif [ "$XDG_SESSION_DESKTOP" = "KDE" -o  "$wminstall" = "6" ]; then
			echo "This is a KDE in developing" #---------------------------------------------------------------------------------------------------------------------------------
		
  		elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" -o  "$wminstall" = "7" ]; then
			echo "This is a XFCE in developing" #---------------------------------------------------------------------------------------------------------------------------------
		fi
	  
		sudo apt-get install conky -y
		mkdir /home/$USER/.config/conky
		cp conky/conky.conf /home/$USER/.config/conky/conky.conf
		
		sudo apt-get install kitty -y
		mkdir /home/$USER/.config/kitty
		cp kitty/kitty.conf /home/$USER/.config/kitty/kitty.conf
  		
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

  		sudo apt install build-essential -y
    		sudo apt install libopenal-dev -y
      		sudo apt install libglew-dev -y
      		sudo apt install libglfw3-dev -y
		sudo apt install libsndfile1-dev -y
      		sudo apt install libmpg123-dev -y
		sudo apt-get install libsdl2-dev -y
  
		sudo apt-get install cmake -y
  		sudo apt-get install clang -y
		sudo apt-get install gcc-12 -y
  		sudo apt-get install g++-12 -y
		sudo apt-get install clang-16 -y

  		### Install neovim
		if [ "$neovim" = "y" ]; then
			sudo apt-get install neovim -y
   			mkdir /home/$USER/.config/nvim
      			cp nvim/init.vim /home/$USER/.config/nvim/init.vim
   			sudo mkdir /root/.config/nvim
      			sudo cp nvim/init.vim /root/.config/nvim/init.vim
	 		mkdir /home/$USER/.local/
	 		mkdir /home/$USER/.local/share/
	 		mkdir /home/$USER/.local/share/nvim/
	 		mkdir /home/$USER/.local/share/nvim/site/
	 		mkdir /home/$USER/.local/share/nvim/site/autoload/
	 		cp nvim/plug.vim /home/$USER/.local/share/nvim/site/autoload/plug.vim
	 		sudo mkdir /root/.local/
	 		sudo mkdir /root/.local/share/
	 		sudo mkdir /root/.local/share/nvim/
	 		sudo mkdir /root/.local/share/nvim/site/
	 		sudo mkdir /root/.local/share/nvim/site/autoload/
	 		sudo cp nvim/plug.vim /root/.local/share/nvim/site/autoload/plug.vim
		fi
  		
		### Install kali linux tools
		if [ "$kalitools" = "y" ]; then
			echo "This is a kali linux tools in developing" #---------------------------------------------------------------------------------------------------------------------------------
		fi
	fi
else
	echo "Add you user in sudoers group"
fi
