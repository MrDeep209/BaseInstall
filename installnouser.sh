#!/bin/bash

# Update and install software
apt-get -y update ; apt-get -y dist-upgrade
apt-get -y install htop fail2ban tmux screen vim ntp sudo dnsutils software-properties-common
systemctl enable fail2ban
systemctl start fail2ban
systemctl enable ntp
systemctl start ntp



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
