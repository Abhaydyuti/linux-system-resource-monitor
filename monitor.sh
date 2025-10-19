#!/bin/bash
# Linux System Resource Monitor by Abhaydyuti Singha

echo "==============================="
echo "  LINUX SYSTEM RESOURCE MONITOR "
echo "==============================="
echo "Date & Time     : $(date)"
echo "Hostname        : $(hostname)"
echo "Uptime          : $(uptime -p)"
echo "--------------------------------"
echo "CPU Usage       : $(top -bn1 | grep 'Cpu(s)' | awk '{print 100 - $8"%"}')"
echo "Memory Usage    : $(free -m | awk 'NR==2{printf "%.2f%% (%sMB/%sMB)", $3*100/$2, $3, $2}')"
echo "Disk Usage (/)  : $(df -h / | awk 'NR==2{print $5 " used of " $2}')"
echo "--------------------------------"
echo "Top 5 Memory-Consuming Processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo "--------------------------------"
echo "Network Statistics:"
ifstat 1 1 | tail -n 1
echo "--------------------------------"
