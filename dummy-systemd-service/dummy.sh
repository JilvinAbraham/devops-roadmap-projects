#!/bin/bash

while true; do
  echo "Dummy service is running by systemd..." >> /tmp/log/dummy-service.log
  sleep 2
done