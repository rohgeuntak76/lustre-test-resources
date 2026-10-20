#!/bin/bash

hostnamectl set-hostname $(hostname).lab.nexit.co.kr

nmcli con mod "System eth0" ipv4.ignore-auto-dns yes ipv4.dns ""
nmcli con mod "System eth1" ipv4.ignore-auto-dns yes ipv4.dns "192.168.21.10" ipv4.dns-search "lab.nexit.co.kr"
systemctl restart NetworkManager

dnf module enable -y idm:DL1
dnf module install -y idm:DL1/client

# ipa-client-install --mkhomedir --enable-dns-updates
