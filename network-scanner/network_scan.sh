#!/bin/bash
# network_scan.sh — simple LAN host discovery using ICMP ping
# Usage:
#   ./network_scan.sh 192.168.1
# or
#   ./network_scan.sh       # auto-detects subnet

SUBNET="$1"

if [ -z "$SUBNET" ]; then
  ip_addr=$(ip -4 addr show scope global | grep -oP '(?<=inet\s)\d+\.\d+\.\d+\.\d+' | head -n1)
  if [ -z "$ip_addr" ]; then
    echo "Could not auto-detect IP. Provide subnet as first arg (e.g. 192.168.1)"
    exit 1
  fi
  SUBNET=$(echo "$ip_addr" | awk -F. '{print $1"."$2"."$3}')
  echo "Auto-detected subnet: $SUBNET.0/24 — scanning hosts .1 to .254"
fi

echo "Scanning $SUBNET.1 - $SUBNET.254 for active hosts..."
alive=()

for i in {1..254}; do
  ip="$SUBNET.$i"
  ping -c 1 -W 1 "$ip" &> /dev/null && echo "$ip is up" && alive+=("$ip") &
  if (( $(jobs -r | wc -l) > 50 )); then
    wait -n
  fi
done

wait

echo
echo "Scan complete. Active hosts:"
for h in "${alive[@]}"; do
  echo " - $h"
done

if [ "${#alive[@]}" -gt 0 ]; then
  timestamp=$(date +%Y%m%d_%H%M%S)
  printf "%s\n" "${alive[@]}" > "alive_hosts_${timestamp}.txt"
  echo "Saved: alive_hosts_${timestamp}.txt"
fi
