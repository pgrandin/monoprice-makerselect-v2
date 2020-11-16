docker build --build-arg CACHE_DATE=$(date +"%m/%d-%H:%M") -t marlin .
docker run -ti --name marlin marlin md5sum /sbase/Marlin/.pio/build/LPC1768/firmware.bin
docker cp marlin:/sbase/Marlin/.pio/build/LPC1768/firmware.bin . && docker rm marlin
mv firmware.bin `git rev-parse HEAD`.bin
