# LGD: Tue Jul 14 15:03:14 PDT 2020	network-scan.sh print IP and MAC of network connections
# LGD: October 3, 2022 update: added sort

# arp-scan 192.168.1.1/24
arp-scan 192.168.1.1/24|sort

exit

# Show all MAC addresses:
./network-scan.sh 2>/dev/null|awk '/^1/ {print$2}'

# Table of known MAC addresses:
/home/ubuntu/Desktop/MAC_addresses7.txt

 # arp-scan 192.168.1.1/24
Interface: wlp3s0, datalink type: EN10MB (Ethernet)
WARNING: host part of 192.168.1.1/24 is non-zero
Starting arp-scan 1.9 with 256 hosts (http://www.nta-monitor.com/tools/arp-scan/)
192.168.1.1	a0:40:a0:8c:9c:12	(Unknown)
192.168.1.3	00:04:4b:cc:87:3f	NVIDIA	Nvidia Shield Ethernet
192.168.1.5	00:18:dd:07:69:30	Silicondust Engineering Ltd HD Homerun TV Server
192.168.1.7	20:e5:2a:25:42:c4	NETGEAR INC.,	NETGEAR32 Mesh router
192.168.1.16	00:04:4b:e5:8a:39	NVIDIA Jetson AGX Xavier Ethernet
192.168.1.17	00:04:4b:e5:8a:39	NVIDIA Jetson AGX Xavier Ethernet
192.168.1.20	7c:dd:90:67:f7:54	Shenzhen Ogemray Technology Co., Ltd. IP-Cam
192.168.1.123	7c:dd:90:67:f7:54	Shenzhen Ogemray Technology Co., Ltd. IP-Cam
192.168.1.2	2c:aa:8e:13:3b:25	(Unknown)
192.168.1.16	14:f6:d8:79:78:95	(Unknown) (DUP: 2) AX200 WiFi/BT card Xavier
192.168.1.17	14:f6:d8:79:78:95	(Unknown) (DUP: 2) AX200 WiFi/BT card Xavier

11 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.9: 256 hosts scanned in 2.901 seconds (88.25 hosts/sec). 11 responded



# There's something wrong with the MAC addresses here:

ip -h address
2: enp2s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether 00:c0:08:8f:97:86 brd ff:ff:ff:ff:ff:ff

3: wlp3s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 10:f0:05:8f:44:5e brd ff:ff:ff:ff:ff:ff

