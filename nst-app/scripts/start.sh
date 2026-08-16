#!/bin/bash
set -x

SERVICE="myapp.service"
TIMEOUT=300
INTERVAL=5
ELAPSED=0

echo "Waiting for ${SERVICE} to become active..."

while ! systemctl is-active --quiet "$SERVICE"; do
    if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
        echo "ERROR: ${SERVICE} did not become active within ${TIMEOUT} seconds"
        systemctl status "$SERVICE" --no-pager || true
        exit 1
    fi

    sleep "$INTERVAL"
    ELAPSED=$((ELAPSED + INTERVAL))
done

echo "${SERVICE} is active."
