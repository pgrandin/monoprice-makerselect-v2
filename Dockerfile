FROM ubuntu:18.04
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install platformio
RUN apt-get install -y git
ARG CACHE_DATE=not_a_date
ADD . /sbase
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN cd /sbase/Marlin && patch -p0 < ../sbase.patch
RUN cd /sbase/Marlin && platformio run -e LPC1768
RUN md5sum /sbase/Marlin/.pio/build/LPC1768/firmware.bin
