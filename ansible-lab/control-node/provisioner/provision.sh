#!/bin/bash

USER=ansible
KEY=ansible

# echo "Instalando o yum epel para a instalação do ansible"
# sudo yum install -y epel-release > /dev/null 2>&1

# echo "Instalando o ansible"
# sudo yum install -y ansible > /dev/null 2>&1

# #O EOT possibilita trabalhar com quebra de linhas para arquivos
# echo "Escrevendo os hosts no arquivo para resolução de nomes"
# cat <<EOT >> /etc/hosts
# 192.168.1.2 control-node
# 192.168.1.3 app01
# 192.168.1.4 db01
# EOT


# sudo useradd -m -d /home/$USER -s /bin/bash $USER

# echo "Criando um arquivo sudoers para o usuário $USER"
# sudo echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER

# echo "Criando o diretório .ssh"
# sudo mkdir /home/$USER/.ssh

# sudo chmod 700 sudo mkdir /home/$USER/.ssh

# sudo touch /home/$USER/.ssh/authoryzed_keys

# sudo chmod 600 /home/$USER/.ssh

# sudo chown -R $USER:$USER /home/$USER/.ssh

# ssh-keygen -m PEM -N '' -f /home/$USER/.ssh/$KEY >/dev/null 2>&1

# sudo cat /home/$USER/.ssh/$KEY.pub >> /home/$USER/.ssh/authoryzed_keys

#----------------------- Melhorando o script ---------------------

# Instalando o yum epel para a instalação do ansible
sudo yum install -y epel-release > /dev/null 2>&1

# Instalando o ansible
sudo yum install -y ansible > /dev/null 2>&1

# Adicionando hosts no arquivo para resolução de nomes
sudo tee -a /etc/hosts << EOT
192.168.1.2 control-node
192.168.1.3 app01
192.168.1.4 db01
EOT

# Criando o usuário $USER com diretório home e shell padrão
#sudo useradd -m -d /home/$USER -s /bin/bash $USER



# Verifica se o usuário já existe
if id "$USER" >/dev/null 2>&1; then
    echo "O usuário $USER já existe. Pulando a criação do usuário."
else
    # Criando o usuário $USER com diretório home e shell padrão
    sudo useradd -m -d /home/$USER -s /bin/bash $USER
    # Criando um arquivo sudoers para o usuário $USER


fi

# Verifica se o diretório .ssh já existe
if [ -d "/home/$USER/.ssh" ]; then
    echo "O diretório .ssh já existe. Pulando a criação do diretório."
else
    # Criando o diretório .ssh
    sudo mkdir -p /home/$USER/.ssh
    sudo chmod 700 /home/$USER/.ssh
fi

# Verifica se o arquivo authoryzed_keys já existe
if [ -f "/home/$USER/.ssh/authoryzed_keys" ]; then
    echo "O arquivo authoryzed_keys já existe. Pulando a criação do arquivo."
else
    # Criando o arquivo authoryzed_keys
    sudo touch /home/$USER/.ssh/authoryzed_keys
    sudo chmod 600 /home/$USER/.ssh/authoryzed_keys
fi

# Verifica se a chave SSH já foi gerada
if [ -f "/home/$USER/.ssh/$KEY" ]; then
    echo "A chave SSH já existe. Pulando a geração da chave."
else
    # Gerando a chave SSH no formato PEM sem senha
    ssh-keygen -m PEM -N '' -f /home/$USER/.ssh/$KEY >/dev/null 2>&1
fi

# Adicionando a chave pública à authoryzed_keys
sudo cat /home/$USER/.ssh/$KEY.pub >> /home/$USER/.ssh/authoryzed_keys

echo "adicionando $USER ao sudoers"
sudo tee /etc/sudoers.d/$USER << EOT
$USER ALL=(ALL) NOPASSWD:ALL
EOT

echo "Ajustando owner do diretório .ssh"
sudo chown -R $USER:$USER /home/$USER/.ssh