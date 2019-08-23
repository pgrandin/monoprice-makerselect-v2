FROM ubuntu
RUN apt-get update && apt-get install -y python-pip
RUN pip install platformio
RUN apt-get install -y git
ARG CACHE_DATE=not_a_date
ADD . /sbase
RUN cd /sbase/Marlin && patch -p0 < ../sbase.patch
RUN cd /sbase/Marlin && platformio run -e LPC1768
RUN md5sum /sbase/Marlin/.pioenvs/LPC1768/firmware.bin
