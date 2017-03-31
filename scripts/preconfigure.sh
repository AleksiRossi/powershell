#!/bin/bash

# Hold Azure linux agent so it doesn't restart and crash the extension during installation
apt-mark hold walinuxagent

# Update package list and system
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Install packages
apt-get install nagios-nrpe-server nagios-plugins fail2ban ntp htop -y

# Create backup user with encrypted password
passwd='$1$xyz$8h8sIuQ2lXT.fHh2fO.Ge1'
user='varakarhu'
useradd -d /home/$user -m -s /bin/bash -p $passwd $user

# Allow RLA public, internal and Sisu
/usr/sbin/ufw allow from 195.192.251.82
/usr/sbin/ufw allow from 10.0.150.0/23
/usr/sbin/ufw allow from 77.73.6.98
/usr/sbin/ufw default deny
/usr/sbin/ufw --force enable

# Enable automatic security updates
echo 'APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::RandomSleep "4000";
APT::Periodic::Unattended-Upgrade "1";' > /etc/apt/apt.conf.d/10periodic
/etc/init.d/unattended-upgrades restart

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

# Set correct timezone
/usr/bin/timedatectl set-timezone Europe/Helsinki

# Configure NTP to use Finnish servers
/bin/sed -ie 's/ubuntu.pool.ntp.org/fi.pool.ntp.org/g' /etc/ntp.conf
/etc/init.d/ntp restart

# Set general environment locale
/usr/sbin/locale-gen en_GB.UTF-8
/bin/sed -ie 's/en_US.UTF-8/en_GB.UTF-8/g /etc/default/locale
echo 'LC_ALL=en_GB.UTF-8' >> /etc/environment

# Unhold Azure Linux agent so you can update it later
apt-mark unhold walinuxagent

# Reboot to ensure all updates and settings are in effect
#/sbin/reboot
