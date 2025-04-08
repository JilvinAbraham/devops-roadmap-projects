#!/bin/bash

LOG_FILE="$1"

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Usage: $0 <log_file>"
  exit 1
fi

echo "Top 5 IP addresses:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5
echo

echo "Top 5 requested paths:"
awk -F\" '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -rn | head -5
echo

echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5
echo

echo "Top 5 user agents:"
awk -F\" '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5
