set -e

docker build --build-arg CACHE_DATE=$(date +"%m/%d-%H:%M") -t marlin .

# docker run -ti --rm --name marlin marlin /bin/bash -c "cd /sbase/Marlin && git diff"

docker run -ti --name marlin marlin md5sum /sbase/Marlin/.pio/build/LPC1768/firmware.bin

docker cp marlin:/sbase/Marlin/.pio/build/LPC1768/firmware.bin .
docker cp marlin:/sbase/Marlin/Marlin/Configuration.h Configuration.h
docker cp marlin:/sbase/Marlin/Marlin/Configuration_adv.h Configuration_adv.h
docker rm marlin
