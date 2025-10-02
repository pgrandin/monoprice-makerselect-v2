#!/bin/bash
set -euo pipefail

docker build --build-arg CACHE_DATE=$(date +"%m/%d-%H:%M") -t marlin .

container_id=$(docker create --name marlin-build marlin)
trap 'docker rm -f "$container_id" >/dev/null 2>&1 || true' EXIT

docker cp "$container_id:/Marlin/.pio/build/LPC1768/firmware.bin" ./firmware.bin

md5sum firmware.bin

mv firmware.bin "$(git rev-parse HEAD).bin"
