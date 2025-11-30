#!/bin/bash
# Script Konfigurasi Router Pusat (Osgiliath)

echo "[1/3] Mengaktifkan IP Forwarding..."
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

echo "[2/3] Mengaktifkan NAT (SNAT) ke Internet..."
# Membersihkan rule lama
iptables -t nat -F
# Mendeteksi IP eth0 secara otomatis (sumber internet)
IP_NAT=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
# Memasang rule SNAT (Pengganti Masquerade)
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source $IP_NAT

echo "[3/3] Menambahkan Routing ke Subnet Bawah..."
# Jalur Kiri (Via Moria .66)
ip route add 192.228.1.128/26 via 192.228.2.66
ip route add 192.228.2.32/29 via 192.228.2.66
ip route add 192.228.2.56/29 via 192.228.2.66
# Jalur Tengah (Via Rivendell .70)
ip route add 192.228.2.40/29 via 192.228.2.70
# Jalur Kanan (Via Minastir .74)
ip route add 192.228.0.0/24 via 192.228.2.74
ip route add 192.228.1.192/26 via 192.228.2.74
ip route add 192.228.2.48/29 via 192.228.2.74
ip route add 192.228.1.0/25 via 192.228.2.74
ip route add 192.228.2.0/27 via 192.228.2.74

# Routing Balik untuk Router Cabang (Agar setup_relay sukses)
ip route add 192.228.2.76/30 via 192.228.2.66  # Ke Wilderland
ip route add 192.228.2.80/30 via 192.228.2.74  # Ke Pelargir
ip route add 192.228.2.84/30 via 192.228.2.74  # Ke AnduinBanks

echo "Konfigurasi Osgiliath Selesai!"