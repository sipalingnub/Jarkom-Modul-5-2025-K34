#!/bin/bash
# Script Web Server (Palantir & IronHills)

# Fix Internet
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

echo "Update & Install Apache..."
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install apache2 -y

echo "Setup Halaman Web..."
HOSTNAME=$(hostname)
echo "Welcome to $HOSTNAME" > /var/www/html/index.html

service apache2 restart
echo "Web Server $HOSTNAME Siap!"