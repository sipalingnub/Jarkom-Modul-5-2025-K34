#!/bin/bash
# Script Konfigurasi DNS Server (Narya)

# Fix Internet
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Bersih-bersih & Install Ulang (Safety)
apt-get remove --purge bind9 -y
apt-get autoremove -y
rm -rf /etc/bind
apt-get update
apt-get install bind9 -y

# Buat Folder Cache
mkdir -p /var/cache/bind
mkdir -p /var/lib/bind
chown -R bind:bind /var/cache/bind /var/lib/bind /etc/bind

# Config Options
cat > /etc/bind/named.conf.options <<EOF
options {
        directory "/var/cache/bind";
        forwarders { 192.168.122.1; 8.8.8.8; };
        allow-query { any; };
        dnssec-validation no;
        auth-nxdomain no;
        listen-on-v6 { any; };
};
EOF

# Config Zones
cat > /etc/bind/named.conf.local <<EOF
zone "aliansi.com" {
        type master;
        file "/etc/bind/db.aliansi";
};
EOF

# Database Domain
cat > /etc/bind/db.aliansi <<EOF
; BIND data file for aliansi.com
\$TTL    604800
@       IN      SOA     aliansi.com. root.aliansi.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
@       IN      NS      aliansi.com.
@       IN      A       192.228.2.43
palantir    IN  A       192.228.2.50
ironhills   IN  A       192.228.2.58
www         IN  CNAME   palantir
EOF

# Start Service Manual
killall named 2>/dev/null
/usr/sbin/named -u bind -c /etc/bind/named.conf
echo "DNS Server Narya Berjalan!"