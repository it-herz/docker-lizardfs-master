FROM      debian:latest
MAINTAINER Dmitrii Zolotov <dzolotov@herzen.spb.ru>

RUN apt-get -y update && apt-get -y install wget && \
    wget http://packages.lizardfs.com/lizardfs.key && apt-key add lizardfs.key && \
    echo "deb http://packages.lizardfs.com/debian/jessie jessie main" > /etc/apt/sources.list.d/lizardfs.list && \
    echo "deb-src http://packages.lizardfs.com/debian/jessie jessie main" >> /etc/apt/sources.list.d/lizardfs.list && \
    apt-get -y update && apt-get -y install lizardfs-master && \
    mkdir /root/mfs && cp /var/lib/mfs/metadata.mfs.empty /root/mfs && \
    cp /etc/mfs/mfsexports.cfg.dist /root/mfs && \
    cp /var/lib/mfs/metadata.mfs.empty /var/lib/mfs/metadata.mfs && \
    cp /etc/mfs/mfsmaster.cfg.dist /etc/mfs/mfsmaster.cfg && \
    sed -i 's/LIZARDFSMASTER_ENABLE=false/LIZARDFSMASTER_ENABLE=true/g'  /etc/default/lizardfs-master

EXPOSE 9419 9420 9421 9425

VOLUME /var/lib/mfs

ENV ALLOWRW '172.16.0.0/12'
ENV ALLOWRO ''
ENV PERMISSIONS ''

ADD run.sh /

CMD [ "/run.sh" ]
