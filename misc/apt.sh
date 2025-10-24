# apt.sh        Initialize package handler
# LGD: Mon Jun  5 11:58:39 PDT 2017
# LGD: Sun Oct  5 09:23:43 AM PDT 2025: Fixed LOGFIL name.
#set -xv                # DEBUG
LOGFIL="$HOME/logs/$(basename $0).log"

# Check for internet connection
STAT(){
  ping -c1 -q 8.8.8.8 2>/dev/null 1>/dev/null ;STATUS=`echo $?`
  return $?
}

# Check for stale lock file
LOCKED(){
  LOCFIL=/var/lib/dpkg/lock
  if [[ -f $LOCFIL ]] ;then                     # Does stale lock file exist?
    ls -l $LOCFIL                               # Display lock file parameters
    read -n 1 CHOICE?"`echo -e \"\nRemove Lock File [Y/n/q]?\c\"`";echo # Prompt for user action
    case $CHOICE in
      q|Q*) exit                                ;; # Quit this script
      *) echo; rm $LOCFIL;return "$?"   ;; # Remove lock file and return to caller with command status
    esac
  fi
  return 0
}

LOCKED                                          # Check for stale lock file
until [[ $STATUS -eq 0 ]] ;do                   # Wait for network connection
  echo -e "Waiting for network connection."
  sleep 3
  STAT
done
setterm -foreground green                       # Set text color to green
echo -e "\n\tNetwork connection successful\n";
#setterm -foreground white                       # Set text color to white
setterm --default                                # Set terminal to default values
#aplay -q /usr/lib/libreoffice/share/gallery/sounds/apert.wav   # Announce successful network connection
aplay -q /usr/share/games/xboard/sounds/cymbal.wav      # Announce successful network connection Debian Bullseye

echo;date +%A", "%B" "%d", "%Y" "%R
read -n 1 CHOICE?"`echo -e \"\nUpdate apt package system before continuing [Y/n]? \"`";echo
case $CHOICE in
 [nN]) exit
                        ;; # Don't update
  *) echo -e "\n##### `date` ####" >> ${LOGFIL};apt-get update 2>&1 | tee -a ${LOGFIL} && apt-get --show-progress upgrade 2>&1 | tee -a ${LOGFIL}       ;; # Update
esac

read -n 1 CHOICE?"`echo -e \"\nUpgrade Debian system before continuing [Y/n]? \"`";echo
case $CHOICE in
 [nN]) exit                                                                                     ;; # Don't upgrade
  *) date >> ${LOGFIL};apt-get --show-progress dist-upgrade 2>&1 | tee -a ${LOGFIL}             ;; # Ugrade
esac
