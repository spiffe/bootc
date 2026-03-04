ARG BASE=test

FROM $BASE

RUN \
  echo 'dtparam=spi=on' >> $(readlink -f /usr/lib/modules/*/)/rpi-config.txt && \
  echo 'dtoverlay=tpm-slb9670' >> $(readlink -f /usr/lib/modules/*/)/rpi-config.txt
