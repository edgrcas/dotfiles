#!/bin/bash
#notify-send "Hola $USER, vamos a comenzar ..."

cd ~

if [ ! -x /usr/bin/terminator ] ; then                                
    notify-send "Instalando Terminator"
    sudo apt-get install terminator --yes
fi

if [ ! -x /usr/bin/ngrep ] ; then                                
    notify-send "Instalando ngrep"
    sudo apt-get install ngrep --yes
fi

if [ ! -x /usr/bin/vim ] ; then                                
    notify-send "Instalando Vim"
    sudo apt-get install vim --yes
fi

if [ ! -x ~/.vimrc ] ; then                                
    notify-send "Vinculando Vimrc"
    rm -rf ~/.vimrc
    ln -s ~/dotfilesDev/config/.vimrc ~/.vimrc
fi

if [ ! -x /usr/bin/ruby ] ; then                                
sudo pt-get -y install python-pip
sudo apt-get install build-essential
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev mercurial
fi

cd ~
bash ~/dotfilesDev/config/install_vim.sh
curl http://j.mp/spf13-vim3 -L -o - | sh

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

if [ ! -x /usr/bin/VBoxClient ] ; then                                
    notify-send "Instalando VirtualBox"
    sudo apt-get install virtualbox --yes
fi

#PROYECTO Y DESARROLLO

if [ ! -d ~/proyectos ]; then
    mkdir ~/proyectos
    cp ~/dotfilesDev/config/Vagrantfile ~/proyectos
    cp ~/dotfilesDev/config/index.php ~/proyectos/proyectos.dev/public
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
    [ -z "$TMUX"  ] && export TERM=xterm-256color
fi

if [ ! -d ~/netbeans-8.0.2 ]; then
    sudo apt-get autoremove -y
    wget -O ~/netbeans.sh http://download.netbeans.org/netbeans/8.0.2/final/bundles/netbeans-8.0.2-php-linux.sh
    sudo chmod +x ~/netbeans.sh
    bash ~/netbeans.sh
fi



