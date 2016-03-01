#!/bin/bash
# ~/.bash_aliases

#aliases for git

alias gam='echo " > git commit -am" && git commit -am '
alias grm='git rm'
alias gmv='git mv'
alias grr='git reset --hard HEAD'
alias goop='git commit --amend -C HEAD -n'
alias ga='git add'
alias gp='git pull'
alias gpu='echo " > git push " && git push'
alias gl='git log --name-status'
alias gs='echo " > git status" && git status'
alias gf='echo " > git fetch -p" &&  git fetch -p'
alias gcm='git commit -m'
alias gb='echo " > git branch" && git branch'
alias gbd='git branch -D'
alias gbl='git branch -l'
alias gb='echo " > git branch" && git branch'
alias gfo='git fetch origin'
alias gcb='echo "git checkout -b" && git checkout -b'
alias gc='git checkout'
alias gbr='echo "git branch -r" && git branch -r'
alias gac='echo "git add .; git commit -am " && git add .; git commit -am '
alias gpo='echo "git pull origin ..." && git pull origin '
alias gpuo='echo " > git push origin " && git push origin '
alias gpom='echo " > git pull origin master" && git pull origin master'
alias gpuom='echo " > git push origin master" && git push origin master'
alias gpod='git pull origin development'
alias gpuod='git push origin development'
alias gpor='git pull origin releases'
alias gpuor='git push origin releases'
#alias gcm='git checkout master'
alias gcr='git checkout releases'
alias gcd='git checkout development'
alias gch='git checkout hotfix'
alias gcp='git checkout pre'
alias gmh='git merge hotfix'
alias gmd='git merge development'
alias gmr='git merge releases'
alias gmm='git merge master'
alias gff='git fetch -p && git rebase origin/\$(just_git_branch)'
alias gls='git log --pretty=format:"%C(reset)%h %C(yellow)%ad%C(yellow)%d %C(reset)%s%C(green) [%cn]" --decorate --date=short'
alias gclone='echo " > git clone " && git clone '
alias gcount='echo " > git shortlog -s -n --all" && git shortlog -s -n --all'
alias gla='echo " > git log --author" && git log --author '
alias gsa='git stash apply'
#alias gcbo='echo " > Create And Check NewBranch" && git checkout -b '

# alises for off/reset of linux system
alias off='sudo halt'
alias reset='sudo reboot'

# Resstart Services
function restart() {
echo " > sudo service $1 restart"
sudo service $1 restart
}

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# network
alias redes='nmcli r'
alias devices='nmcli dev'
alias conectar='nmcli r wifi on'
alias desconectar='nmcli r wifi off'

function wifi() {
   nmcli dev wifi connect $1 password $2 
}

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

#Utils#
alias szsh='source ~/.zshrc'
alias ebal='vim ~/.bash_aliases'
alias cls='clear'
alias cpa='cp -a'

#Reload zsh
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias zshrc="vim ~/.zshrc && reload"

#Alias Folders
alias pro="cd ~/Dev/proyectos"
alias dfc="cd ~/.dotfiles/config"
alias dotf="cd ~/.dotfiles"

#Tmux
alias tmuxdev='~/.dotfiles/tmux/tmuxdev'
alias t4='~/.dotfiles/tmux/t4'
alias tkill='tmux kill-session'
alias starcraft='wine /home/edgar/games/SC1.16/StarCraft.exe'

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux"  ]; then
        tmux rename-window "$(echo $* :call <SNR>113_align()
        a cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
       command ssh "$@"
    fi
}

#Util
alias fmin='find . -user root -type f -mmin'
alias cfmin='find . -user root -type f -mmin -100 | tr "\n" " " | xargs -r chown edgar:edgar'
alias sc='wine /home/edgar/games/SC1.16/StarCraft.exe'
alias tf='tail -f'
alias rmr='rm -rf'
alias targea='tar -zcvf'
alias descom='tar -xvzf'
alias llf='find $1 -type f -exec stat --format "%Y :%y %n" "{}" \; | sort -nr | cut -d: -f2- | head'

#Docker
alias dim='docker images'
alias dco='docker ps -a'
alias dst='docker stop'
alias dr='docker run -ti'
alias dcm='docker commit -m'
alias drm='docker rm'
alias drmi='docker rmi'
alias dexe='docker exec -ti'
alias drelo='docker restart'
alias dcu='docker-compose up'
alias dps='docker-compose ps'
alias dcc2='docker rm `docker ps --no-trunc -aq`'
alias dcc='docker rm -v $(docker ps -a -q -f status=exited) && docker rmi $(docker images -f "dangling=true" -q)'
alias dcs='docker-compose stop'
#Tree
alias tr='tree --charset nwildner'
alias tr2='tree -L 2'
alias tr3='tree -L 3'
alias tr4='tree -L 4'

#Python
alias py='python'

#Ansible
alias apb="cd ~/Dev/ansible/playbook"

#Vagrant
alias vu='vagrant up'
alias vini='vagrant init'
alias vha='vagrant halt'
alias vssh='vagrant ssh'
alias vst='vagrant status'
alias vdu='echo "Apagando ..." && vagrant halt && echo "Destruyendo!!" && vagrant destroy -f && echo "Levantando" && vagrant up'
alias vba='vagrant box add'
alias vbr='vagrant box remove -f'
alias vd='vagrant destroy -f'
alias vl='vagrant box list'
alias vrelo='echo "Apagando Vagrant" && vagrant halt && echo "Encendiendo Vagrant" && vagrant up'

#Ansible

#apb() {
#   ansible-playbook -k -u $1 playbook.yml
#}
#

