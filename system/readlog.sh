#
# readlog.sh This script will facilitate reading log files
#
# LGD: Sat Nov 16 12:17:55 PST 2013
# LGD: Fri Aug 14 11:45:04 PDT 2015: Originally written for Arch Linux.  Now modified for Debian
# LGD: Tue Jun 30 12:24:38 PDT 2020: Modified for Ubuntu on Nvidia Jetson AGX Xavier; service display addes.
#

# Debug
#set -x
#set -v
#exec $0 2>&1|tee $0.debug     # Puts error messages into "backup.sh.debug" file in the current directory


# Initialize variables

PROMPT_CONTINUE="\n\n\tPlease press any key to continue ... \c"         # Prompt to end wait

typeset IF=""           # The input file device

[ `dmesg -L 2>/dev/null` ] && DMESG_OPT="-L"				# Check if color is supported

# BUG: For some reason the test appears to fail although type exits $?=0.
#unset MNU_JCTL ;[ `type -q journalctl` ] || MNU_JCTL=$(tput smso;echo -e "journalctl not installed\c";tput rmso)	# Check if journalctl package installed, and initalize menu waring message
unset MNU_JCTL ;[ `type -q journalctl` ] && MNU_JCTL=$(tput smso;echo -e "journalctl not installed\c";tput rmso)	# Check if journalctl package installed, and initalize menu waring message
#unset MNU_SCTL ;[ `type -q systemctl` ] || MNU_SCTL=$(tput smso;echo -e "systemctl not installed\c";tput rmso)	# Check if systemctl package installed, and initalize menu waring message
unset MNU_SCTL ;[ `type -q systemctl` ] && MNU_SCTL=$(tput smso;echo -e "systemctl not installed\c";tput rmso)	# Check if systemctl package installed, and initalize menu waring message

# apt-cache shows pacman as being a game on Ubuntu!
unset MNU_PACK ;[ `type -q pacman` ] || MNU_PACK=apt-get								# Check package management system
unset PACLOG ;[ $MNU_PACK ] || PACLOG="/var/log/pacman.log"							# Select correct log file


# Functions:

# This function will generate a sequence of numbers that begins with
# its first argument, is incremented by its second argument, and ends
# with its last argument for use as index parameters in for loops.
# Usage: numbgen org inc end
# See also seq command
function numbgen {
# declare local variables
typeset org=${1:-1} inc=${2:-1} end=${3:-10} condition="-gt" opr="+"
# is output ascending or descending?
if [ $end -lt $org ]
then
        opr="-"
        condition="-lt"
fi
# output the number sequence
until [ $org "$condition" $end ]
do
  echo "$org"
  (( org = org "$opr" inc ))
done
}


WAIT(){                         # Wait for keyboard input
  STTY_PARAM='stty -g'
  stty -icanon eof '^a' min 1
  CHOICE=`dd bs=1 count=1 2>/dev/null`  # Wait for keyboard input
  stty $STTY_PARAM 2>/dev/null
}


MENU () {                       # Display the menu
unset CHOICE
tput clear
cat <<!


                        `tput smso smul`  R E A D    S Y S T E M    L O G E S  `tput rmso rmul`

                                 
        1)      Read last boot log  `echo -e "$MNU_JCTL`

        2)      Read systemctl units last boot log  `echo -e "$MNU_SCTL`

        3)      Read entire system log  `echo -e "$MNU_JCTL`

        4)      Read console boot messages

        5)      Read console boot messages paged (No Color)

	6)	Read ${MNU_PACK:-pacman} log

	7)	Read X11 log

	8)	Display services status

	Q)	Quit


!
}


# Main loop
while : ;do
MENU
echo -e "\t\t\tEnter the number of your choice or Q to quit: \c"
WAIT    # Wait for keyboard input
case $CHOICE in
        1) journalctl -b	;;					# Read last boot log.  See: 'man journalctl' for copious options like: '-o verbose'
        2) systemctl 		;;					# Read systemctl units last boot log.  See: 'man systemctl' for copious options
        3) journalctl -x	;;					# Read entire system log
        #4) dmesg $DMESG_OPT auto -x -e -T |less -R 		;; 	# dmesg -w (follows; not too useful)
# OLD        #4) echo -e "\n\n\tHit any key to start\n\n\t\t^S to stop\n\n\t\t^Q to start\c"; WAIT; dmesg ${DMESG_OPT} -x -T auto ;echo -e "$PROMPT_CONTINUE" ;WAIT ;; # Read console boot messages
        4) echo -e "\n\n\tHit any key to start\n\n\t\t^S to stop\n\n\t\t^Q to start\c"; WAIT; dmesg ${DMESG_OPT} -x -T --color=auto ;echo -e "$PROMPT_CONTINUE" ;WAIT ;; # Read console boot messages
        5) dmesg ${DMESG_OPT} -x -T --color=never |less -R			;; 	# Read console boot messages paged (No Color!)
