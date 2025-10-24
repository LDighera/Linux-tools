# auto-update-on-off.sh		This script will enable and disable unattended-updates
#
# LGD: Thu Jun  1 15:00:09 PDT 2017
#

#set -x	#	DEBUG
FILNAM="/etc/apt/apt.conf.d/10periodic"
OFF="APT::Periodic::Unattended-Upgrade \"0\";" 
ON="APT::Periodic::Unattended-Upgrade \"1\";" 

status(){	# Get current status
  if [[ -s "$FILNAM" ]] ;then		# Does file exist with >0 file length?
        [[ $(grep -qs 1 "$FILNAM") ]] && STATUS=Enabled
        [[ $(grep -qs 0 "$FILNAM") ]] && STATUS=Disabled
  else
        STATUS="Not Configured (Disabled)"
  fi
    
#STATUS=$(`ls /etc/apt/apt.conf.d/10periodic 2>&1 >/dev/null`;echo $?)
#STATUS=$([[ -f /etc/apt/apt.conf.d/10periodic ]]  >/dev/null`;echo $?)
#STATUS=$(`ls /etc/apt/apt.conf.d/10periodic 2>&1 >/dev/null`echo $?)
  return $STATUS
}

#[[ $# != 1 ]] && echo -e "\n\t\"$@\" Unknown\n\tUsage: $0 <e|d|s> \n\t\tWhere:  e = Enable\n\t\t\td = Disable" >&2 && exit 1 
#[[ $1 != [dDeEsS]* ]] && echo -e "\n\t\"$@\" Unknown\n\tUsage: $0 <e|d|s> \n\t\tWhere:  e = Enable\n\t\t\td = Disable" >&2 && exit 1 
#[[ $1 != [dDeEsS]* || $# != 1 ]] && echo -e "\n\t\"$@\" Unknown\n\tUsage: $0 <e|d|s> \n\t\tWhere:  e = Enable\n\t\t\td = Disable" >&2 && exit 1 
#[[ $# != 1 || $1 != [dDeEsS]* ]] && echo -e "\n\t\"$@\" Unknown\n\tUsage: $0 <e|d|s> \n\t\tWhere:  e = Enable\n\t\t\td = Disable\n\t\t\ts = Status" >&2 && exit 1 
[[ $# != 1 ]] && echo -e "\n\t\"$@\" Unknown\n\tUsage: $0 <e|d|s> \n\t\tWhere:  e = Enable\n\t\t\td = Disable\n\t\t\ts = Status" >&2 && exit 1 

case $1 in 
  -[sS]*) status; echo "Current $0 status: $STATUS">&2;exit 0	;;
#  -[sS]*) echo "Current $0 status: $STATUS">&2;exit 0	;;
  -[dD]*) echo "$OFF" >/etc/apt/apt.conf.d/10periodic	;;
  -[eE]*) echo "$ON"  >/etc/apt/apt.conf.d/10periodic	;;
  *) echo -e "\n\t\"$@\" Unknown\n\tUsage: $0 <e|d|s> \n\t\tWhere:  e = Enable\n\t\t\td = Disable\n\t\t\ts = Status" >&2 && exit 1 
#  *) echo "$0: Error: $1 unknown" >&2; exit 1		;;
esac  
