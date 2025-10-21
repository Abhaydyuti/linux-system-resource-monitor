#!/usr/bin/env python3
# port_scanner.py — basic TCP port scanner using concurrent.futures
# Usage:
#   python3 port_scanner.py <host>            # scans common ports
#   python3 port_scanner.py <host> 1-1024     # scans a range

import sys
import socket
from concurrent.futures import ThreadPoolExecutor, as_completed

COMMON_PORTS = [21,22,23,25,53,67,68,80,110,111,135,139,143,161,162,389,443,445,465,587,993,995,1433,1521,3306,3389,5900,8080]

def parse_ports(s):
    if "-" in s:
        a,b = s.split("-")
        return list(range(int(a), int(b)+1))
    else:
        try:
            return [int(s)]
        except:
            return COMMON_PORTS

def scan_port(host, port, timeout=0.6):
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(timeout)
            result = s.connect_ex((host, port))
            return port, (result == 0)
    except Exception:
        return port, False

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 port_scanner.py <host> [port_or_range]")
        sys.exit(1)

    host = sys.argv[1]
    ports = COMMON_PORTS
    if len(sys.argv) >= 3:
        ports = parse_ports(sys.argv[2])

    print(f"Scanning {host} on {len(ports)} ports...")
    open_ports = []

    with ThreadPoolExecutor(max_workers=200) as ex:
        futures = {ex.submit(scan_port, host, p): p for p in ports}
        for fut in as_completed(futures):
            port, is_open = fut.result()
            if is_open:
                print(f"[OPEN] Port {port}")
                open_ports.append(port)

    if open_ports:
        print("Open ports:", sorted(open_ports))
    else:
        print("No open ports found in the scanned range.")

if __name__ == "__main__":
    main()
