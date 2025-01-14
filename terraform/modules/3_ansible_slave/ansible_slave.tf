##########################
# SSH
##########################
resource "tls_private_key" "ansible_slave_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  public_key = tls_private_key.ansible_slave_key.public_key_openssh
  key_name = var.key_name
}

############################################################################################
#                                           BASTION                                        #
############################################################################################

resource "aws_instance" "ansible_slave" {
  # Variables
  count                        = 3
  ami                          = var.bastion_ami  
  instance_type                = var.instacne_type
  subnet_id                    = var.public_subnet
  security_groups              = var.bastion_security_groups
  # Other 
  iam_instance_profile         = var.common_iam_instance_profile
  key_name                     = aws_key_pair.generated_key.key_name

  associate_public_ip_address  = true
  disable_api_termination      = true

  root_block_device {
    delete_on_termination        = true
  }
  lifecycle {
    ignore_changes = [
      # Ignore key_name so we keep the same key since the creation
      key_name,
    ]
  }

  user_data = <<-EOF
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
  
  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Name"]}-slave-${count.index + 1}" # Append instance-specific index to Name tag
    }
  )
}
