#Bienvenidos a mis Dotfiles :D
Hey! tienes una copia fresh linux Mint 17+, y quieres comenzar rápidamente, no hay problema solo necesitamos instalar git y nuestras credenciales de ssh asi:
```
#!/bin/bash
sudo apt-get install -y git-core
ssh-keygen -t rsa -b 4096 -C "email@example.com"
eval "$(ssh-agent -s)"
ssh -T git@github.com
```
###Clonando el repo
```
cd ~
git clone git@github.com:Edux87/dotfilesDev.git .dotfiles
```

###Paquetes Incluidos
Si, todos los paquetes están orientados al desarrollo, para eso tenemos:

- Terminator 0.97
- Tree 1.6
- ngrep
- htop
- VIM 7.4
- Curl
- Zsh y OhMyZsh
- Python
- Tmux 2.0
- spfVim 3
- Ansible
- Vagrant 1.8

Además de útiles aliases para movernos rápidamente por el sistema.
###Instalación
Despues de clonado el repo, solo tienes que ir al home y ejecutar la siguiente linea:
```
cd ~
bash .dotfiles/bootstrap.sh
```
Probablemente necesites ingresar tu password un par de veces, depende de la version de ubuntu que tengas en tu mint.

##Comenzando a Desarrollar Rápidamente!
Conoces al poderoso docker?, al solitario vagrant?, no pues!, desde ya te invito a investigar estos softwares y mejorar tu workflow de desarrollo creando contenedores y ambientes de desarrollo potentes.
##Vagrant 1.7
### Creando un Box
En este link dejo los [repos de boxes](http://www.vagrantbox.es/) compatibles con vagrant, una vez seleccionada la caja a utilizar podemos utilizar estos útiles comandos.
```
#!/bin/bash
# pro es un alias para mi carpeta proyecto ase lo mismo que cd ~/proyectos/

# Ir a mi carpeta proyectos
pro

#Voy a crear una carpeta para alojar mi nuevo proyecto
mkdir demodev

#Ahora a crear distintos ambientes
cd demodev && mkdir dev pre pro

#Volvamos a Vagrant!, Agregaremos un Box
vagrant box add centos7 https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box

#Ahora que tenemos una caja lista para utilizar podemos usarla para nuestros trabajo
vagrant box list

#Ahora que tenemos una caja en nuestra PC, vamos a usarla, ingresamos a nuestra carpeta demodev/dev, e iniciamos el ambiente.
vagrant init centos7

```
Ya tenemos nuestra box, casi lista, veremos que existe un archivo llamado Vagrantfile con configuración por defecto del entorno que se va a levantar, pero solo para este ejercicio necesitamos sobrescribir este file con:
```
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "centos7"
  config.ssh.insert_key = false
  config.vm.hostname = "lamp"

  config.vm.provider :virtualbox do |v|
  v.name = "Centos7Lamp"
  v.memory = 512
  v.cpus = 2
  v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.network "private_network", ip: "192.168.33.10"
end
```
Una vez finalizado, podemos levantar la super caja de Centos7, de la siguiente forma:
```
vagrant up
```
###Aprovisionamiento
Una de las cosas que mas me gusta de esta herramienta es su basta gama de apps para aprovisionar y equipar nuestra caja con el software que vamos a necesitar (chief, puppet, bash, manualmente, dockerfile, etc), pero hoy probare una aprovisionamiento con ... 

###Ansible 1.9
Ansible se puede utilizar en la infraestructura de TI para gestionar y desplegar aplicaciones de software a los nodos remotos. Por ejemplo, digamos que usted necesita para implementar un solo software o varios para 100 de los nodos de un solo comando, aquí ansible entra en el cuadro, con la ayuda de Ansible puede implementar tantos paquetes como aplicaciones a los nodos con un solo mando.

```
#!/bin/bash
# Copiamos nuestras ssh a nuestra Box, espero recuerdes la ip que le pusiste :|, porsiacaso la clave para el user vagrant es 'vagrant' oooooohhhh

ssh-copy-id vagrant@192.168.33.10
#Number of key(s) added: 1
```
Ahora vamos a añadir esta caja, a nuestro inventario, para ello editamos el siguiente archivo:
```
sudo vim /etc/ansible/hosts
# Vamos hasta el final del archivo e ingresamos ...
[webservers-local]
192.168.33.10
```
Vamos a ver si ansible puede acceder a este host, haremos ping!
```
ansible -m ping webservers-local -u vagrant
192.168.33.10 | success >> {
    "changed": false, 
    "ping": "pong"
}
# Whooo hoo!!
# Ahora que te parece si le mandamos un commando ...
ansible -m command -a "df -h" webservers-local -u vagrant
192.168.33.10 | success | rc=0 >>
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/centos-root  8.4G 1000M  7.4G  12% /
devtmpfs                 223M     0  223M   0% /dev
tmpfs                    229M     0  229M   0% /dev/shm
tmpfs                    229M  4.3M  225M   2% /run
tmpfs                    229M     0  229M   0% /sys/fs/cgroup
/dev/sda1                497M   83M  415M  17% /boot
none                      74G   13G   62G  17% /vagrant
# Nicee!!!
```
Existe muchos otros comandos bastante utiles, dejare algunos por aquí:
```
#!/bin/bash
# Tiempo que se encuetra activo la(s) Caja(s).
ansible -m command -a "uptime" webservers-local -u vagrant

# Memoria Libre
ansible -m command -a "free -mt" webservers-local -u vagrant

# Info de la arquitectura del Server
ansible -m command -a "uname -a" webservers-local -u vagrant

# ummh esto parece importante, lo guardare en un file
ansible -m command -a "df -h" webservers-local -u vagrant > /tmp/df_outpur.txt

# Nombres de los Hosts
ansible -m command -a "hostname" webservers-local -u vagrant

# Ejecutar el Playhook
ansible-playbook  -s -k -u vagrant playme.yml --ask-sudo-pass
```
Enjoy!

