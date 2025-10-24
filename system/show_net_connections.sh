# LGD: Sun Jul 12 14:49:20 PDT 2020	Search for computers connected to local network
# From: https://askubuntu.com/questions/82480/how-to-see-all-computers-connected-to-a-network
#

# This is a kludge:
#for ip in $(seq 1 254) ;do
#  ping -c 1 192.168.1.$ip>/dev/null 
#  [ $? -eq 0 ] && echo "192.168.1.$ip UP" || : 
#done

# This shows IP, MAC, device:
# If used with a MAC address table and awk, it might provide system name.
arp-scan 192.168.1.1/24

# From: https://askubuntu.com/questions/82480/how-to-see-all-computers-connected-to-a-network
#!/usr/bin/env python
#
#"""List all hosts with their IP adress of the current network."""
#
#import os
#
#out = os.popen('ip neigh').read().splitlines()
#for i, line in enumerate(out, start=1):
#    ip = line.split(' ')[0]
#    h = os.popen('host {}'.format(ip)).read()
#    hostname = h.split(' ')[-1]
#    print("{:>3}: {} ({})".format(i, hostname.strip(), ip))

