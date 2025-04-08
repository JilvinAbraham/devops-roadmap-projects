#!/bin/bash

# filepath: d:\Projects\devops-roadmap-projects\log-archive-tool\log-archiver.sh

# Check if the user provided a directory path
if [ -z "$1" ]; then
  echo "Usage: $0 <directory_path>"
  exit 1
fi

# Input directory path
LOG_DIR=$1

# Check if the directory exists
if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory $LOG_DIR does not exist."
  exit 1
fi

# Create a timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Archive and compress the logs
ARCHIVE_NAME="logs_archive_$TIMESTAMP.tar.gz"
DESTINATION="/tmp/$ARCHIVE_NAME"

echo "Archiving and compressing logs from $LOG_DIR..."
tar -czf "$DESTINATION" -C "$LOG_DIR" .

# Check if the operation was successful
if [ $? -eq 0 ]; then
  echo "Logs have been archived and compressed successfully."
  echo "Archive stored at: $DESTINATION"
else
  echo "Error: Failed to archive and compress logs."
  exit 1
fi