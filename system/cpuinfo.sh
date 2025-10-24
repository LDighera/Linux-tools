# cpuinfo.sh	A script to display machine information
#
# LGD: Wed  7 Sep 10:44:18 PDT 2016
#

DISPLAY(){
echo --------------- System Information----------------
uname -a | awk '{print "Kernel name:\t" $1,"\nNetwork node Hostname:\t" $2,"\nKernel release:\t" $3,"\nKernel version:\t" $4" "$5" "$6" "$7" "$8" "$9" "$10,"\nMachine hardware name:\t" $11,"\nOperating system:\t"$12}'
echo -e "\n------------------- OS Release -------------------"
cat /etc/os-release
[ -e /etc/machine-info ] && cat /etc/machine-info
echo -e "\n ---------------- CPU Information -----------------"
lscpu
#echo -e "\n --------------------------------------------------"
cat /proc/cpuinfo
}

DISPLAY|less
exit

==== Not Reached ==========

uname parameters:

 -s, --kernel-name
              print the kernel name

       -n, --nodename
              print the network node hostname

       -r, --kernel-release
              print the kernel release

       -v, --kernel-version
              print the kernel version

       -m, --machine
              print the machine hardware name

       -p, --processor
              print the processor type or "unknown"

       -i, --hardware-platform
              print the hardware platform or "unknown"

       -o, --operating-system
              print the operating system

These should be used by an awk script to formation uname output

1 kernel name: Linux
2 network node hostname: raspberrypi3
3 kernel release: 4.4.13-v7+
4 kernel version:  #894 SMP Mon Jun 13 13:13:27 BST 2016
5 machine hardware name: armv7l

6 (8) operating system: GNU/Linux

uname -a | awk '{print "Kernel name:\t" $1,"\nNetwork node Hostname:\t" $2,"\nKernel release:\t" $3,"\nKernel version:\t" $4" "$5" "$6" "$7" "$8" "$9" "$10,"\nMachine hardware name:\t" $11,"\nOperating system:\t"$12}'

