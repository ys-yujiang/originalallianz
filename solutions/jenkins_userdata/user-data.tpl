#!/usr/bin/env bash
# Description : User data script to mount the EFS of Jenkins to the ASG of Jenkins
set -ex
yum install -y aws-cfn-bootstrap
service jenkins stop
aws_az=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
mkdir /mnt/efs/
# Mount Command : mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-7764912e.efs.eu-central-1.amazonaws.com:/ /mnt/efs
# Mount the EFS
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efs_dns}.efs.${aws_region}.amazonaws.com:/ /mnt/efs
if [ -s /mnt/efs/config.xml ]; then
echo "The efs has Jenkins files"
umount /mnt/efs
echo "Empty Jenkins Home"
rm -rf ${jenkins_home}/*
# Mount the EFS
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efs_dns}.efs.${aws_region}.amazonaws.com:/ ${jenkins_home}
else
echo "The efs has no files mount the Jenkins Home directory"
mv -fn ${jenkins_home}/* /mnt/efs
umount /mnt/efs
echo "Empty Jenkins Home"
rm -rf ${jenkins_home}/*
# Mount the EFS
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efs_dns}.efs.${aws_region}.amazonaws.com:/ ${jenkins_home}
chmod -R 770 ${jenkins_home}/
chown -R jenkins:jenkins ${jenkins_home}/
fi
service jenkins start
rm -rf /mnt/efs/