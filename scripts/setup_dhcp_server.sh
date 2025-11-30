#!/bin/bash
# Script Installasi DHCP Server (Vilya)

# Pastikan internet nyala
echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

echo "Update & Install..."
apt-get update
apt-get install isc-dhcp-server -y

echo "Configuring Interface..."
echo 'INTERFACESv4="eth0"' > /etc/default/isc-dhcp-server

echo "Writing dhcpd.conf..."
cat > /etc/dhcp/dhcpd.conf <<EOF
default-lease-time 600;
max-lease-time 7200;
option domain-name-servers 192.228.2.43;
option domain-name "aliansi.com";

# Subnet Lokal Vilya
subnet 192.228.2.40 netmask 255.255.255.248 {}

# Elendil
subnet 192.228.0.0 netmask 255.255.255.0 {
    range 192.228.0.10 192.228.0.250;
    option routers 192.228.0.1;
    option broadcast-address 192.228.0.255;
}
# Gilgalad
subnet 192.228.1.0 netmask 255.255.255.128 {
    range 192.228.1.10 192.228.1.120;
    option routers 192.228.1.1;
    option broadcast-address 192.228.1.127;
}
# Isildur
subnet 192.228.1.192 netmask 255.255.255.192 {
    range 192.228.1.200 192.228.1.250;
    option routers 192.228.1.193;
    option broadcast-address 192.228.1.255;
}
# Cirdan
subnet 192.228.2.0 netmask 255.255.255.224 {
    range 192.228.2.10 192.228.2.30;
    option routers 192.228.2.1;
    option broadcast-address 192.228.2.31;
}
# Durin
subnet 192.228.1.128 netmask 255.255.255.192 {
    range 192.228.1.140 192.228.1.190;
    option routers 192.228.1.129;
    option broadcast-address 192.228.1.191;
}
# Khamul
subnet 192.228.2.32 netmask 255.255.255.248 {
    range 192.228.2.35 192.228.2.38;
    option routers 192.228.2.33;
    option broadcast-address 192.228.2.39;
}
EOF

service isc-dhcp-server restart
echo "DHCP Server Siap!"