#!/bin/bash
# Misi 2.2: Blokir semua PING ke Vilya, tapi Vilya tetap bisa ping keluar

# Flush existing rules (opsional, hati-hati jika ada rule lain)
iptables -F INPUT

# ALLOW: Vilya bisa ping keluar (ICMP Echo Reply masuk)
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# ALLOW: Loopback dan established connections
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# DROP: Semua ICMP Echo Request (ping) dari luar
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Log untuk debugging (opsional)
# iptables -A INPUT -p icmp -j LOG --log-prefix "ICMP_BLOCKED: "

echo "✅ Vilya: PING dari luar diblokir, tapi Vilya bisa ping keluar"
