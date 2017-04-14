#!/bin/bash

# Update and install software
apt-get update ; apt dist-upgrade
apt-get install htop fail2ban tmux screen nload vim ntp sudo dnsutils  -y
systemctl enable fail2ban
systemctl start fail2ban
systemctl enable ntp
systemctl start ntp

# Set a hostname
echo "Hostname?"
read hostname
hostnamectl set-hostname $hostname
echo "127.0.0.1 $hostname" >> /etc/hosts

# Add a root user
echo "Username?"
read username
adduser $username
usermod -aG sudo $username

# Configure ssh and restart
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
echo "
# Added on Startup Script
AllowTcpForwarding no
ClientAliveCountMax 2
Compression no
MaxAuthTries 5
MaxSessions 2
UsePrivilegeSeparation sandbox
AllowAgentForwarding no" >> /etc/ssh/sshd_config
systemctl restart sshd
