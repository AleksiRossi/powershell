#!/bin/bash

# Update package list and system
apt-get update && apt-get upgrade -y && apt-get upgrade -y

# Install packages
apt-get install nagios-nrpe-server nagios-plugins fail2ban ntp -y

# Create backup user with encrypted password
passwd='$1$xyz$8h8sIuQ2lXT.fHh2fO.Ge1'
user='varakarhu'
useradd -d /home/$user -m -s /bin/bash -p $passwd $user

# Allow RLA public, internal and Sisu
/usr/sbin/ufw allow from 195.192.251.82
/usr/sbin/ufw default deny
/usr/sbin/ufw --force enable

# Enable automatic security updates
echo 'APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::RandomSleep "4000";
APT::Periodic::Unattended-Upgrade "1";' > /etc/apt/apt.conf.d/10periodic
/etc/init.d/unattended-upgrade restart

# Kernel hardening
echo '# Enable IP spoofing protection
net.ipv4.conf.all.rp_filter=1
# Disable IP source routing
net.ipv4.conf.all.accept_source_route=0
# Ignoring broadcasts request
net.ipv4.icmp_echo_ignore_broadcasts=1
# Make sure spoofed packets get logged
net.ipv4.conf.all.log_martians = 1
# Enable TCP SYN cookie protection
net.ipv4.tcp_syncookies = 1' >> /etc/sysctl.conf
/sbin/sysctl -p
