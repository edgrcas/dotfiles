#!/bin/bash
#notify-send "Hola $USER, vamos a comenzar ..."

cd ~

if [ ! -x /usr/bin/ngrep ] ; then                                
	notify-send "Instalando ngrep"
	sudo apt-get install ngrep --yes
fi

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
    notify-send "Creando enlaces simbolicos"
    rm -rf ~/.zshrc
    ln -s ~/dotfilesDev/config/.bash_aliases ~/.bash_aliases
    ln -s ~/dotfilesDev/config/.zshrc ~/.zshrc
fi

if [ ! -x /usr/bin/virtualbox ] ; then                                
	notify-send "Instalando VirtualBox"
	sudo apt-get install virtualbox --yes
fi

#PROYECTO Y DESARROLLO

if [ ! -d ~/proyectos ]; then
    mkdir ~/proyectos
    cp ~/dotfilesDev/config/Vagrantfile ~/proyectos
    mkdir ~/proyectos/public 
    cp ~/dotfilesDev/config/index.php ~/proyectos/public
    #sudo echo "\n192.168.33.10 proyectos.dev" >> /etc/host
fi

if [ ! -x /usr/bin/vagrant ] ; then   
    sudo apt-get install nfs-kernel-server --yes                             
    notify-send "Instalando Vagrant"
    sudo apt-get install vagrant --yes
    sudo apt-get install virtualbox-dkms --yes
    wget -O ~/vagrant.deb https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4_x86_64.deb
    sudo dpkg -i ~/vagrant.deb
    vagrant plugin install vagrant-hostmanager
    vagrant box add scotch/box
    vagrant box list
fi

if [ ! -x /usr/bin/tmux ] ; then                                
notify-send "Instalando tmux"
sudo apt-get update
sudo apt-get install -y python-software-properties software-properties-common
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install -y tmux=2.0-1~ppa1~t --yes
rm -rf ~/.tmux.conf
ln -s ~/dotfilesDev/config/.tmux.conf ~/.tmux.conf
fi

if [ ! -x /usr/bin/netbeans ] ; then   
sudo apt-get autoremove
wget -O ~/netbeans.sh http://bits.netbeans.org/download/trunk/nightly/latest/bundles/netbeans-trunk-nightly-201507240001-php-linux-x64.sh
sudo chmod +x ~/netbeans.sh
bash ~/netbeans.sh
fi

#netbeans-dev-201507240001



