#	whatsmyipaddfess.sh	Display IP address
#
# LGF: Mon 24 Feb 2020 08:53:52 AM PST
#

#ip addr show
#ip addr show wlan0|grep inet|cut -d" "  -f6|cut -d/ -f1
#hostname -I

WINTERFACE=wlan0

echo -e "\nIP Address for ${WINTERFACE}:"
ifconfig ${WINTERFACE:wlan0}|grep inet
hostname -I
