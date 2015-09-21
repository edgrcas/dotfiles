#!/bin/bash

notificar ()
{
	echo "####### $1 ###########"
}

notificar "Hola $USER, vamos a comenzar ..."

cd ~

if [ ! -x /usr/bin/terminator ] ; then                                
    notificar "Instalando Terminator"
    sudo apt-get install terminator --yes
else
	notificar "[Ok] Terminator" && terminator -v
fi

if [ ! -x /usr/bin/tree ] ; then
    notificar "Instalando Tree"
    sudo apt-get install tree --yes
else
	notificar "[Ok] Tree" && tree --version
fi

if [ ! -x /usr/bin/ngrep ] ; then                                
    notificar "Instalando ngrep"
    sudo apt-get install ngrep --yes
else
	notificar "[Ok] ngrep"
fi

if [ ! -x /usr/bin/vim ] ; then                                
    notificar "Instalando Vim"
    sudo apt-get install vim --yes
else
	notificar "[Ok] Vim"
fi

if [ ! -x ~/.vimrc ] ; then                                
    notificar "Vinculando Vimrc"
    rm -rf ~/.vimrc
    ln -s ~/.dotfiles/config/.vimrc ~/.vimrc
else
	notificar "[Ok] Archivo .vimrc"
fi

if [ ! -x /usr/bin/emacs ] ; then                                
    notificar "Instalando Emacs"
    sudo apt-get install emacs24 --yes
else
	notificar "[Ok] Emacs24"
fi

if [ ! -x /usr/bin/ruby ] ; then                                
    sudo apt-get -y install python-pip
    sudo apt-get -y install build-essential
    sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev mercurial
else
	notificar "[Ok] Ruby"
fi

if [ ! -x /usr/bin/curl ] ; then                                
    notificar "Instalando Curl"
    sudo apt-get install curl --yes
else
	notificar "[Ok] Curl"
fi

if [ ! -x /usr/bin/zsh ] ; then                                
    notificar "Instalando Zsh"
    sudo apt-get install zsh --yes
else
    notificar "[Ok] Zsh"
fi

if [ ! -f ~/.zshrc ]; then
    notificar "Configurando Terminal OhMyZsh"
    curl -L http://install.ohmyz.sh | sh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    chsh -s /bin/zsh $USER
else
	notificar "[Ok] Asociar Archivo .zshrc"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    notificar "Plugins para Zsh - syntax.highligh"
    cd ~/.oh-my-zsh/custom/plugins
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
    notificar "Creando enlaces simbolicos"
    rm -rf ~/.zshrc
    ln -s ~/.dotfiles/config/.zshrc ~/.zshrc
else
	notificar "[Ok] zsh-syntax-highlighting"
fi

rm -rf ~/.bash_aliases
notificar "[Ok] Asociar .bash_aliases"
ln -s ~/.dotfiles/config/.bash_aliases ~/.bash_aliases

#PROYECTO Y DESARROLLO

if [ ! -d ~/Dev/proyectos ]; then
    notificar "Crear Carpeta Proyecto"
    mkdir -p ~/Dev/proyectos
else
	notificar "[Ok] Creado Carpeta de Proyectos"
fi

if [ ! -x /usr/bin/python ] ; then                                
	notificar "Instalando Python"
    sudo apt-get install -y python-software-properties software-properties-common
    sudo add-apt-repository -y ppa:pi-rho/dev
    sudo apt-get update
else
	notificar "[Ok] Python"
fi

if [ ! -x /usr/bin/tmux ] ; then                                
    notificar "Instalando tmux"
    sudo apt-get install -y tmux
    rm -rf ~/.tmux.conf
    ln -s ~/.dotfiles/config/.tmux.conf ~/.tmux.conf
    [ -z "$TMUX"  ] && export TERM=xterm-256color
else
	notificar "[Ok] Tmux"
fi

if [ ! -x /usr/bin/java ] ; then   
    notificar "Instalando Java"
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java8-installer
else
	notificar "[Ok] Java 8"
fi

if [ ! -d ~/netbeans-8.0.2 ]; then
	notificar "Instalando NetBeans 8.0.2"
	if [ ! -f ~/netbeans.sh ]; then
		notificar "Obteniendo Basheroo"
        wget -O ~/netbeans.sh http://download.netbeans.org/netbeans/8.0.2/final/bundles/netbeans-8.0.2-php-linux.sh
        sudo chmod +x ~/netbeans.sh
	bash ~/netbeans.sh
	else
		notificar "[Ok] Bash netbeans"
	fi
else
	notificar "[Ok] netBeans8"
fi

if [ ! -d ~/.prelude ]; then
	notificar "Instalando EmacsPrelude"
	rm -rf .emacs.d
	git clone git://github.com/bbatsov/prelude.git ~/.prelude
	ln -s ~/.prelude ~/.emacs.d
else
	notificar "[Ok] Prelude"
fi

if [ ! -x /usr/bin/docker ] ; then
  notificar "Instalando Docker"
  curl -sSL https://get.docker.com/ | sh
  sudo usermod -aG docker $USER  
  sudo service docker start
else
  notificar "[Ok] Docker"
fi

if [ ! -x /usr/local/bin/docker-compose ] ; then
  notificar "Instalando Docker-Compose"
  sudo su
  curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  exit
  docker-compose --version
else
  notificar "[Ok] docker-compose"
fi

if [ ! -x /usr/bin/ansible ] ; then   
    notificar "Instalando Ansible"
	sudo ifconfig | grep inet
    sudo apt-add-repository ppa:ansible/ansible -y
    sudo apt-get update && sudo apt-get install ansible -y
else
	notificar "[Ok] Ansible"
fi

if [ ! -x /usr/bin/vagrant ] ; then   
    notificar "Instalando Vagrant"
	wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.4_x86_64.deb -O ~/vagrant.deb
	sudo dpkg -i ~/vagrant.deb
else
	notificar "[Ok] Vagrant"
fi

if [ ! -x /usr/bin/virtualbox ] ; then   
    notificar "Instalando VirtualBox"
	sudo apt-get install virtualbox-4.3 --yes
else
	notificar "[Ok] VirtualBox"
fi

if [ ! -d ~/Dev/ansible/playbook ]; then
    notificar "Crear Carpeta PlayBook"
    mkdir -p ~/Dev/ansible/playbook
else
    notificar "[Ok] Creado Carpeta PlayBook"
fi

if [ ! -d ~/.spf13-vim-3 ]; then
    notificar "Instalando SpfVim"
    curl http://j.mp/spf13-vim3 -L -o - | sh
else
    notificar "[Ok] spfVim 3"
fi

notificar "[Ok] Finalizado | Enjoy! | PoweredBy: @Edux87"

sudo apt-get autoremove -y
