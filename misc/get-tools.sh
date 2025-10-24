#!/bin/ksh
# get-tools.sh		This script will install useful packages
# LGD Thu Jan 25 11:16:03 AM PST 2024
# LGD: Wed Sep 17 11:32:51 AM PDT 2025  Added DEBUG`
# 
# Make the required subdirectories to support our scripts.
DIRS='.history log'
for i in $DIRS; do
	ls -d /root/$i || mkdir /root/$i
done

# Create aliases
echo "alias lines='wc -l'" >>/root/.aliases


[ $1 == "DEBUG" ] && set -xv

# Package list
PKGLST="aisleriot
arp-scan
calendar
cpuinfo
curl
dosfstools
filezilla
gimp
gimp-data-extras
gimp-help-en
gnome-disk-utility
gnome-power-manager
gpart
gparted
im
inxi
ir-keytable
kpartx
ksh93u+m
lirc
lm-sensors
logrotate
lshw
lynx
mailcheck
mpg123
mplayer
mpv
mtools
pigz
pm-utils
pychess
screen
sensors-applet
shellcheck
ssl-cert
synaptic
tldr
vim-syntastic
vsftpd
ftp
whois
xtide
xtide-coastline
xtide-data
yt-dlp"

GET() {
# get.sh	Install packages
#
# A front-end for 'apt-get' that provides package installation information before installing packages and logs actions
#
# LGD: Sat 25 Jun 07:56:55 PDT 2016
# LGD: Tue 05 May 2020 10:43:28 AM PDT: Bug fixes and enhancements
#

# Check for positional parameters
[[ $# -lt 1 ]] && echo -e "\n\tUsage: $0 [package names]\n" && exit 1 

# Set variable values and verify log file structure
PROG=$(basename $0)
ARGS="$@"
LOGDIR="$HOME/logs/" 
LOGFIL="$HOME/logs/$(basename $0).log" 
# Check for existance of log directory and writable log file
if [[ -d ${LOGDIR} ]] ;then
  :
else echo -e "\n${0}: Log directory $LOGDIR does not exist." >&2 
  exit 2
fi

if [[ -w ${LOGFIL} ]] ;then
  :
else echo -e "\n${0}: Log file ${LOGFIL} does not exist or is not writeable." >&2
  echo -e "Creating $LOGFIL"; touch -a "$LOGFIL" || exit 3
fi

echo -e "\n${PROG}: Working.   Please standby ..." >&2	# Display assurance message

# Ehter date into logfile
DATSTAMP() {
  echo -e "\nOOOO- $ARGS -OOOO \c" >>$LOGFIL		# Blank line seperator in log file
  $(/bin/date '+%_A, %B %-d, %Y %H%M %Z'\)>>$LOGFIL)
return 0
}


# Test package installation before continuing
apt-get -s install $@ 2>&1 >/dev/null; EXSTAT=$?	# Test for success: 100=Unable to locate package; 0=Already newest version

# Get the package
case $EXSTAT in		# 0=fount; 1=fail; 100=Unable to locate package(S)
  0) echo -e "\nInstall $@ [y/N]? \c"			# Install package
	read REPLY
	[[ ${REPLY} == [yY] ]] && DATSTAMP
	apt-get install $@ 2>&1 |tee -a $LOGFIL		;;	# Install package(s)
  "100") DATSTAMP;echo -e "\nUnable to locate package(s)  $@"|tee -a $LOGFIL ; return 100		;;	# Log event
  *) echo "EXTSTAT = $EXTSTAT";echo -e "\n${0}: Package install failure (${?}).";return 5		;;	# Report failure with exit code
esac 

return $?
}


# MAIN
for i in $PKGLST ;do
  echo $i
  read -r -n 1 REPLY?"`echo -e \"\nEnter to install$(tput smso) $i $(tput rmso) Q to quit: \"`";echo	# Prompt for user action
  case $REPLY in
    [qQ])  exit		;;	# Uwer quit
    *) GET $i		;;	# Return codes left for future
  esac
done
