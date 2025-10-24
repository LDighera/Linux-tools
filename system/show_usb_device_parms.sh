#
# LGD: Thu 19 Sep 2019 12:44:43 PM PDT 	UNFINISHED
#

tput clear
# set -xv	# DEBUG
MENU() {
  cat <<!


        1.  show USB devoces.
        2.  Select USB device to view all parameters.
        3.  (unimplemented at this time)
        Q.  Quit

!

  read -n 1 REPLY?"Please enter the number of your choice: [Q]? "; echo
  case ${REPLY:-q} in
    1) echo; lsusb | awk '{print "  "NR"  " $0}'					;;	# Display numbered list of USB devices
    2) echo; read CHOICE?"Please enter the number of the device to view: "; echo; DISPPARMS $CHOICE 	;;	# Prompt and display
    3) echo -e "Not yet implemented";sleep 3; MENU					;;
    *) exit                                    						;;
  esac
MENU
}


DISPPARMS(){		# Display full selected USB device parameters.
export CHOICE="$1"
# echo "\$CHOICE=$CHOICE"	# DEBUG
export DEV=$1
#  lsusb -vs $(lsusb | awk '{print NR"\t" $0"\n"}'| awk '/^"$DEV"/ {print $3":"$5}'|cut -b -7)
#lsusb -vs $(lsusb|awk '{print NR"\t"$0}'|awk '/^"$DEV/ {print $0}'|awk '{print $3":"$5}'|cut -b -7)

# DEV=`lsusb|awk '{print NR"\t"$0}'|awk '/^2/ {print $0}'|awk '{print $3":"$5}'|cut -b -7 `
DEV=`lsusb|awk '{print NR"\t"$0}'|awk '/^'"$CHOICE"'/ {print $0}'|awk '{print $3":"$5}'|cut -b -7 `

#lsusb -vs $(lsusb|awk '{print NR"\t"$0}'|awk '/^"$1"/ {print $0}'|awk '{print $3":"$5}'|cut -b -7)
lsusb -vs $DEV|less
}

MENU

exit


NOTES:

 # BUS=002; DEV=002;lsusb | awk '/'"Bus $BUS"'/ {print $0}'

 # lsusb -vs $(lsusb | awk '{print NR"\t" $0'}| awk '/^2/ {print $3":"$5}'|cut -b -7)


