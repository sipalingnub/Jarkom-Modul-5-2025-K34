#!/bin/bash
# Misi 2.6: Blokir port scan (>15 port dalam 20 detik)

# Flush existing rules
iptables -F INPUT
iptables -F FORWARD

# Create chain untuk port scan detection
iptables -N PORTSCAN 2>/dev/null || iptables -F PORTSCAN

# Log port scan dengan prefix
iptables -A PORTSCAN -j LOG --log-prefix "PORT_SCAN_DETECTED: " --log-level 4

# Drop semua packet dari scanner (PING, TCP, UDP)
iptables -A PORTSCAN -j DROP

# ALLOW: Loopback dan established
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Deteksi port scan: >15 koneksi baru dalam 20 detik
iptables -A INPUT -p tcp --dport 1:100 -m state --state NEW \
    -m recent --set --name portscan

iptables -A INPUT -p tcp --dport 1:100 -m state --state NEW \
    -m recent --update --seconds 20 --hitcount 16 --name portscan \
    -j PORTSCAN

# Allow koneksi normal
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

echo "✅ Palantir: Port scan protection aktif (>15 port/20s = BLOCK)"
