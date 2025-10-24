
# system.sh	A script to display system information
# LGD: Fri  9 Sep 16:23:07 PDT 2016
# Added a few more Fri 29 Oct 2021 12:10:11 PM PDT
#

MENU(){
cat <<!
		bcmstat.sh
		sensors.sh
		htop
		memtester
		sdbench.sh
		cpuinfo.sh
		lscpu
		cat /proc/cpuinfo
		lahw
!
}

MENU

