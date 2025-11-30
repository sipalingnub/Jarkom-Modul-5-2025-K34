#!/bin/bash
# Script DHCP Relay Auto-Detect Interface

# 1. Pastikan Internet Nyala (Inject DNS)
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# 2. Install Paket
echo "Installing Relay..."
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install isc-dhcp-relay -y

# 3. Konfigurasi Otomatis
SERVER="192.228.2.42"
# Ambil semua interface eth* yang ada
IFACES=$(ls /sys/class/net | grep eth | tr '\n' ' ')

cat > /etc/default/isc-dhcp-relay <<EOF
SERVERS="$SERVER"
INTERFACES="$IFACES"
OPTIONS=""
EOF

# 4. Wajib Forwarding
if ! grep -q "net.ipv4.ip_forward=1" /etc/sysctl.conf; then
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
fi
sysctl -p

service isc-dhcp-relay restart
echo "DHCP Relay Berhasil Dikonfigurasi!"