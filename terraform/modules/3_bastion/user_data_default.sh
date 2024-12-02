#!/bin/bash
# Redirect all output (stdout and stderr) to log file
exec > >(tee -a ~/user-installation-log.txt) 2>&1

echo "---------------------------"
echo "Starting Setup...."
echo "Hello from $(hostname -f)!"
echo "---------------------------"
echo "Updating packages..."
echo "---------------------------"
sudo apt update -y
sudo apt upgrade -y

echo "Updating SSH configuration..."
echo "---------------------------"
cat <<EOT >> /etc/ssh/sshd_config
PubkeyAcceptedAlgorithms +ssh-rsa
AllowAgentForwarding yes
AllowTcpForwarding yes
GatewayPorts yes
EOT

sudo chmod 400 /etc/ssh/sshd_config
sudo service ssh restart

echo "Python installation..."
echo "---------------------------"
sudo apt install python3-pip -y
echo $(python3 --version)
echo $(pip3 --version)

sudo apt-get install software-properties-common
sudo apt-add-repository universe
sudo apt install -y ec2-instance-connect
sudo apt install -y postgresql-client

# Install Docker and Docker Compose
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu

echo "---------------------------"
sudo sed 's/PasswordAuthentication yes/PasswordAuthentication no/' -i /etc/ssh/sshd_config
sudo sed 's/#PasswordAuthentication/PasswordAuthentication/' -i /etc/ssh/sshd_config
sudo sed 's/PubkeyAuthentication no/PubkeyAuthentication yes/' -i /etc/ssh/sshd_config
sudo sed 's/#PubkeyAuthentication/PubkeyAuthentication/' -i /etc/ssh/sshd_config

sudo systemctl restart ssh
sudo service ssh restart

username=jacer7
password=jacer7

sudo adduser --gecos "" --disabled-password $username
sudo chpasswd <<<"$username:$password"
sudo usermod -aG sudo datascientest
sudo mkdir /home/datascientest/.ssh/
sudo cp /home/ubuntu/.ssh/authorized_keys  /home/datascientest/.ssh/authorized_keys
sudo chown datascientest /home/datascientest/.ssh/authorized_keys
sudo touch  /home/datascientest/.ssh/know_hosts
sudo chown datascientest /home/datascientest/.ssh/know_hosts

echo "Setup Completed !!"

EOF