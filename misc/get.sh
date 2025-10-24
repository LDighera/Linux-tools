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

exit $?

