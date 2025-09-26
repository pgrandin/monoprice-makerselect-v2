docker build --build-arg CACHE_DATE=$(date +"%m/%d-%H:%M") -t marlin .
docker run -ti --name marlin marlin md5sum /Marlin/.pio/build/LPC1768/firmware.bin
docker cp marlin:/Marlin/.pio/build/LPC1768/firmware.bin . && docker rm marlin
mv firmware.bin `git rev-parse HEAD`.bin
