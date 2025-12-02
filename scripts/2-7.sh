#!/bin/bash
# Misi 2.7: Batasi akses IronHills max 3 koneksi aktif per IP

# Flush existing rules
iptables -F INPUT

# ALLOW: Loopback dan established
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Limit koneksi HTTP: Max 3 koneksi per IP
iptables -A INPUT -p tcp --dport 80 -m connlimit --connlimit-above 3 --connlimit-mask 32 -j REJECT --reject-with tcp-reset

# Allow koneksi normal (≤3)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

echo "✅ IronHills: Max 3 koneksi bersamaan per IP"
