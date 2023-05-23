#!/bin/bash

USER=ansible
KEY=ansible

# Verifica se o usuário já existe
if id "$USER" >/dev/null 2>&1; then
    echo "O usuário $USER já existe. Pulando a criação do usuário."
else
    # Criando o usuário $USER com diretório home e shell padrão
    sudo useradd -m -d /home/$USER -s /bin/bash $USER
    
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

# Criando um arquivo sudoers para o usuário $USER
echo "adicionando $USER ao sudoers"
sudo tee /etc/sudoers.d/$USER << EOT
$USER ALL=(ALL) NOPASSWD:ALL
EOT

echo "Ajustando owner do diretório .ssh"
sudo chown -R $USER:$USER /home/$USER/.ssh