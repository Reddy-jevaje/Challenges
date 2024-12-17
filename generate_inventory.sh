#!/bin/bash

cat <<EOF > inventory.ini
[frontend]
c8.local ansible_host=$(terraform output -raw amazon_linux_public_ip) ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/your_key.pem

[backend]
u21.local ansible_host=$(terraform output -raw ubuntu_public_ip) ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/your_key.pem
EOF
