#!/bin/bash
exec > >(tee -a ~/user-installation-log.txt) 2>&1

# Common setup for all instances
sudo apt update -y
sudo apt upgrade -y

# Ansible-specific setup
sudo apt install ansible -y
echo "Ansible installed on $(hostname)"

EOF
