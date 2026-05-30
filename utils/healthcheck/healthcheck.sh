#!/bin/bash

PORT="${1:-60000}"

if ! [[ "${PORT}" =~ ^[0-9]+$ ]] || (( PORT < 1 || PORT > 65535 )); then
  echo "Error: invalid port '${PORT}'"
  exit 1
fi

echo "[$(date)] Listening on port ${PORT}"

while true; do
  echo -e "HTTP/1.1 200 OK\r\nContent-Length: 0\r\n\r\n" | nc -l -p "${PORT}" -q 1
done
