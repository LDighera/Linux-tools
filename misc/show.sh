#!/bin/ksh
# show.sh	Display package informaiton
#
# LGD: Sat 25 Jun 07:56:55 PDT 2016
# LGD: Mon 13 Feb 16:23:15 PST 2017 Added smart-pager support
#

if [[ $(tty |grep pts) ]] ;then
  export LESS="-P\ ?f%f .?n?m(file %i of %m) ..?ltlines %lt-%lb?L/%L. : byte %bB?s/%s. .?e(END) ?x- Next\: %x.:?pB%pB\%..%t (pts`tty|cut -d/ -f4`) "
else
  export LESS="-P\ ?f%f .?n?m(file %i of %m) ..?ltlines %lt-%lb?L/%L. : byte %bB?s/%s. .?e(END) ?x- Next\: %x.:?pB%pB\%..%t (`tty|cut -d/ -f3`) "
fi

# USAGE: Multi-package search not yet implemented
[[ $# -lt 1 ]] && echo -e "\n\tUsage: $0 [package name] <package name> <...>\n" >&2 && exit 1 

LOGFIL="$HOME/logs/$0.log" 
[[ -d ${HOME}/logs ]] || echo -e "\n$0\: Log directory $LOGFIL does not exist$(exit 2)" >&2

#set -x
SRCH=$(echo "$@"|sed 's/*/\\\\*/') # Escape * so shell doesn't show filenames

FOUND=$(/usr/bin/apt-cache show $SRCH 2>&1)	# BUG: Fails to assign value to $FOUND
#FOUND=$(/usr/bin/apt-cache show "$SRCH")

if [[ `echo "$FOUND"|grep "purely virtual"` ]] ;then	# BUG: This fails to display output
  echo "$FOUND" >&2; exit 1
elif [[ `echo "$FOUND"|grep "No packages found"` ]] ;then
  echo "$FOUND" >&2; exit 1
else		# Only pipe output through less when necessary
  [[ `echo "$FOUND"|wc -l` -gt 30 ]] && echo "$FOUND"| less -p 'Package:'
  [[ `echo "$FOUND"|wc -l` -le 30 ]] && echo "$FOUND"; exit
fi
