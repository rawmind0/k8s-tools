FROM rawmind/alpine-tools:0.3.4-3
MAINTAINER Raul Sanchez <rawmind@gmail.com>

ENV KEEP_ALIVE=1

# Add start script
ADD root /
RUN tar xzvf /opt/tools.tgz -C ${SERVICE_VOLUME} ; rm /opt/tools.tgz \
  && cd ${SERVICE_VOLUME} \
  && tar czvf /opt/tools.tgz * ; rm -rf ${SERVICE_VOLUME}/*