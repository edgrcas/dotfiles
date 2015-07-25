#!/bin/bash
#notify-send "Hola $USER, vamos a comenzar ..."

cd ~

if [ ! -x /usr/bin/vim ] ; then                                
	notify-send "Instalando Vim"
	sudo apt-get install vim --yes
fi

if [ ! -x /usr/bin/curl ] ; then                                
	notify-send "Instalando Curl"
	sudo apt-get install curl --yes
fi

if [ ! -x /usr/bin/zsh ] ; then                                
	notify-send "Instalando Zsh"
	sudo apt-get install zsh --yes
fi

if [ ! -f ~/.zshrc ]; then
    notify-send "Configurando Terminal OhMyZsh"
    curl -L http://install.ohmyz.sh | sh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    chsh -s /bin/zsh $USER
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    notify-send "Plugins para Zsh - syntax.highligh"
    cd ~/.oh-my-zsh/custom/plugins
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
fi

notify-send "Creando enlaces simbolicos"
rm -rf ~/.zshrc
ln -s ~/dotfilesDev/config/.bash_aliases ~/.bash_aliases
ln -s ~/dotfilesDev/config/.zshrc ~/.zshrc

if [ ! -x /usr/bin/virtualbox ] ; then                                
	notify-send "Instalando VirtualBox"
	sudo apt-get install virtualbox --yes
fi

if [ ! -x /usr/bin/vagrant ] ; then                                
	notify-send "Instalando Vagrant"
	sudo apt-get install vagrant --yes
	sudo apt-get install virtualbox-dkms --yes
	wget -O ~/vagrant.deb https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4_x86_64.deb
	sudo dpkg -i ~/vagrant.deb
fi

if [ ! -x /usr/bin/tmux ] ; then                                
notify-send "Instalando tmux"
sudo apt-get update
sudo apt-get install -y python-software-properties software-properties-common
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update
udo apt-get install -y tmux=2.0-1~ppa1~v
fi
