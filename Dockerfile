FROM rawmind/alpine-tools:0.3.4-4
MAINTAINER Raul Sanchez <rawmind@gmail.com>

ENV KEEP_ALIVE=1 

# Add start script
ADD root /
RUN tar xzvf ${SERVICE_ARCHIVE} -C ${SERVICE_VOLUME} ; rm ${SERVICE_ARCHIVE} \
  && cd ${SERVICE_VOLUME} \
  && tar czvf ${SERVICE_ARCHIVE} * ; rm -rf ${SERVICE_VOLUME}/*