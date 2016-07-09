#!/bin/bash
chown mfs:mfs -R /var/lib/mfs
if [ ! -f /var/lib/mfs/metadata.mfs ]
then
  cp /root/mfs/metadata.mfs.empty /var/lib/mfs/metadata.mfs
fi

cp /root/mfs/mfsexports.cfg.dist /etc/mfs/mfsexports.cfg
perms=$( echo $ALLOWRW | tr ";" "\n" )
for perm in $perms
do
  echo "Allow access to network $perm"
  echo "$perm / rw,alldirs,maproot=0" >>/etc/mfs/mfsexports.cfg
done

mfsmaster -d start
