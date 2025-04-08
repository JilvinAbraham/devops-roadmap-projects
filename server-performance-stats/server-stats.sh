#!/bin/bash

# Display CPU, memory, disk usage, and system information
echo "Fetching system information..."

# Use 'top' command to get CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Use 'free' command to get memory usage
MEMORY_INFO=$(free -m | grep Mem)
TOTAL_MEMORY=$(echo $MEMORY_INFO | awk '{print $2}')
USED_MEMORY=$(echo $MEMORY_INFO | awk '{print $3}')
FREE_MEMORY=$(echo $MEMORY_INFO | awk '{print $4}')
USED_MEMORY_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($USED_MEMORY/$TOTAL_MEMORY)*100}")
FREE_MEMORY_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($FREE_MEMORY/$TOTAL_MEMORY)*100}")

# Use 'df' command to get disk usage
DISK_INFO=$(df -h / | grep '/')
TOTAL_DISK=$(echo $DISK_INFO | awk '{print $2}')
USED_DISK=$(echo $DISK_INFO | awk '{print $3}')
FREE_DISK=$(echo $DISK_INFO | awk '{print $4}')
USED_DISK_PERCENT=$(echo $DISK_INFO | awk '{print $5}')

# Get uptime and load average
UPTIME_INFO=$(uptime -p)
LOAD_AVERAGE=$(uptime | awk -F'load average:' '{print $2}' | xargs)

# Get OS version
OS_VERSION=$(cat /etc/os-release | grep '^PRETTY_NAME=' | cut -d '"' -f2)

# Get logged-in users
LOGGED_IN_USERS=$(who | wc -l)

# Get top 5 processes by CPU usage
TOP_CPU_PROCESSES=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)

# Get top 5 processes by memory usage
TOP_MEM_PROCESSES=$(ps -eo pid,comm,%mem --sort=-%mem | head -n 6)

# Display system information
echo "CPU Usage: $CPU_USAGE%"
echo "Memory Usage: $USED_MEMORY_PERCENT% used, $FREE_MEMORY_PERCENT% free"
echo "Disk Usage: $USED_DISK used, $FREE_DISK free ($USED_DISK_PERCENT used)"
echo "Uptime: $UPTIME_INFO"
echo "Load Average: $LOAD_AVERAGE"
echo "OS Version: $OS_VERSION"
echo "Logged-in Users: $LOGGED_IN_USERS"

# Display top 5 processes by CPU usage
echo -e "\nTop 5 Processes by CPU Usage:"
echo "$TOP_CPU_PROCESSES"

# Display top 5 processes by memory usage
echo -e "\nTop 5 Processes by Memory Usage:"
echo "$TOP_MEM_PROCESSES"