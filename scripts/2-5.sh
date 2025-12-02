#!/bin/bash
# Misi 2.5: Palantir - Akses berdasarkan jam (Elf: 07-15, Manusia: 17-23)

# Subnet
GILGALAD="192.228.1.0/25"    # Elf - 100 host
CIRDAN="192.228.2.0/27"      # Elf - 20 host
ELENDIL="192.228.0.0/24"     # Manusia - 200 host
ISILDUR="192.228.1.192/26"   # Manusia - 30 host

# Flush existing rules
iptables -F INPUT

# ALLOW: Loopback dan established
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# ALLOW: Faksi Elf akses jam 07:00-15:00
iptables -A INPUT -p tcp --dport 80 -s $GILGALAD -m time --timestart 07:00 --timestop 15:00 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s $CIRDAN -m time --timestart 07:00 --timestop 15:00 -j ACCEPT

# ALLOW: Faksi Manusia akses jam 17:00-23:00
iptables -A INPUT -p tcp --dport 80 -s $ELENDIL -m time --timestart 17:00 --timestop 23:00 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s $ISILDUR -m time --timestart 17:00 --timestop 23:00 -j ACCEPT

# DROP: Akses di luar jam atau dari subnet lain
iptables -A INPUT -p tcp --dport 80 -j DROP

echo "✅ Palantir: Akses dibatasi berdasarkan jam (Elf: 07-15, Manusia: 17-23)"
