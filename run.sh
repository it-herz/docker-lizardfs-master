#!/bin/bash
chown mfs:mfs -R /var/lib/mfs
if [ ! -f /var/lib/mfs/metadata.mfs ]
then
  cp /root/mfs/metadata.mfs.empty /var/lib/mfs/metadata.mfs
fi

cp /root/mfs/mfsexports.cfg.dist /etc/mfs/mfsexports.cfg
echo "172.16.0.0/12 / rw,alldirs,maproot=0" >> /etc/mfs/mfsexports.cfg
echo "10.0.0.0/16 / rw,alldirs,maproot=0" >> /etc/mfs/mfsexports.cfg

mfsmaster -d start
