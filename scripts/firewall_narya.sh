#!/bin/bash
# Security Rule Narya: Limit DNS Access

VILYA="192.228.2.42"

# Izinkan Vilya akses Port 53 (UDP/TCP)
iptables -A INPUT -s $VILYA -p udp --dport 53 -j ACCEPT
iptables -A INPUT -s $VILYA -p tcp --dport 53 -j ACCEPT

# Blokir akses DNS dari IP lain
iptables -A INPUT -p udp --dport 53 -j DROP
iptables -A INPUT -p tcp --dport 53 -j DROP

echo "Rule Narya Terpasang!"