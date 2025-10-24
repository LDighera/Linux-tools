# show_os.sh	Display the current Linux OS version information
#
# LGD: Thu 05 Dec 2019 09:52:45 AM PST
# LGD: Sat Jun 27 06:59:30 PDT 2020	Added: lscpu lshw hardinfo
#

PRMPT="Enter to continue [Q]: "
WAIT(){
  ### ksh 'read' syntax: ksh man page line 2227 (vname?prompt) #### 
  [[ $(echo $SHELL |grep ksh) ]] && READ="read -n 1 REPLY?\"${PRMPT}\"" # ksh read syntax
  #### bash 'read' syntax: bash man page line 4335 (-p prompt) #### 
  [[ -n $BASH ]] && READ="read -n 1 -r -p \"${PRMPT}\""                 # bash read syntax (-r, no varname)
  eval ${READ}                                                          # Issue prompt for next page
  [[ $REPLY != [Qq]* ]] && setterm -foreground white && return          # Return to caller
  [[ $REPLY == [Qq]* ]] && setterm -foreground white                    # User request to quit received
  echo -e "\033[0m";exit                                                # Set the Xterminal foreground=black; background=white
}

cat /etc/debian_version
cat /etc/os-release
uname -a
lscpu
WAIT
cat /proc/cpuinfo|less
WAIT
lshw|less
hardinfo
exit


MODEL AND PI REVISION	256MB	HARDWARE REVISION CODE FROM CPUINFO
Model B Revision 1.0	256MB	0002
Model B Revision 1.0 + ECN0001 (no fuses, D14 removed)	256MB	0003
Model B Revision 2.0
Mounting holes	256MB	0004
0005
0006
Model A
Mounting holes	256MB	0007
0008
0009
Model B Revision 2.0
Mounting holes	512MB	000d
000e
000f
Model B+	512MB	0010
Compute Module	512MB	0011
Model A+	256MB	0012
Pi 2 Model B	1GB	a01041 (Sony, UK)
a21041 (Embest, China)
PiZero	512MB	900092(no camera connector)
900093(camera connector)
Pi 3 Model B	1GB	a02082 (Sony, UK)
a22082 (Embest, China)
PiZero W	512MB	9000c1
##UPDATED##
The completed list can now be found here  https://elinux.org/RPi_HardwareHistory


aspberry Pi 4 Model B
Announced on 24th June 2019 (announcement). The Raspberry Pi 4 is a new Pi design, with ethernet + USB ports swapping positions from previous models. In addition, the 4 has three variants, only differing in amount of RAM: 1/2/4GB models, selling for $35/45/55.


Raspberry Pi 4 1GB model
The Raspberry Pi 4 features:

Broadcom BCM2711 SoC, with quad-core ARM Cortex-A72 1.5 GHz processor
1GB, 2GB, or 4GB of LPDDR4 SDRAM
Full-throughput Gigabit Ethernet
Dual-band 802.11ac wireless networking
Bluetooth 5.0
Two USB 3.0 and two USB 2.0 ports
Dual monitor support, at resolutions up to 4K
VideoCore VI graphics, supporting OpenGL ES 3.x
4Kp60 hardware decode of HEVC video
Power over USB-C connector (v1.0 board has a faulty USB-C design which limits the cables that can be used to power the Pi (see here)).
Complete compatibility with earlier Raspberry Pi products


