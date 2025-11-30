#!/bin/bash
# Security Rule Vilya: Block Incoming Ping

# Izinkan koneksi established (biar Vilya bisa ping keluar)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Drop ping (ICMP echo-request) yang masuk
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

echo "Rule Vilya Terpasang!"