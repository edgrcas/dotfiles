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

if [ ! -x /usr/bin/htop ] ; then
	notificar "Instalando HTOP"
	sudo apt-get install htop --yes
else
	notificar "[Ok] htop"
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

#PROYECTO Y DESARROLLO

if [ ! -d ~/Projects ]; then
	notificar "Crear Carpeta Proyecto"
	mkdir -p ~/Projects
else
	notificar "[Ok] Creado Carpeta de Proyectos"
fi

if [ ! -x /usr/bin/meld ] ; then
	notificar "Instalando meld"
	sudo apt-get install -y meld
else
	notificar "[Ok] Meld"
fi

if [ ! -x /usr/bin/gitg ] ; then
	notificar "Instalando gitg"
	sudo apt-get install -y gitg
else
	notificar "[Ok] gitg"
fi

if [ ! -x /usr/bin/planner ] ; then
	notificar "Instalando planner"
	sudo apt-get install -y planner
else
	notificar "[Ok] planner"
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

### OMY ZSH

if [ ! -f ~/.zshrc ]; then
	notificar "Configurando Terminal OhMyZsh"
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
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

###############################

if [ ! -d ~/.spf13-vim-3 ]; then
	notificar "Instalando SpfVim"
	curl http://j.mp/spf13-vim3 -L -o - | sh
else
	notificar "[Ok] spfVim 3"
fi


notificar "[Ok] Finalizado | Enjoy! | PoweredBy: @Edux87"
sudo apt-get autoremove -y
