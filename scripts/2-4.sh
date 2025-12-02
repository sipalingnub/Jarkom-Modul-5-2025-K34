#!/bin/bash
# Misi 2.4: IronHills hanya bisa diakses Weekend oleh Durin, Khamul, Elendil, Isildur

# Subnet yang diizinkan
DURIN="192.228.1.128/26"     # 50 host
KHAMUL="192.228.2.32/29"     # 5 host
ELENDIL="192.228.0.0/24"     # 200 host
ISILDUR="192.228.1.192/26"   # 30 host

# Flush existing rules
iptables -F INPUT

# ALLOW: Loopback dan established
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# ALLOW: Akses HTTP (port 80) hanya di Sabtu & Minggu dari subnet tertentu
iptables -A INPUT -p tcp --dport 80 -s $DURIN -m time --weekdays Sat,Sun -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s $KHAMUL -m time --weekdays Sat,Sun -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s $ELENDIL -m time --weekdays Sat,Sun -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s $ISILDUR -m time --weekdays Sat,Sun -j ACCEPT

# DROP: Akses HTTP di hari lain atau dari subnet lain
iptables -A INPUT -p tcp --dport 80 -j DROP

echo "✅ IronHills: Hanya bisa diakses Weekend oleh Faksi yang ditentukan"
