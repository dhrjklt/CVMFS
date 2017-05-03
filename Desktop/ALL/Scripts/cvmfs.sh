#!/bin/bash

if [ !  -f /etc/yum.repos.d/epel.repo ]; then
echo Please install epel repository
exit
fi

proxy_ip=<server_ip>
export http_proxy=http://${proxy_ip}:3128

wget http://cvmrepo.web.cern.ch/cvmrepo/yum/cernvm.repo -O /etc/yum.repos.d/cernvm.repo
wget http://cvmrepo.web.cern.ch/cvmrepo/yum/RPM-GPG-KEY-CernVM -O /etc/pki/rpm-gpg/RPM-GPG-KEY-CernVM
yum install -y cvmfs-keys cvmfs cvmfs-init-scripts
yum reinstall -y fuse                 
yum reinstall -y autofs
cvmfs_config setup

touch /etc/cvmfs/default.local
echo "CVMFS_REPOSITORIES=belle.cern.ch" >> /etc/cvmfs/default.local
echo "CVMFS_CACHE_BASE=/scratch/cache/cvmfs2" >> /etc/cvmfs/default.local
echo "CVMFS_QUOTA_LIMIT=20000" >> /etc/cvmfs/default.local
echo "CVMFS_HTTP_PROXY=${http_proxy}" >> /etc/cvmfs/default.local

touch /etc/cvmfs/config.d/belle.cern.ch.local
echo 'CVMFS_SERVER_URL="http://cvmfs-stratum-one.cern.ch/opt/belle"' >> /etc/cvmfs/config.d/belle.cern.ch.local
sed -ie 's/^+auto.master/#+auto.master/' /etc/auto.master
service autofs restart

cvmfs_config chksetup
cvmfs_config probe

ls /cvmfs/belle.cern.ch/sl6 -la

