FROM      ubuntu:14.04
MAINTAINER Lakshmi Narasimhan <badri.dilbert@gmail.com>

RUN apt-get -y update && apt-get -y install wget && \
    wget http://packages.lizardfs.com/lizardfs.key && apt-key add lizardfs.key && \
    echo "deb http://packages.lizardfs.com/ubuntu/trusty trusty main" > /etc/apt/sources.list.d/lizardfs.list && \
    echo "deb-src http://packages.lizardfs.com/ubuntu/trusty trusty main" >> /etc/apt/sources.list.d/lizardfs.list && \
    apt-get -y update && apt-get -y install lizardfs-master && \
    mkdir -p /var/lib/mfs && \
    cp /var/lib/mfs/metadata.mfs.empty /var/lib/mfs/metadata.mfs && \
    cp /etc/mfs/mfsexports.cfg.dist /etc/mfs/mfsexports.cfg && \
    cp /etc/mfs/mfsmaster.cfg.dist /etc/mfs/mfsmaster.cfg && \
    echo "172.17.0.0/24 / rw,alldirs,maproot=0" >> /etc/mfs/mfsexports.cfg && \
    echo "10.0.0.0/16 / rw,alldirs,maproot=0" >> /etc/mfs/mfsexports.cfg && \
    sed -i 's/LIZARDFSMASTER_ENABLE=false/LIZARDFSMASTER_ENABLE=true/g'  /etc/default/lizardfs-master

EXPOSE 9419 9420 9421 9425

VOLUME /var/lib/mfs

ENTRYPOINT  ["mfsmaster", "-d", "start"]
