# boot2cli.sh	Debian defaults to X11 when installed.  This script will change to command-line login default
# LGD: Sun May 28 13:18:24 PDT 2017 # LGD: Wed 13 May 2020 01:20:55 PM PDT Create interactive menu interface 
#

:et -x	# DEBUG

[[ $# -gt 1 ]] && echo -e "\n\tUsage: $(baseneme $0} [-i]\n" >&2 && exit 1	# Issue Usage messate

#	Initalize parameters
CUR_MOD=$(systemctl get-default)
X11="graphical.target"
CLI="multi-user.target"


# Functions
MENU(){
tput clear
cat <<!
	$(tput smso)	S E T   D E F A U L T    S T A R T U P    M O D E    $(tput rmso)

		G = Graphical X11 
		C = Command Line
		Q = Quit

!
# echo "---MENU---"	# DEBUG
### ksh single character 'read' syntax: ksh man page line 2227 (vname?prompt) #### 
PRMPT="Enter your choice? "
[[ $(echo $SHELL |grep ksh) ]] && READ="read -n 1 REPLY?\"${PRMPT}\"" # ksh read syntax
#### bash 'read' syntax: bash man page line 4335 (-p prompt) #### 
[[ -n $BASH ]] && READ="read -n 1 -r -p \"${PRMPT}\""                 # bash read syntax (-r, no varname)
eval ${READ}

case $REPLY in
  c|C) systemctl set-default $CLI && \
	echo "\n\tSystem will boot into command line"				;;
  g|G) systemctl set-default $X11 && \
	echo "\n\tSystem will boot into X-Windows Graphical User Interface"	;;
  *) exit 0									;;
eaac
return
}


# Toggle Mode
SET(){
  if [[ $CUR_MOD == $CLI ]] ;then
    echo -e "\n\tSystem was in Command Line mode; System will boot into X-Windows Graphical User Interface until $(basename $0 is run again."
    return $?
  elif [[ $CUR_MOD == $X11 ]] ;then
    echo -e "\n\tSystem was in X-Windows Graphical User Interface mode; System will boot into Command Line Interface until $(basename $0 is run again."
    return $?
  fi
}


# MAIN
# Check for interactive option
if [[ $# -lt 1 ]] ;then			# Toggle mode
  SET
elif [[ $1 == -l }} ;then		# Menu mode
  MENU
else echo -e "\n\tUsage: $(baseneme $0} [-i]\n" >&2 && exit 1	# Issue Usage messate
fi
exit

