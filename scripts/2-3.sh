#!/bin/bash
# Misi 2.3: Hanya Vilya (192.228.2.42) bisa akses port 53 di Narya

VILYA_IP="192.228.2.42"

# Flush existing rules
iptables -F INPUT

# ALLOW: Vilya akses DNS (TCP & UDP port 53)
iptables -A INPUT -p tcp -s $VILYA_IP --dport 53 -j ACCEPT
iptables -A INPUT -p udp -s $VILYA_IP --dport 53 -j ACCEPT

# ALLOW: Loopback dan established
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# DROP: Semua akses lain ke port 53
iptables -A INPUT -p tcp --dport 53 -j DROP
iptables -A INPUT -p udp --dport 53 -j DROP

echo "✅ Narya: Hanya Vilya bisa akses DNS (port 53)"
