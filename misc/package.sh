#! /usr/bin/ksh
#
# package.sh	This script is a menu wrapper for apt.sh show.sh and get.sh (and perhaps others in the future) which can be made functions.
#
# LGD: Sat 09 May 2020 11:27:00 AM PDT Multi-package functionality not yet implemented.
#

#set -x # DEBUG

# ksh and bash 'read' function
PRMPT="Enter your choice? "
### ksh 'read' syntax: ksh man page line 2227 (vname?prompt) #### 
[[ $(echo $SHELL |grep ksh) ]] && READ="read -n 1 REPLY?\"${PRMPT}\"" # ksh read syntax
#### bash 'read' syntax: bash man page line 4335 (-p prompt) #### 
[[ -n $BASH ]] && READ="read -n 1 -r -p \"${PRMPT}\""                 # bash read syntax (-r, no varname)
#eval ${READ}                                                         # Issue prompt for next page



MENU(){
cat <<!

		S = Search for package
		Q = Quit

!
# echo "---MENU---"	# DEBUG
eval ${READ}
return
}


SHOW(){
  echo -e "\n\n\tEnter package name(s) ? \c"
  read PACK; echo
  for i in $PACK ;do
    show.sh "$PACK"
    echo -e "\tEnter to continue ... \c"
    read PAUSE;echo
  done
  PRMPT="\n\tInstall ${PACK} [N\y]? \c"
  READ="read -n 1 REPLY?\"$(echo -e ${PRMPT})\"" # ksh read syntax
  eval ${READ}
echo "REPLY = $REPLY"	#DEBUG
  return
}


MENU

#set -x # DEBUG

#case $(echo $REPLY) in
case $REPLY in
  S|s) SHOW	;;
  Q|q) exit	;;
  *) exit	;;
esac

case $REPLY in
  y|Y) get.sh $PACK	;;
  *) exit		;;
esac

exit

  ### ksh 'read' syntax: ksh man page line 2227 (vname?prompt) #### 
#  [[ $(echo $SHELL |grep ksh) ]] && READ="read -n 1 REPLY?\"${PRMPT}\"" # ksh read syntax
  #### bash 'read' syntax: bash man page line 4335 (-p prompt) #### 
#  [[ -n $BASH ]] && READ="read -n 1 -r -p \"${PRMPT}\""                 # bash read syntax (-r, no varname)
#  eval ${READ}                                                          # Issue prompt for next page

