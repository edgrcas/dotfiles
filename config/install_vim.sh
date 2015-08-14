#!/bin/bash
#Script to install vim 7.4.803 from the emacs mirror hosted in github

version="v7-4-803"
foldername="vim-7-4-803"
url="https://github.com/vim/vim/archive/$version.tar.gz"

filename_lua="lua-5.1"
url_lua_repo="http://www.lua.org/ftp/$filename_lua.tar.gz"
uninstall_flag=$1


function main {
    if [[ $uninstall_flag == "--uninstall" ]]; then
        uninstall_vim
    else
        install_vim
        install_success
    fi
}

function install_vim {
    echo "-->Go $HOME"
    cd $HOME

    echo "-->Creating the vim folder..."
    mkdir vim

    echo "-->Go to the created vim folder..."
    cd $HOME/vim

    echo "-->Invoque and untar from the mirror hosted in github"
    curl -L $url | tar zx

    echo "-->Go to to $foldername folder"
    cd "$foldername"

    echo "-->Cleaning existing build"
    make distclean

    echo "-->Executing And build with the default settings"
    ./configure --with-features=huge \
            --enable-multibyte \
            --enable-fail-if-missing \
            --enable-cscope
    
    echo "-->creating the backup of /usr/bin/vim"
    sudo mv /usr/bin/vim /usr/bin/vim-old
    
    echo "-->Execute the installer with superuser mode, "
    echo "-->basically the binary copy to the path /usr/local/bin"
    make install
    
    
    echo "-->creating the /usr/local/bin link"
    sudo ln -s /usr/local/bin/vim /usr/bin/vim
    
    echo "-->Exporting the current path"
    export PATH=/usr/local/bin:$PATH
    
    echo "-->Go to $HOME path"
    cd $HOME
    echo "-->done!"
}

function uninstall_vim {
    read -p "Are you sure to uninstall emacs? (y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "-->Go to source folder"
        cd "$HOME/vim/vim-$version"
        echo "-->uninstalling..."
        sudo make uninstall
        
        echo "-->Welcome back old vim"
        sudo mv /usr/bin/vim-old /usr/bin/vim
        
        cd $HOME
        sudo rm -fr "$HOME/vim/$foldername"
        echo "-->done."
    else
        exit 1
    fi
}

function install_success {
    echo "-->vim has been successfully installed :D"
    vim --version
}

main
