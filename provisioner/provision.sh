#!/bin/bash
USER="alisson"
KEY="alisson_centos"

echo "criação do usuário $USER"
sudo useradd -m -d /home/$USER -s /bin/bash $USER

echo "Adicionando o usuários ao sudoers"
sudo echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/alisson

echo "Criando o diretório .ssh"
sudo mkdir /home/$USER/.ssh

sudo chmod 700 sudo mkdir /home/$USER/.ssh

sudo touch /home/$USER/.ssh/authoryzed_keys

sudo chmod 600 /home/$USER/.ssh

sudo chown -R alisson:alisson /home/$USER/.ssh

ssh-keygen -m PEM -N '' -f /home/$USER/.ssh/$KEY >/dev/null 2>&1

sudo cat /home/$USER/.ssh/$KEY.pub >> /home/$USER/.ssh/authoryzed_keys

echo "Instalação do Apache e execução do setup"
#Instalando o apache e copiando o conteúdo para o diretório padrão
sudo yum install -y httpd vim telnet python curl > /dev/null 2>&1

echo "Copiando os arquivo para o diretório defaul do apache"
cp -r /vagrant/html/* /var/www/html/

#Habilitando o serviço e iniciando
echo "Habilitando o serviço e iniciando"
sudo systemctl enable httpd
sudo systemctl start httpd


#Instalação postgresql debian
# echo "Atualizando os pacotes"
# sudo apt-get update -y >/dev/null 2>&1

# echo "Instalando as dependências do postgresql"
# sudo apt-get install postgresql postgresql-contrib vim -y >/dev/null 2>&1

# echo "Alterando as configurações do postgresql.conf"
# sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/10/main/postgresql.conf

# echo "Alterando o arquivo de configuração do pg_hba.conf"
# sudo sed -i "s/127.0.0.1\/32/0.0.0.0\/0/g" /etc/postgresql/10/main/pg_hba.conf

# echo "restartando o serviço do postgresql"
# sudo service postgresql restart

# echo "Habilitando o serviço do postgresql"
# sudo service postgresql enable 

