#!/bin/bash
# Misi 2.8: Redirect traffic dari Vilya ke Khamul, belokkan ke IronHills

KHAMUL_SUBNET="192.228.2.32/29"
IRONHILLS_IP="192.228.2.58"

# Redirect traffic tujuan Khamul ke IronHills
iptables -t nat -A OUTPUT -d $KHAMUL_SUBNET -j DNAT --to-destination $IRONHILLS_IP

echo "✅ Vilya: Traffic ke Khamul dibelokkan ke IronHills"
