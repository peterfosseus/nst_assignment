#!/bin/bash
set -e

SERVICE_FILE="/etc/systemd/system/myapp.service"

echo "Waiting for systemd service file: ${SERVICE_FILE}"

for i in {1..60}; do
    if [ -f "$SERVICE_FILE" ]; then
        echo "Service file found."
        break
    fi

    echo "Waiting for service file... ${i}/60"
    sleep 2
done

if [ ! -f "$SERVICE_FILE" ]; then
    echo "ERROR: ${SERVICE_FILE} was not created"
    exit 1
fi

systemctl stop myapp.service