#        6) less -R /var/log/pacman.log				;; 	# Read the pacman log
        6) less -R ${PACLOG:-/var/log/apt/term.log}		;; 	# Read the package log
        7) less -R /var/log/Xorg.0.log				;; 	# Read the X11 log
        8) /usr/sbin/service --status-all;echo -e "$PROMPT_CONTINUE" ;WAIT	;; 	# Show status of services
        q|Q*) tput clear; exit					;;      # Quit
        *) echo -e "\n\n\t${0}: $(setterm --bold on -foreground red)\"${CHOICE:-}\"$(setterm --bold off -foreground white) is not a valid choice";sleep 3;unset CHOICE; continue;; # Input error; display message and continue
esac

tput clear
done
exit
# Not reached
==========================================================================================

The '-r' option for less displays color sequences rather than text, so the '-R' should probably be changed to '-r'.


Arch dmesg:

Usage:
 dmesg [options]

Options:
 -C, --clear                 clear the kernel ring buffer
 -c, --read-clear            read and clear all messages
 -D, --console-off           disable printing messages to console
 -E, --console-on            enable printing messages to console
 -F, --file <file>           use the file instead of the kernel log buffer
 -f, --facility <list>       restrict output to defined facilities
 -H, --human                 human readable output
 -k, --kernel                display kernel messages
 -L, --color[=<when>]        colorize messages (auto, always or never)
 -l, --level <list>          restrict output to defined levels
 -n, --console-level <level> set level of messages printed to console
 -P, --nopager               do not pipe output into a pager
 -r, --raw                   print the raw message buffer
 -S, --syslog                force to use syslog(2) rather than /dev/kmsg
 -s, --buffer-size <size>    buffer size to query the kernel ring buffer
 -u, --userspace             display userspace messages
 -w, --follow                wait for new messages
 -x, --decode                decode facility and level to readable string
 -d, --show-delta            show time delta between printed messages
 -e, --reltime               show local time and time delta in readable format
 -T, --ctime                 show human readable timestamp
 -t, --notime                don't print messages timestamp
     --time-format <format>  show time stamp using format:
                               [delta|reltime|ctime|notime|iso]
Suspending/resume will make ctime and iso timestamps inaccurate.

 -h, --help     display this help and exit
 -V, --version  output version information and exit

Supported log facilities:
    kern - kernel messages
    user - random user-level messages
    mail - mail system
  daemon - system daemons
    auth - security/authorization messages
  syslog - messages generated internally by syslogd
     lpr - line printer subsystem
    news - network news subsystem

Supported log levels (priorities):
   emerg - system is unusable
   alert - action must be taken immediately
    crit - critical conditions
     err - error conditions
    warn - warning conditions
  notice - normal but significant condition
    info - informational
   debug - debug-level messages

For more details see dmesg(1).

------------
Dabian dmesg:

Usage:
 dmesg [options]

Options:
 -C, --clear                 clear the kernel ring buffer
 -c, --read-clear            read and clear all messages
 -D, --console-off           disable printing messages to console
 -d, --show-delta            show time delta between printed messages
 -E, --console-on            enable printing messages to console
 -f, --facility <list>       restrict output to defined facilities
 -h, --help                  display this help and exit
 -k, --kernel                display kernel messages
 -l, --level <list>          restrict output to defined levels
 -n, --console-level <level> set level of messages printed to console
 -r, --raw                   print the raw message buffer
 -s, --buffer-size <size>    buffer size to query the kernel ring buffer
 -T, --ctime                 show human readable timestamp (could be 
                             inaccurate if you have used SUSPEND/RESUME)
 -t, --notime                don't print messages timestamp
 -u, --userspace             display userspace messages
 -V, --version               output version information and exit
 -x, --decode                decode facility and level to readable string

Supported log facilities:
    kern - kernel messages
    user - random user-level messages
    mail - mail system
  daemon - system daemons
    auth - security/authorization messages
  syslog - messages generated internally by syslogd
     lpr - line printer subsystem
    news - network news subsystem

Supported log levels (priorities):
   emerg - system is unusable
   alert - action must be taken immediately
    crit - critical conditions
     err - error conditions
    warn - warning conditions
  notice - normal but significant condition
    info - informational
   debug - debug-level messages

-------------------------------------------------------------------------
less color:
	 -r or --raw-control-chars
              Causes "raw" control characters to be displayed.  The default is to display control characters using the caret notation; for example, a control-A (octal 001) is displayed as "^A".  Warning: when the -r option
              is used, less cannot keep track of the actual appearance of the screen (since this depends on how the screen responds to each type of control character).  Thus, various display problems may  result,  such  as
              long lines being split in the wrong place.

       -R or --RAW-CONTROL-CHARS
              Like -r, but only ANSI "color" escape sequences are output in "raw" form.  Unlike -r, the screen appearance is maintained correctly in most cases.  ANSI "color" escape sequences are sequences of the form:

                   ESC [ ... m

              where  the  "..." is zero or more color specification characters For the purpose of keeping track of screen appearance, ANSI color escape sequences are assumed to not move the cursor.  You can make less think
              that characters other than "m" can end ANSI color escape sequences by setting the environment variable LESSANSIENDCHARS to the list of characters which can end a color escape sequence.  And you can make  less
              think that characters other than the standard ones may appear between the ESC and the m by setting the environment variable LESSANSIMIDCHARS to the list of characters which can appear.


