## 🧭 Network Scanner (new)

Added a `network-scanner` module with two tools for LAN troubleshooting:

- **network_scan.sh** — Bash-based subnet host discovery using ICMP ping.  
  Usage: `./network-scanner/network_scan.sh [subnet]` (e.g. `./network-scanner/network_scan.sh 192.168.1`)

- **port_scanner.py** — Multithreaded Python TCP port scanner for service discovery.  
  Usage: `python3 network-scanner/port_scanner.py <host> [port_or_range]` (e.g. `python3 network-scanner/port_scanner.py 192.168.1.10 1-1024`)

**Note:** Only use these tools on networks and devices you own or are authorized to test.
# 🖥️ Linux System Resource Monitor

A simple **Bash script** to monitor system resources such as CPU, memory, disk usage, and top processes — all displayed neatly in your terminal.

## 📋 Features
- Displays CPU, Memory, and Disk usage.
- Lists Top 5 memory-consuming processes.
- Shows network statistics.
- Works on **Linux** and **WSL (Ubuntu)**.

## 🚀 Usage
```bash
bash monitor.sh
