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
  echo "Allow RW access to network $perm"
  echo "$perm / rw,alldirs,maproot=0" >>/etc/mfs/mfsexports.cfg
done

perms=$( echo $ALLOWRO | tr ";" "\n" )
for perm in $perms
do
  echo "Allow RO access to network $perm"
  echo "$perm / ro,alldirs,maproot=0" >>/etc/mfs/mfsexports.cfg
done

IFS=';'
for perm in $PERMISSIONS
do
   if [ ! -z "$perm" ]
   then
     echo "Add rule $perm"
     echo "$perm" >>/etc/mfs/mfsexports.cfg
   fi

done

mfsmetarestore -a
mfsmaster -d start
