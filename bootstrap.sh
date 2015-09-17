#!/bin/bash

notificar ()
{
	echo "####### $1"
}

notificar "Hola $USER, vamos a comenzar ..."

cd ~

if [ ! -x /usr/bin/terminator ] ; then                                
    notificar "Instalando Terminator"
    sudo apt-get install terminator --yes
fi

if [ ! -x /usr/bin/tree ] ; then                                
    sudo apt-get -y install tree
fi

if [ ! -x /usr/bin/ngrep ] ; then                                
    notificar "Instalando ngrep"
    sudo apt-get install ngrep --yes
fi

if [ ! -x /usr/bin/vim ] ; then                                
    notificar "Instalando Vim"
    sudo apt-get install vim --yes
fi

if [ ! -x ~/.vimrc ] ; then                                
    notificar "Vinculando Vimrc"
    rm -rf ~/.vimrc
    ln -s ~/.dotfiles/config/.vimrc ~/.vimrc
fi

if [ ! -x /usr/bin/emacs ] ; then                                
    notificar "Instalando Emacs"
    sudo apt-get install emacs24 --yes
fi

if [ ! -x /usr/bin/ruby ] ; then                                
    sudo apt-get -y install python-pip
    sudo apt-get -y install build-essential
    sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev mercurial
fi

if [ ! -x /usr/bin/curl ] ; then                                
    notificar "Instalando Curl"
    sudo apt-get install curl --yes
fi

if [ ! -x /usr/bin/zsh ] ; then                                
    notificar "Instalando Zsh"
    sudo apt-get install zsh --yes
fi

if [ ! -f ~/.zshrc ]; then
    notificar "Configurando Terminal OhMyZsh"
    curl -L http://install.ohmyz.sh | sh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    chsh -s /bin/zsh $USER
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    notificar "Plugins para Zsh - syntax.highligh"
    cd ~/.oh-my-zsh/custom/plugins
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
    notificar "Creando enlaces simbolicos"
    rm -rf ~/.zshrc
    ln -s ~/.dotfiles/config/.bash_aliases ~/.bash_aliases
    ln -s ~/.dotfiles/config/.zshrc ~/.zshrc
fi

#PROYECTO Y DESARROLLO

if [ ! -d ~/proyectos ]; then
    mkdir ~/proyectos
fi

if [ ! -x /usr/bin/tmux ] ; then                                
    notificar "Instalando tmux"
    sudo apt-get update
    sudo apt-get install -y python-software-properties software-properties-common
    sudo add-apt-repository -y ppa:pi-rho/dev
    sudo apt-get update
    sudo apt-get install -y tmux=2.0-1~ppa1~v --yes
    rm -rf ~/.tmux.conf
    ln -s ~/.dotfiles/config/.tmux.conf ~/.tmux.conf
    [ -z "$TMUX"  ] && export TERM=xterm-256color
fi

if [ ! -x /usr/bin/java ] ; then   
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java8-installer
fi

if [ ! -d ~/netbeans-8.0.2 ]; then
	if [ ! -f ~/netbeans.sh ]; then
            wget -O ~/netbeans.sh http://download.netbeans.org/netbeans/8.0.2/final/bundles/netbeans-8.0.2-php-linux.sh
            sudo chmod +x ~/netbeans.sh
    bash ~/netbeans.sh
	fi
fi

if [ ! -d ~/.prelude ]; then
rm -rf .emacs.d
git clone git://github.com/bbatsov/prelude.git ~/.prelude
ln -s ~/.prelude ~/.emacs.d
fi

#if [ ! -x /usr/bin/docker ] ; then                                
#curl -sSL https://get.docker.com/ | sh
#sudo usermod -aG docker $USER  
#sudo service docker start
#fi

if [ ! -d ~/.spf13-vim-3 ]; then
    notificar "Instalando SpfVim"
    curl http://j.mp/spf13-vim3 -L -o - | sh
fi

sudo apt-get autoremove -y
