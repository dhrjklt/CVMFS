# CVMFS (Cern Virtual File System) 

Installation steps to mount belle repo in local machine.

## Prequeist 

1. Squid proxy server with the basic settings 
### squid listen ports
http_port 3128
### set up file system (use aufs or ufs) and directory for caching files, 50000 is disk space in MB which can be used for caching files. 
cache_dir aufs /var/spool/squid 50000 16 256
### maximum object size
maximum_object_size 4096 MB
### memory cache
cache_mem 4096 MB
### Add your local network to your ACLs and other rights depend on your security level. At least to give access for cvmfs clients.
acl local_net src network_addr/mask_addr
http_access allow local_net
### alternately for test purpose http_access allow all

2. Minimum required cached in local machine for CVMFS 20 GB. 
